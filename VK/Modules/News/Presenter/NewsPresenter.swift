//
//  NewsNewsPresenter.swift
//  VK
//
//  Created by Alexey Poponin on 07/02/2019.
//  Copyright © 2019 Aleksei Poponin. All rights reserved.
//

import Foundation

class NewsPresenter {
    private weak var presenterDelegate: NewsPresenterDelegate!
    private weak var moduleView: NewsViewInput!
    private var moduleInteractor: NewsInteractorInput!
}

extension NewsPresenter: NewsPresenterInput {
    var delegate: NewsPresenterDelegate {
        get {
            return presenterDelegate
        }
        set {
            presenterDelegate = newValue
        }
    }
    
    var view: NewsViewInput {
        get {
            return moduleView
        }
        set {
            moduleView = newValue
        }
    }
    
    var interactor: NewsInteractorInput {
        get {
            return moduleInteractor
        }
        set {
            moduleInteractor = newValue
        }
    }
    
    
}

extension NewsPresenter: NewsInteractorOutput {
    func setDataSource(parsedInput: [NewsTableSection]) {
        moduleView.display(sections: parsedInput)
    }
    
    func authorizationRequired() {
        delegate.authorizationRequired()
    }
}

extension NewsPresenter: NewsViewOutput {
    func audioPlayClicked(audioPacket: AudioPacket) {
        interactor.playAudio(audioPacket: audioPacket)
    }
    
    func textChanged(data: String) {
        if(data == "") {
            interactor.getNews()
        } else {
            interactor.searchNews(byText: data)
        }
    }
    
    func viewDidLoad() {
        interactor.loadToken()
        interactor.getNews()
    }
}
