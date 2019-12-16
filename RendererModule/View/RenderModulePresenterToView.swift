//
//  RenderModulePresenterToView.swift
//  RendererModule
//
//  Created by MacBook on 12/16/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit

protocol RenderModulePresenterToView: class {
    func viewLoaded()
    func failedToGetFormaulaWithError(message: String)
    func enableRenderButton()
    func disableRenderButton()
    func showFormulaImage(_ image: UIImage)
    func willRequestFormulaImage()
}
