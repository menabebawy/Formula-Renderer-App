//
//  RendererModuleInteractorTests.swift
//  RendererModuleTests
//
//  Created by MacBook on 12/18/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import XCTest
@testable import NetworkLayer
@testable import RendererModule

class RendererModuleInteractorTests: XCTestCase {
    var interactorInterface = MockPresenter()
    var mockInteractor = RendererModuleInteractor()
    
    override func setUp() {
        super.setUp()
        mockInteractor.interactorToPresenterProtocol = interactorInterface
    }
    
    func testFetchFormulaImageSuccess() {
        mockInteractor.interactorToPresenterProtocol.formulaData(Data())
        XCTAssertFalse(interactorInterface.didFailedLoading)
    }
    
    func testFetchFormulaImageFailure() {
        mockInteractor.interactorToPresenterProtocol.error(message: "error")
        XCTAssertTrue(interactorInterface.didFailedLoading)
    }
    
    class MockPresenter: RendererModuleInteractorToPresenter {
        var didFailedLoading = true
        
        func formulaData(_ data: Data) {
            didFailedLoading = false
        }
        
        func error(message: String) {
            didFailedLoading = true
        }
    }
    
}
