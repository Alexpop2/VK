//
//  NewsNewsViewController.swift
//  VK
//
//  Created by Alexey Poponin on 07/02/2019.
//  Copyright © 2019 Aleksei Poponin. All rights reserved.
//

import UIKit

// MARK: - UITableViewController with UISearchController included

class NewsViewController: UITableViewController {

    private var viewOutput: NewsViewOutput!
    
    //@IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    private var searchController: UISearchController!
    
    private let newsTitleTableViewCellNib = UINib(nibName: "NewsTitleTableViewCell", bundle: nil)
    private let newsTitleReusableCellIdentifier = "NewsTitleCellReusableIdentifier"
    
    private let newsTextTableViewCellNib = UINib(nibName: "NewsTextTableViewCell", bundle: nil)
    private let newsTextReusableCellIdentifier = "NewsTextCellReusableIdentifier"
    
    private let newsEmptyReusableCellIdentifier = "NewsEmptyCellReusableIdentifier"
    
    private let newsPhotoTableViewCellNib = UINib(nibName: "NewsPhotoTableViewCell", bundle: nil)
    private let newsPhotoReusableCellIdentifier = "NewsPhotoCellReusableIdentifier"
    
    private let newsWallPhotoTableViewCellNib = UINib(nibName: "NewsWallPhotoTableViewCell", bundle: nil)
    private let newsWallPhotoReusableCellIdentifier = "NewsWallPhotoCellReusableIdentifier"
    
    private let newsVideoTableViewCellNib = UINib(nibName: "NewsVideoTableViewCell", bundle: nil)
    private let newsVideoReusableCellIdentifier = "NewsVideoCellReusableIdentifier"
    
    private let newsFooterTableViewCellNib = UINib(nibName: "NewsFooterTableViewCell", bundle: nil)
    private let newsFooterReusableCellIdentifier = "NewsFooterCellReusableIdentifier"
    
    private var dataSource = [NewsItem]()
    
    private var sections = [NewsTableSection]()
    private var searchSections = [NewsTableSection]()
    private var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        viewOutput.viewDidLoad()
        //display(newsItems: [NewsItem(text: "1", newsType: "post")])
    }

}


// MARK: - Setting up UI for custom tableView cell

extension NewsViewController {
    private func setUpUI() {
        tableView.register(newsTitleTableViewCellNib, forCellReuseIdentifier: newsTitleReusableCellIdentifier)
        tableView.register(newsTextTableViewCellNib, forCellReuseIdentifier: newsTextReusableCellIdentifier)
        tableView.register(newsPhotoTableViewCellNib, forCellReuseIdentifier: newsPhotoReusableCellIdentifier)
        tableView.register(newsWallPhotoTableViewCellNib, forCellReuseIdentifier: newsWallPhotoReusableCellIdentifier)
        tableView.register(newsVideoTableViewCellNib, forCellReuseIdentifier: newsVideoReusableCellIdentifier)
        tableView.register(newsFooterTableViewCellNib, forCellReuseIdentifier: newsFooterReusableCellIdentifier)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = 10
        tableView.sectionFooterHeight = 10
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func createUIViewSeparator(y: CGFloat) -> UIView {
        let result = UIView()
        
        let width = tableView.bounds.width
        let sepFrame = CGRect(x: 0, y: y, width: width, height: 0.5)
        
        let sep = CALayer()
        sep.frame = sepFrame
        sep.backgroundColor = tableView.separatorColor?.cgColor
        result.layer.addSublayer(sep)
        
        return result
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
    
    func display(sections: [NewsTableSection]) {
        self.sections = sections
        self.tableView.reloadData()
    }
}

extension NewsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].newsItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = self.sections[indexPath.section]
        let newsElement = section.newsItems[indexPath.row]
        switch newsElement.newsType {
        case .title:
            let cell = tableView.dequeueReusableCell(withIdentifier: newsTitleReusableCellIdentifier) as! NewsTitleTableViewCell
            cell.viewModel = newsElement
            return cell
        case .post:
            if(newsElement.text != "") {
                let cell = tableView.dequeueReusableCell(withIdentifier: newsTextReusableCellIdentifier) as! NewsTextTableViewCell
                cell.viewModel = newsElement
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: newsEmptyReusableCellIdentifier)! as UITableViewCell
                //cell.isHidden = true
                return cell
            }
        case .photo:
            let cell = tableView.dequeueReusableCell(withIdentifier: newsPhotoReusableCellIdentifier) as! NewsPhotoTableViewCell
            cell.viewModel = newsElement
            return cell
        case .wall_photo:
            let cell = tableView.dequeueReusableCell(withIdentifier: newsPhotoReusableCellIdentifier) as! NewsPhotoTableViewCell
            cell.viewModel = newsElement
            return cell
        case .one_photo:
            let cell = tableView.dequeueReusableCell(withIdentifier: newsWallPhotoReusableCellIdentifier) as! NewsWallPhotoTableViewCell
            cell.viewModel = newsElement
            return cell
        case .video:
            let cell = tableView.dequeueReusableCell(withIdentifier: newsVideoReusableCellIdentifier) as! NewsVideoTableViewCell
            cell.viewModel = newsElement
            return cell
        case .like_repost:
            let cell = tableView.dequeueReusableCell(withIdentifier: newsFooterReusableCellIdentifier) as! NewsFooterTableViewCell
            cell.separatorInset = UIEdgeInsets(top: CGFloat(10), left: CGFloat(10), bottom: CGFloat(10), right: CGFloat(10))
            cell.viewModel = newsElement
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: newsEmptyReusableCellIdentifier)! as UITableViewCell
            //cell.isHidden = true
            return cell
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = self.sections[indexPath.section]
        let viewModel = section.newsItems[indexPath.row]
        switch viewModel.newsType {
        case .title:
            return UITableView.automaticDimension
        case .post:
            if(viewModel.text == "") {
                return 0
            }
            return UITableView.automaticDimension
        case .photo:
            return UITableView.automaticDimension
        case .wall_photo:
            return UITableView.automaticDimension
        case .one_photo:
            if(viewModel.widthWallPhoto == 0) {
                return UITableView.automaticDimension
            }
            let height = CGFloat(((Float(viewModel.heightWallPhoto)) / (Float(viewModel.widthWallPhoto)))) * UIScreen.main.bounds.width
            if(height <= 0) {
                return UITableView.automaticDimension
            }
            return height
        case .video:
            if(viewModel.widthVideoFrame == 0) {
                return UITableView.automaticDimension
            }
            let height = CGFloat(((Float(viewModel.heightVideoFrame)) / (Float(viewModel.widthVideoFrame)))) * UIScreen.main.bounds.width
            if(height <= 0) {
                return UITableView.automaticDimension
            }
            return height
        case .like_repost:
            return 63
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0) {
            //return CGFloat.leastNormalMagnitude
        }
        return 10
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(section == 0) {
            //return createUIViewSeparator(y: 0)
        }
        return createUIViewSeparator(y: 9.5)
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return createUIViewSeparator(y: -0.5)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
    }
    
}

extension NewsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        output.textChanged(data: searchText)
    }
}

extension NewsViewController: UISearchDisplayDelegate {
    
}
