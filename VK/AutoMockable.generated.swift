// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif













class AuthorizationInteractorInputMock: AuthorizationInteractorInput {
    var output: AuthorizationInteractorOutput {
        get { return underlyingOutput }
        set(value) { underlyingOutput = value }
    }
    var underlyingOutput: AuthorizationInteractorOutput!

    //MARK: - authorize

    var authorizeCallsCount = 0
    var authorizeCalled: Bool {
        return authorizeCallsCount > 0
    }
    var authorizeClosure: (() -> Void)?

    func authorize() {
        authorizeCallsCount += 1
        authorizeClosure?()
    }

}
class AuthorizationInteractorOutputMock: AuthorizationInteractorOutput {

    //MARK: - authorizationCompleted

    var authorizationCompletedCallsCount = 0
    var authorizationCompletedCalled: Bool {
        return authorizationCompletedCallsCount > 0
    }
    var authorizationCompletedClosure: (() -> Void)?

    func authorizationCompleted() {
        authorizationCompletedCallsCount += 1
        authorizationCompletedClosure?()
    }

    //MARK: - authorizationFailed

    var authorizationFailedWithErrorCallsCount = 0
    var authorizationFailedWithErrorCalled: Bool {
        return authorizationFailedWithErrorCallsCount > 0
    }
    var authorizationFailedWithErrorReceivedError: Error?
    var authorizationFailedWithErrorClosure: ((Error) -> Void)?

    func authorizationFailed(withError error: Error) {
        authorizationFailedWithErrorCallsCount += 1
        authorizationFailedWithErrorReceivedError = error
        authorizationFailedWithErrorClosure?(error)
    }

    //MARK: - presentAuthorizationScreen

    var presentAuthorizationScreenDataCallsCount = 0
    var presentAuthorizationScreenDataCalled: Bool {
        return presentAuthorizationScreenDataCallsCount > 0
    }
    var presentAuthorizationScreenDataReceivedData: AuthorizationData?
    var presentAuthorizationScreenDataClosure: ((AuthorizationData) -> Void)?

    func presentAuthorizationScreen(data: AuthorizationData) {
        presentAuthorizationScreenDataCallsCount += 1
        presentAuthorizationScreenDataReceivedData = data
        presentAuthorizationScreenDataClosure?(data)
    }

}
class AuthorizationPresenterDelegateMock: AuthorizationPresenterDelegate {

    //MARK: - authorizationCompleted

    var authorizationCompletedCallsCount = 0
    var authorizationCompletedCalled: Bool {
        return authorizationCompletedCallsCount > 0
    }
    var authorizationCompletedClosure: (() -> Void)?

    func authorizationCompleted() {
        authorizationCompletedCallsCount += 1
        authorizationCompletedClosure?()
    }

}
class AuthorizationPresenterInputMock: AuthorizationPresenterInput {
    var delegate: AuthorizationPresenterDelegate {
        get { return underlyingDelegate }
        set(value) { underlyingDelegate = value }
    }
    var underlyingDelegate: AuthorizationPresenterDelegate!
    var view: AuthorizationViewInput {
        get { return underlyingView }
        set(value) { underlyingView = value }
    }
    var underlyingView: AuthorizationViewInput!
    var interactor: AuthorizationInteractorInput {
        get { return underlyingInteractor }
        set(value) { underlyingInteractor = value }
    }
    var underlyingInteractor: AuthorizationInteractorInput!

}
class AuthorizationRouterMock: AuthorizationRouter {

    //MARK: - getConfiguredRootViewController

    var getConfiguredRootViewControllerCallsCount = 0
    var getConfiguredRootViewControllerCalled: Bool {
        return getConfiguredRootViewControllerCallsCount > 0
    }
    var getConfiguredRootViewControllerReturnValue: UIViewController!
    var getConfiguredRootViewControllerClosure: (() -> UIViewController)?

    func getConfiguredRootViewController() -> UIViewController {
        getConfiguredRootViewControllerCallsCount += 1
        return getConfiguredRootViewControllerClosure.map({ $0() }) ?? getConfiguredRootViewControllerReturnValue
    }

    //MARK: - route

    var routeToCallsCount = 0
    var routeToCalled: Bool {
        return routeToCallsCount > 0
    }
    var routeToReceivedTo: AuthorizationRoute?
    var routeToClosure: ((AuthorizationRoute) -> Void)?

    func route(to: AuthorizationRoute) {
        routeToCallsCount += 1
        routeToReceivedTo = to
        routeToClosure?(to)
    }

}
class AuthorizationServiceInputMock: AuthorizationServiceInput {
    var output: AuthorizationServiceOutput {
        get { return underlyingOutput }
        set(value) { underlyingOutput = value }
    }
    var underlyingOutput: AuthorizationServiceOutput!

