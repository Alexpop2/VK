//
//  NewsNewsPresenterProtocols.swift
//  VK
//
//  Created by Alexey Poponin on 07/02/2019.
//  Copyright © 2019 Aleksei Poponin. All rights reserved.
//

import Foundation

protocol NewsPresenterInput: class, AutoMockable {
    var delegate: NewsPresenterDelegate { get set }
    var view: NewsViewInput { get set }
    var interactor: NewsInteractorInput { get set }
}

protocol NewsPresenterDelegate: class, AutoMockable {
    func authorizationRequired()
}
