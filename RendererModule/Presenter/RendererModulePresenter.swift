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
        // A local validation to enable/disbale render button due to preventing
        formulaTextValid(text) ? view.enableRenderButton() : view.disableRenderButton()
    }
    
    func requestFormulaImage(by text: String) {
        if text.isEmpty {
            view.failedToGetFormaulaWithError(message: "Text is empty!.")
            return
        }
        view.willRequestFormulaImage()
        interactor.requestFormulaImage(by: shape(text))
    }
    
    func viewIsReady() {
        view.viewLoaded()
    }
    
    func shareFormula(text: String) {
        view.showActivityController(text: shape(text))
    }
    
    /// Use to shape formula text before sent to endpoint
    ///
    /// - Parameter text: input field text entered by user
    /// - Returns: text without any spaces from both sides, new lines and between spaces
    private func shape(_ text: String) -> String {
        return text.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "")
    }
    
    private func formulaTextValid(_ text: String) -> Bool {
        return !text.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
}

// MARK: - Renderer module interactor to presenter

extension RendererModulePresenter: RendererModuleInteractorToPresenter {
    func formulaData(_ data: Data) {
        view.showFormulaImage(data: data)
    }
    
    func error(message: String) {
        view.failedToGetFormaulaWithError(message: message)
    }
    
}
