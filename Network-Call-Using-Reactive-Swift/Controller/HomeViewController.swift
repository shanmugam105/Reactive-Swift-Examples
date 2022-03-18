//
//  HomeViewController.swift
//  Network-Call-Using-Reactive-Swift
//
//  Created by Mac on 14/01/22.
//

import UIKit
import RxSwift
import RxCocoa

class UsersListViewController: UITableViewController {
    let disposeBag = DisposeBag()
    let userListRelay: PublishRelay = PublishRelay<[User]>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkService.shared.makeRequestForUserList().subscribe { result in
            switch result {
            case .success(let users): self.userListRelay.accept(users)
            case .failure(_): break
            }
        } onError: { error in
            DispatchQueue.main.async {
                self.present(error)
            }
        } onCompleted: {
            DispatchQueue.main.async {
                self.presentAlert(with: "Successfully fetched!")
            }
        } onDisposed: {
            print("Sequence finished successfully!")
        }.disposed(by: disposeBag)
        
        tableView.delegate = nil
        
        tableView
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        tableView.dataSource = nil
        
        userListRelay.bind(to: tableView.rx.items(cellIdentifier: "cell",
                                                  cellType: UITableViewCell.self)){ row, item, cell in
            cell.textLabel?.text = item.name
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(User.self).bind { user in
            DispatchQueue.main.async {
                self.presentAlert(with: "Hello, " + user.name + "!")
            }
        }
    }
}

extension UsersListViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}
