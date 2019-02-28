//
//  ApplicationAssembly.swift
//  VK
//
//  Created by Рабочий on 15/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Swinject

final class ApplicationAssembly {
    
    static let defaultAssembler: Assembler = {
        let assembler = Assembler()
        assembler.apply(assemblies: [
            ManagerAssembly(),
            PresentersAssembly(),
            ServicesAssembly(),
            RoutersAssembly(),
            InteractorsAssembly(),
            ViewsAssembly()
            ])
        return assembler
    }()
    static let resolver = defaultAssembler.resolver
    
}
