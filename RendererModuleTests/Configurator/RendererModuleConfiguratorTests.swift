//
//  RendererModuleConfiguratorTests.swift
//  RendererModuleTests
//
//  Created by MacBook on 12/18/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import XCTest
@testable import RendererModule

class RendererModuleConfiguratorTests: XCTestCase {
    
    func testConfigureModuleForViewController() {
        let viewController = RendererModuleViewController()
        let configurator = RendererModuleConfigurator()
        
        configurator.configureModuleForViewInput(viewInput: viewController)
        
        XCTAssertNotNil(viewController.viewToPresenterProtocol,
                        "RendererModuleViewController is nil after configuration")
        
        let presenter = viewController.viewToPresenterProtocol! as! RendererModulePresenter
        XCTAssertNotNil(presenter.view,"View in Presenter is nil after configuration")
        
        let interactor = presenter.interactor as! RendererModuleInteractor
        XCTAssertNotNil(interactor.interactorToPresenterProtocol,
                        "Output in Interactor is nil after configuration")
    }
    
}
