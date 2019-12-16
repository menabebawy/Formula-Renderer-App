//
//  RendererModulePresenter.swift
//  RendererModule
//
//  Created by MacBook on 12/16/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit

final class RendererModulePresenter {
    weak var view: RenderModulePresenterToView!
    var interactor: RendererModulePresenterToInteractor!
}

// MARK: - Renderer module view to presenter

extension RendererModulePresenter: RendererModuleViewToPresenter {
    func didChangeFormulaTextField(text: String) {
        // A local validation to enable/disbale render button
        view.enableRenderButton(enable: text.count >= 1)
    }
    
    func requestFormulaImage(by text: String) {
    }
    
    func viewIsReady() {
        view.viewLoaded()
    }
    
}

// MARK: - Renderer module interactor to presenter

extension RendererModulePresenter: RendererModuleInteractorToPresenter {
    func loadFormula(image: UIImage) {
        view.showFormulaImage(image)
    }
    
    func error(message: String) {
        view.showErrorAlert(message: message)
    }
    
}
