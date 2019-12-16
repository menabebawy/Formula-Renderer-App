//
//  RendererModuleInteractor.swift
//  RendererModule
//
//  Created by MacBook on 12/16/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import NetworkLayer

final class RendererModuleInteractor {
    var interactorToPresenterProtocol: RendererModuleInteractorToPresenter!
    let sessionProvider = URLSessionProvider()
}

// MARK: - Renderer module presenter to interactor

extension RendererModuleInteractor: RendererModulePresenterToInteractor {
    func requestFormulaImage(by text: String) {
        
    }
    
}
