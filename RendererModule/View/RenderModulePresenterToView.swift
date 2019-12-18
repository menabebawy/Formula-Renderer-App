//
//  RenderModulePresenterToView.swift
//  RendererModule
//
//  Created by MacBook on 12/16/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

protocol RendererModulePresenterToView: class {
    func viewLoaded()
    func failedToFetchFormaulaImage(message: String)
    func enableRenderButton()
    func disableRenderButton()
    func showFormulaImage(data: Data)
    func showActivityController(text: String)
    func willRequestFormulaImage()
}
