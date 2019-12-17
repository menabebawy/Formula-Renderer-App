//
//  RenderModulePresenterToView.swift
//  RendererModule
//
//  Created by MacBook on 12/16/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

protocol RenderModulePresenterToView: class {
    func viewLoaded()
    func failedToGetFormaulaWithError(message: String)
    func enableRenderButton()
    func disableRenderButton()
    func showFormulaImage(data: Data)
    func showActivityController(text: String)
    func willRequestFormulaImage()
}
