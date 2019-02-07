//
//  ModulesCoordinator.swift
//  VK
//
//  Created by Рабочий on 01/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import UIKit
import VK_ios_sdk

class ModulesCoordinator {
    
    private var navigationController: UINavigationController!
    //private var tabBarController: UITabBarController
    
    lazy private var controllerPackageBuilder: ControllerPackageBuilderProtocol = ControllerPackageBuilder(modulesCoordinator: self)
    private var presenterArray : [MainPresenter] = []
    private var viewControllers : [UIViewController] = []
    
    init() {
        //self.tabBarController = UITabBarController()
    }
    
    func rootModuleController() -> UIViewController {
        presentAuthorizationView()
        
        //self.navigationController = UINavigationController(rootViewController: viewControllers[0])
        //navigationController.navigationBar.prefersLargeTitles = true
        
        return viewControllers[0]
    }
    
    private func removeFromPresenterArray<T>(_ : T.Type){
        for i in 0..<presenterArray.count {
            guard presenterArray[i] is (T) else {continue}
            presenterArray.remove(at: i)
        }
    }
    
    private func findPresenter<T>(_: T.Type) -> (T?){
        var presenter:(T)?
        for i in 0..<presenterArray.count {
            guard let find = presenterArray[i] as? (T) else { continue}
            presenter = find
        }
        return presenter
    }
    
    private func findViewController<T>(_: T.Type) -> (T?){
        var controller:(T)?
        for i in 0..<viewControllers.count {
            guard let find = viewControllers[i] as? (T) else { continue}
            controller = find
        }
        return controller
    }
    
    private func presentController(type: ViewControllers, push: Bool){
        guard let controllerPackage = controllerPackageBuilder.createPackage(type: type) else {return}
        presenterArray.append(controllerPackage.presenter)
        viewControllers.append(controllerPackage.controller)
        if(push) {
            navigationController.pushViewController(controllerPackage.controller, animated: true)
        }
    }
    
    private func presentController(controller: UIViewController) {
        navigationController.pushViewController(controller, animated: true)
    }
    
}

extension ModulesCoordinator: AuthorizationPresenterDelegate {
    func vkSdkShouldPresent(controller: UIViewController) {
        presentController(controller: controller)
    }
    
    func authorizationCompleted() {
        print("coordinator: auth completed")
    }
}

extension ModulesCoordinator: RoutingAuthorizationView {
    func presentAuthorizationView() {
        presentController(type: .authorization, push: false)
    }
}
