//
//  ApplicationCoordinator.swift
//  Eventer
//
//  Created by Ярослав Магин on 07.01.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import Foundation
import InoMvvmc
import Swinject

fileprivate enum ApplicationAssembly {
    
    static var assemblies: [Assembly] = {
        return  [
            MainCoordinatorAssembly()
        ]
    }()
}

class ApplicationCoordinator: BaseCoordinator<Void> {
    
    override init() {
        super.init()
        
        assembler = Assembler(assemblies())
    }
    
    override func assemblies() -> [Assembly] {
        return ApplicationAssembly.assemblies
    }
    
    override func start() {
        let coordinator = resolver.resolve(MainCoordinator.self)!
        
        coordinate(to: coordinator)
    }
}
