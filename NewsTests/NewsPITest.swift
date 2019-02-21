//
//  NewsTest.swift
//  NewsTests
//
//  Created by Рабочий on 19/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import XCTest
@testable import VK

class NewsPITest: XCTestCase {
    
    var presenter: NewsPresenter!
    var viewControllerInput: NewsViewInputMock!
    var interactor: NewsInteractor!
    var presenterDelegate: NewsPresenterDelegateMock!
    
    override func setUp() {
        super.setUp()
        
        viewControllerInput = NewsViewInputMock()
        presenter = NewsPresenter()
        interactor = NewsInteractor()
        let keyValueStorage = KeyValueStorageInputManualMock()
        presenterDelegate = NewsPresenterDelegateMock()
        let internetService = InternetServiceInputManualMock()
        let newsfeedParser = NewsfeedParser()
        
        viewControllerInput.output = presenter
        presenter.interactor = interactor
        presenter.view = viewControllerInput
        interactor.output = presenter
        
        interactor.keyValueStorage = keyValueStorage
        interactor.internetService = internetService
        interactor.newsfeedParser = newsfeedParser
        
        presenter.delegate = presenterDelegate
    }
    
    func testParseData() {
        
        let expectation = XCTestExpectation(description: "get data async from json")
        
        viewControllerInput.displaySectionsClosure = { (sections) in
            expectation.fulfill()
            for section in sections {
                XCTAssertGreaterThan(section.newsItems.count, 0, "Empty section test")
                for newsItem in section.newsItems {
                    switch newsItem.newsType {
                    case "video":
                        XCTAssertNotNil(newsItem.video, "Empty video test in video type item")
                    case "photo":
                        XCTAssertGreaterThan(newsItem.photos.count, 0, "Empty photos test in photos type item")
                    case "one_photo":
                        XCTAssertNotNil(newsItem.photo, "Empty photo test in full width photo")
                    case "wall_photo":
                        XCTAssertGreaterThan(newsItem.photos.count, 0, "Empty photos test in wall photos type item")
                    default:
                        continue
                    }
                }
            }
        }
        
        interactor.getNews()
        
        wait(for: [expectation], timeout: 10.0)
    }
}
