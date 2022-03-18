//
//  NewsListViewController.swift
//  Sectioned-TableView-Using-Reactive-Swift
//
//  Created by Mac on 18/03/22.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

enum NewsHeading: String {
    case business
    case polytics
    case sports
}

class NewsListViewController: UITableViewController {
    // MARK: - Step 1
    private typealias NewsSection = SectionModel<NewsHeading, String>
    
    // MARK: - Step 2
    private let allNews: PublishRelay = PublishRelay<[NewsSection]>()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: - Step 6
        tableView.delegate = nil
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.dataSource = nil
        
        let nib = UINib(nibName: NewsTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: NewsTableViewCell.identifier)
        
        // MARK: - Step 3
        let businessNews  = ["Business News 1", "Business News 2", "Business News 3", "Business News 4"]
        let polyticalNews = ["Polytical News 1", "Polytical News 2", "Polytical News 3", "Polytical News 4"]
        let sportsNews    = ["Sports News 1", "Sports News 2", "Sports News 3", "Sports News 4"]
        
        let businessNewsSection  = NewsSection(model: .business, items: businessNews)
        let polyticalNewsSection = NewsSection(model: .polytics, items: polyticalNews)
        let sportsNewsSection    = NewsSection(model: .sports,   items: sportsNews)
        
        let newsCollections = [businessNewsSection, polyticalNewsSection, sportsNewsSection]
        
        // MARK: - Step 4
        let dataSource = RxTableViewSectionedReloadDataSource<NewsSection>(
            configureCell: { (dataSource, tableView, indexPath, item) in
                let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath)
                cell.textLabel?.text = "Item \(item)"
                return cell
            }
        )
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            let title = dataSource.sectionModels[index].model.self
            return title.rawValue
        }

        // MARK: - Step 5
        allNews.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        allNews.accept(newsCollections)
    }
}
/*
extension NewsListViewController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width - 25, height: 25))
    }
}
*/
