//
//  RendererModuleConfigurator.swift
//  RendererModule
//
//  Created by MacBook on 12/16/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import Foundation

final class RendererModuleConfigurator {
    
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? RendererModuleViewController {
            configure(viewController: viewController)
        }
    }
    
    private func configure(viewController: RendererModuleViewController) {
        let presenter = RendererModulePresenter()
        presenter.view = viewController
        
        let interactor = RendererModuleInteractor()
        interactor.interactorToPresenterProtocol = presenter
        
        presenter.interactor = interactor
        viewController.viewToPresenterProtocol = presenter
    }
}