    //MARK: - authorize

    var authorizeCallsCount = 0
    var authorizeCalled: Bool {
        return authorizeCallsCount > 0
    }
    var authorizeClosure: (() -> Void)?

    func authorize() {
        authorizeCallsCount += 1
        authorizeClosure?()
    }

}
class AuthorizationServiceOutputMock: AuthorizationServiceOutput {

    //MARK: - authorizationCompleted

    var authorizationCompletedCallsCount = 0
    var authorizationCompletedCalled: Bool {
        return authorizationCompletedCallsCount > 0
    }
    var authorizationCompletedClosure: (() -> Void)?

    func authorizationCompleted() {
        authorizationCompletedCallsCount += 1
        authorizationCompletedClosure?()
    }

    //MARK: - recieved

    var recievedTokenCallsCount = 0
    var recievedTokenCalled: Bool {
        return recievedTokenCallsCount > 0
    }
    var recievedTokenReceivedToken: String?
    var recievedTokenClosure: ((String) -> Void)?

    func recieved(token: String) {
        recievedTokenCallsCount += 1
        recievedTokenReceivedToken = token
        recievedTokenClosure?(token)
    }

    //MARK: - authorizationFailed

    var authorizationFailedWithErrorCallsCount = 0
    var authorizationFailedWithErrorCalled: Bool {
        return authorizationFailedWithErrorCallsCount > 0
    }
    var authorizationFailedWithErrorReceivedError: Error?
    var authorizationFailedWithErrorClosure: ((Error) -> Void)?

    func authorizationFailed(withError error: Error) {
        authorizationFailedWithErrorCallsCount += 1
        authorizationFailedWithErrorReceivedError = error
        authorizationFailedWithErrorClosure?(error)
    }

    //MARK: - presentAuthorizationScreen

    var presentAuthorizationScreenDataCallsCount = 0
    var presentAuthorizationScreenDataCalled: Bool {
        return presentAuthorizationScreenDataCallsCount > 0
    }
    var presentAuthorizationScreenDataReceivedData: AuthorizationData?
    var presentAuthorizationScreenDataClosure: ((AuthorizationData) -> Void)?

    func presentAuthorizationScreen(data: AuthorizationData) {
        presentAuthorizationScreenDataCallsCount += 1
        presentAuthorizationScreenDataReceivedData = data
        presentAuthorizationScreenDataClosure?(data)
    }

}
class AuthorizationViewInputMock: AuthorizationViewInput {
    var output: AuthorizationViewOutput {
        get { return underlyingOutput }
        set(value) { underlyingOutput = value }
    }
    var underlyingOutput: AuthorizationViewOutput!

    //MARK: - showAuthScreen

    var showAuthScreenDataCallsCount = 0
    var showAuthScreenDataCalled: Bool {
        return showAuthScreenDataCallsCount > 0
    }
    var showAuthScreenDataReceivedData: AuthorizationData?
    var showAuthScreenDataClosure: ((AuthorizationData) -> Void)?

    func showAuthScreen(data: AuthorizationData) {
        showAuthScreenDataCallsCount += 1
        showAuthScreenDataReceivedData = data
        showAuthScreenDataClosure?(data)
    }

}
class AuthorizationViewOutputMock: AuthorizationViewOutput {

    //MARK: - viewDidAppear

    var viewDidAppearCallsCount = 0
    var viewDidAppearCalled: Bool {
        return viewDidAppearCallsCount > 0
    }
    var viewDidAppearClosure: (() -> Void)?

    func viewDidAppear() {
        viewDidAppearCallsCount += 1
        viewDidAppearClosure?()
    }

}
class NewsInteractorInputMock: NewsInteractorInput {
    var output: NewsInteractorOutput {
        get { return underlyingOutput }
        set(value) { underlyingOutput = value }
    }
    var underlyingOutput: NewsInteractorOutput!

    //MARK: - loadToken

    var loadTokenCallsCount = 0
    var loadTokenCalled: Bool {
        return loadTokenCallsCount > 0
    }
    var loadTokenClosure: (() -> Void)?

    func loadToken() {
        loadTokenCallsCount += 1
        loadTokenClosure?()
    }

    //MARK: - getNews

    var getNewsCallsCount = 0
    var getNewsCalled: Bool {
        return getNewsCallsCount > 0
    }
    var getNewsClosure: (() -> Void)?

    func getNews() {
        getNewsCallsCount += 1
        getNewsClosure?()
    }

}
class NewsInteractorOutputMock: NewsInteractorOutput {

    //MARK: - authorizationRequired

