//
//  RendererCoordinator.swift
//  FormulaRendererApp
//
//  Created by MacBook on 12/16/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit
import RendererModule

final class RendererCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    unowned let navigationController:UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let nibName = String(describing: RendererModuleViewController.self)
        let rendererViewController = RendererModuleViewController(nibName: nibName, bundle: .main)
        navigationController.viewControllers = [rendererViewController]
    }

}
