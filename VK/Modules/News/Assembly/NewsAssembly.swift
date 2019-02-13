//
//  NewsNewsAssembly.swift
//  VK
//
//  Created by Alexey Poponin on 07/02/2019.
//  Copyright © 2019 Aleksei Poponin. All rights reserved.
//

import UIKit

class NewsAssembly {
    func build(database: DatabaseServiceInput,
               internetService: InternetServiceInput) -> (controller: UIViewController, presenter: NewsPresenter)? {
        let storyboard = UIStoryboard(name: "NewsStoryboard", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "NewsViewControllerIdentifier")
        guard let moduleVC = rootVC as? NewsViewController else {
            return nil
        }
        
        let presenter = NewsPresenter()
        let interactor = NewsInteractor()
        
        moduleVC.output = presenter
        presenter.interactor = interactor
        presenter.view = moduleVC
        interactor.output = presenter
        
        interactor.database = database
        interactor.internetService = internetService
        
        return(controller: moduleVC, presenter: presenter)
    }
}
