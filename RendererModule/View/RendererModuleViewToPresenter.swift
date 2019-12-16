//
//  RendererModuleViewToPresenter.swift
//  RendererModule
//
//  Created by MacBook on 12/16/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import Foundation

protocol RendererModuleViewToPresenter {
    func viewIsReady()
    func didChangeFormulaTextField(text: String)
    func requestFormulaImage(by text: String)
}
