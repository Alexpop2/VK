//
//  AuthorizationServiceProtocols.swift
//  VK
//
//  Created by Рабочий on 26/01/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

protocol AuthorizationServiceInput: class, AutoMockable {
    var output: AuthorizationServiceOutput { get set }
    
    func authorize() //запустит vk sdk получит токен,
}

//происходит аутпут в интерактор затем в презентер и показываются новости, а так view controller это заглушка в модуле авторизации
protocol AuthorizationServiceOutput: class, AutoMockable {
    func authorizationCompleted()
    func recieved(token: String)
    func authorizationFailed(withError error: Error)
    func presentAuthorizationScreen(data: AuthorizationData) //если нет установленного VK app , то выводится safari view controller с веб-авторизацией
}
