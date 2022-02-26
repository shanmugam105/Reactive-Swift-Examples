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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkService.shared.makeRequestForUserList { result in
            print(result)
        }
    }
}

