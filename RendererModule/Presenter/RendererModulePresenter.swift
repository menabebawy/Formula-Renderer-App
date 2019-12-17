//
//  RendererModulePresenter.swift
//  RendererModule
//
//  Created by MacBook on 12/16/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

final class RendererModulePresenter {
    weak var view: RenderModulePresenterToView!
    var interactor: RendererModulePresenterToInteractor!
}

// MARK: - Renderer module view to presenter

extension RendererModulePresenter: RendererModuleViewToPresenter {
    func didChangeFormulaTextField(text: String) {
        // A local validation to enable/disbale render button
        text.count >= 1 ? view.enableRenderButton() : view.disableRenderButton()
    }
    
    func requestFormulaImage(by text: String) {
        if text.isEmpty {
            view.failedToGetFormaulaWithError(message: "Text is empty!.")
            return
        }
        view.willRequestFormulaImage()
        interactor.requestFormulaImage(by: text)
    }
    
    func viewIsReady() {
        view.viewLoaded()
    }
    
}

// MARK: - Renderer module interactor to presenter

extension RendererModulePresenter: RendererModuleInteractorToPresenter {
    func formulaData(_ data: Data) {
        DispatchQueue.main.async {
            self.view.showFormulaImage(data: data)
        }
    }
    
    func error(message: String) {
        DispatchQueue.main.async {
            self.view.failedToGetFormaulaWithError(message: message)
        }
    }
    
}
