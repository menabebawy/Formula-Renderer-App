//
//  RendererModuleInteractor.swift
//  RendererModule
//
//  Created by MacBook on 12/16/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import NetworkLayer
import Entities

final class RendererModuleInteractor {
    var interactorToPresenterProtocol: RendererModuleInteractorToPresenter!
    let sessionProvider = URLSessionProvider()
}

// MARK: - Renderer module presenter to interactor

extension RendererModuleInteractor: RendererModulePresenterToInteractor {
    func requestFormulaImage(by text: String) {
        requestResourceLocation(formulaText: text, completionHandler: { [weak self] resourceLocation in
            guard let `self` = self else { return }
            self.requestImage(by: resourceLocation)
        })
    }
    
    private func requestResourceLocation(formulaText: String,
                                         completionHandler: @escaping ((_ resourcrLocation: String) -> Void)) {
        let service = WikipediaService.check(formula: formulaText)
        sessionProvider.request(service: service) { result in
            switch result {
            case let .success(response, _):
                guard let resourceLocation = response.allHeaderFields["x-resource-location"] as? String else {
                    self.interactorToPresenterProtocol.error(message: "No resource location was found")
                    return
                }
                completionHandler(resourceLocation)
            case let .failure(error):
                self.interactorToPresenterProtocol.error(message: error.localizedDescription)
            }
        }
    }
    
    private func requestImage(by hash: String) {
        let service = WikipediaService.render(hash: hash)
        sessionProvider.request(service: service) { result in
            switch result {
            case let .success(_, data):
                self.interactorToPresenterProtocol.formulaData(data)
            case let .failure(error):
                self.interactorToPresenterProtocol.error(message: error.localizedDescription)
            }
        }
    }
    
}
