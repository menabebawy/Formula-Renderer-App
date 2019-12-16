//
//  RendererModuleInitalizer.swift
//  RendererModule
//
//  Created by MacBook on 12/16/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit

final class RendererModuleInitalizer: NSObject {
    @IBOutlet weak private var rendererModuleViewController: RendererModuleViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let configurator = RendererModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: rendererModuleViewController)
    }
    
}
