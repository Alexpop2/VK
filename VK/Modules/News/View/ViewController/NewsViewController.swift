//
//  NewsNewsViewController.swift
//  VK
//
//  Created by Alexey Poponin on 07/02/2019.
//  Copyright © 2019 Aleksei Poponin. All rights reserved.
//

import UIKit

class NewsViewController: UITableViewController {

    private var viewOutput: NewsViewOutput!
    
    //@IBOutlet weak var tableView: UITableView!
    
    private let newsTitleTableViewCellNib = UINib(nibName: "NewsTitleTableViewCell", bundle: nil)
    private let newsTitleReusableCellIdentifier = "NewsTitleCellReusableIdentifier"
    
    private let newsTextTableViewCellNib = UINib(nibName: "NewsTextTableViewCell", bundle: nil)
    private let newsTextReusableCellIdentifier = "NewsTextCellReusableIdentifier"
    
    private let newsEmptyReusableCellIdentifier = "NewsEmptyCellReusableIdentifier"
    
    private let newsPhotoTableViewCellNib = UINib(nibName: "NewsPhotoTableViewCell", bundle: nil)
    private let newsPhotoReusableCellIdentifier = "NewsPhotoCellReusableIdentifier"
    
    private let newsWallPhotoTableViewCellNib = UINib(nibName: "NewsWallPhotoTableViewCell", bundle: nil)
    private let newsWallPhotoReusableCellIdentifier = "NewsWallPhotoCellReusableIdentifier"
    
    private var dataSource = [NewsItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    
        setUpUI()
        viewOutput.viewDidLoad()
        //display(newsItems: [NewsItem(text: "1", newsType: "post")])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

}


// MARK: - Setting up UI for custom tableView cell

extension NewsViewController {
    private func setUpUI() {
        tableView.register(newsTitleTableViewCellNib, forCellReuseIdentifier: newsTitleReusableCellIdentifier)
        tableView.register(newsTextTableViewCellNib, forCellReuseIdentifier: newsTextReusableCellIdentifier)
        tableView.register(newsPhotoTableViewCellNib, forCellReuseIdentifier: newsPhotoReusableCellIdentifier)
        tableView.register(newsWallPhotoTableViewCellNib, forCellReuseIdentifier: newsWallPhotoReusableCellIdentifier)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension NewsViewController: NewsViewInput {
    var output: NewsViewOutput {
        get {
            return viewOutput
        }
        set {
            viewOutput = newValue
        }
    }
    
    func display(newsItems: [NewsItem]) {
        dataSource = newsItems
        self.tableView.reloadData()
    }
}

extension NewsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource[indexPath.row].newsType {
        case "title":
            let cell = tableView.dequeueReusableCell(withIdentifier: newsTitleReusableCellIdentifier) as! NewsTitleTableViewCell
            cell.viewModel = dataSource[indexPath.row]
            return cell
        case "post":
            if(dataSource[indexPath.row].text != "") {
                let cell = tableView.dequeueReusableCell(withIdentifier: newsTextReusableCellIdentifier) as! NewsTextTableViewCell
                cell.viewModel = dataSource[indexPath.row]
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: newsEmptyReusableCellIdentifier)! as UITableViewCell
                //cell.isHidden = true
                return cell
            }
        case "photo":
            let cell = tableView.dequeueReusableCell(withIdentifier: newsPhotoReusableCellIdentifier) as! NewsPhotoTableViewCell
            cell.viewModel = dataSource[indexPath.row]
            return cell
        case "wall_photo":
            let cell = tableView.dequeueReusableCell(withIdentifier: newsPhotoReusableCellIdentifier) as! NewsPhotoTableViewCell
            cell.viewModel = dataSource[indexPath.row]
            return cell
        case "one_photo":
            let cell = tableView.dequeueReusableCell(withIdentifier: newsWallPhotoReusableCellIdentifier) as! NewsWallPhotoTableViewCell
            cell.viewModel = dataSource[indexPath.row]
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: newsEmptyReusableCellIdentifier)! as UITableViewCell
            //cell.isHidden = true
            return cell
        }
    }
    
}

extension NewsViewController {
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let viewModel = dataSource[indexPath.row]
        switch viewModel.newsType {
        case "title":
            return UITableView.automaticDimension
        case "post":
            if(viewModel.text == "") {
                return 0
            }
            return UITableView.automaticDimension
        case "photo":
            return UITableView.automaticDimension
        case "wall_photo":
            return UITableView.automaticDimension
        case "one_photo":
            let height = CGFloat(((Float(viewModel.heightWallPhoto)) / (Float(viewModel.widthWallPhoto)))) * UIScreen.main.bounds.width
            return height
        default:
            return 0
        }
    }
}