    var authorizationRequiredCallsCount = 0
    var authorizationRequiredCalled: Bool {
        return authorizationRequiredCallsCount > 0
    }
    var authorizationRequiredClosure: (() -> Void)?

    func authorizationRequired() {
        authorizationRequiredCallsCount += 1
        authorizationRequiredClosure?()
    }

    //MARK: - setDataSource

    var setDataSourceParsedInputCallsCount = 0
    var setDataSourceParsedInputCalled: Bool {
        return setDataSourceParsedInputCallsCount > 0
    }
    var setDataSourceParsedInputReceivedParsedInput: [NewsTableSection]?
    var setDataSourceParsedInputClosure: (([NewsTableSection]) -> Void)?

    func setDataSource(parsedInput: [NewsTableSection]) {
        setDataSourceParsedInputCallsCount += 1
        setDataSourceParsedInputReceivedParsedInput = parsedInput
        setDataSourceParsedInputClosure?(parsedInput)
    }

}
class NewsPresenterDelegateMock: NewsPresenterDelegate {

    //MARK: - authorizationRequired

    var authorizationRequiredCallsCount = 0
    var authorizationRequiredCalled: Bool {
        return authorizationRequiredCallsCount > 0
    }
    var authorizationRequiredClosure: (() -> Void)?

    func authorizationRequired() {
        authorizationRequiredCallsCount += 1
        authorizationRequiredClosure?()
    }

}
class NewsPresenterInputMock: NewsPresenterInput {
    var delegate: NewsPresenterDelegate {
        get { return underlyingDelegate }
        set(value) { underlyingDelegate = value }
    }
    var underlyingDelegate: NewsPresenterDelegate!
    var view: NewsViewInput {
        get { return underlyingView }
        set(value) { underlyingView = value }
    }
    var underlyingView: NewsViewInput!
    var interactor: NewsInteractorInput {
        get { return underlyingInteractor }
        set(value) { underlyingInteractor = value }
    }
    var underlyingInteractor: NewsInteractorInput!

}
class NewsRouterMock: NewsRouter {

    //MARK: - getConfiguredRootViewController

    var getConfiguredRootViewControllerCallsCount = 0
    var getConfiguredRootViewControllerCalled: Bool {
        return getConfiguredRootViewControllerCallsCount > 0
    }
    var getConfiguredRootViewControllerReturnValue: UIViewController!
    var getConfiguredRootViewControllerClosure: (() -> UIViewController)?

    func getConfiguredRootViewController() -> UIViewController {
        getConfiguredRootViewControllerCallsCount += 1
        return getConfiguredRootViewControllerClosure.map({ $0() }) ?? getConfiguredRootViewControllerReturnValue
    }

    //MARK: - route

    var routeToCallsCount = 0
    var routeToCalled: Bool {
        return routeToCallsCount > 0
    }
    var routeToReceivedTo: NewsRoute?
    var routeToClosure: ((NewsRoute) -> Void)?

    func route(to: NewsRoute) {
        routeToCallsCount += 1
        routeToReceivedTo = to
        routeToClosure?(to)
    }

}
class NewsViewInputMock: NewsViewInput {
    var output: NewsViewOutput {
        get { return underlyingOutput }
        set(value) { underlyingOutput = value }
    }
    var underlyingOutput: NewsViewOutput!

    //MARK: - display

    var displaySectionsCallsCount = 0
    var displaySectionsCalled: Bool {
        return displaySectionsCallsCount > 0
    }
    var displaySectionsReceivedSections: [NewsTableSection]?
    var displaySectionsClosure: (([NewsTableSection]) -> Void)?

    func display(sections: [NewsTableSection]) {
        displaySectionsCallsCount += 1
        displaySectionsReceivedSections = sections
        displaySectionsClosure?(sections)
    }

}
class NewsViewOutputMock: NewsViewOutput {

    //MARK: - viewDidLoad

    var viewDidLoadCallsCount = 0
    var viewDidLoadCalled: Bool {
        return viewDidLoadCallsCount > 0
    }
    var viewDidLoadClosure: (() -> Void)?

    func viewDidLoad() {
        viewDidLoadCallsCount += 1
        viewDidLoadClosure?()
    }

}
class RoutingAuthorizationViewMock: RoutingAuthorizationView {

    //MARK: - presentAuthorizationView

    var presentAuthorizationViewCallsCount = 0
    var presentAuthorizationViewCalled: Bool {
        return presentAuthorizationViewCallsCount > 0
    }
    var presentAuthorizationViewClosure: (() -> Void)?

    func presentAuthorizationView() {
        presentAuthorizationViewCallsCount += 1
        presentAuthorizationViewClosure?()
    }

}
