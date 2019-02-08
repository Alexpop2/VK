//
//  NewsNewsViewController.swift
//  VK
//
//  Created by Alexey Poponin on 07/02/2019.
//  Copyright © 2019 Aleksei Poponin. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    private var viewOutput: NewsViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
