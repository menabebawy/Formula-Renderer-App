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
        rendererViewController.delegate = self
        navigationController.viewControllers = [rendererViewController]
    }

}

// MARK: - Renderer module view controller delegate

extension RendererCoordinator: RendererModuleViewControllerDelegate {
    func showErrorAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        navigationController.topViewController?.present(alertController, animated: true, completion: nil)
    }
    
    func showActivityController(text: String, image: UIImage) {
        let vc = UIActivityViewController(activityItems: [text, image], applicationActivities: [])
        navigationController.topViewController?.present(vc, animated: true)
    }
    
}
