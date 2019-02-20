//
//  Router.swift
//  AuthorizationTests
//
//  Created by Рабочий on 19/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import XCTest
@testable import VK

class AuthorizationPresenterInteractorTest: XCTestCase {
    
    var presenter: AuthorizationPresenter!
    var viewControllerInput: AuthorizationViewInputMock!
    var interactor: AuthorizationInteractor!
    var presenterDelegate: AuthorizationPresenterDelegateMock!
    
    override func setUp() {
        super.setUp()
        
        viewControllerInput = AuthorizationViewInputMock()
        presenter = AuthorizationPresenter()
        interactor = AuthorizationInteractor()
        let keyValueStorage = KeyValueStorageInputManualMock()
        let authService = AuthorizationServiceInputMock()
        presenterDelegate = AuthorizationPresenterDelegateMock()
        
        viewControllerInput.output = presenter
        presenter.interactor = interactor
        presenter.view = viewControllerInput
        interactor.output = presenter
        
        interactor.authService = authService
        authService.output = interactor
        interactor.keyValueStorage = keyValueStorage

        presenter.delegate = presenterDelegate
    }
    
    func testAuthCompleted() {
        interactor.authorizationCompleted()
        XCTAssertTrue(presenterDelegate.authorizationCompletedCalled, "Authorization completed delegate test")
    }
    
    func testPresentAuthScreen() {
        let authData = AuthorizationData(authorizationViewController: UIViewController())
        interactor.presentAuthorizationScreen(data: authData)
        XCTAssertEqual(viewControllerInput.showAuthScreenDataReceivedData!.authorizationViewController,
                       authData.authorizationViewController)
    }
    
}
