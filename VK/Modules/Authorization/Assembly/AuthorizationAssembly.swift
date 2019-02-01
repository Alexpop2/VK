//
//  AuthorizationAssembly.swift
//  VK
//
//  Created by Рабочий on 01/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import UIKit

class AuthorizationAssembly {
    func build(database: DatabaseServiceInput) -> (controller: UIViewController, presenter: AuthorizationPresenter)? {
        let storyboard = UIStoryboard(name: "AuthorizationStoryboard", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "AuthorizationViewControllerIdentifier")
        guard let authVC = rootVC as? AuthorizationViewController else {
            return nil
        }
        
        let authService = AuthorizationService(controller: authVC)
        let presenter = AuthorizationPresenter()
        let interactor = AuthorizationInteractor()
        
        authVC.output = presenter
        presenter.interactor = interactor
        presenter.view = authVC
        interactor.output = presenter
        
        interactor.authService = authService
        authService.output = interactor
        interactor.database = database
        
        return(controller: authVC, presenter: presenter)
    }
}
