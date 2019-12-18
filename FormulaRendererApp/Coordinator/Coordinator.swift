//
//  Coordinator.swift
//  FormulaRendererApp
//
//  Created by MacBook on 12/16/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit

protocol Coordinator : class {
    var childCoordinators: [Coordinator] { get set }
    
    init(navigationController:UINavigationController)
    func start()
}
