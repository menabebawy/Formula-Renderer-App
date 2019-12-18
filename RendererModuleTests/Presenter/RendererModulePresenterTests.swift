//
//  RendererModulePresenterTests.swift
//  RendererModuleTests
//
//  Created by MacBook on 12/18/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import XCTest
@testable import RendererModule

class RendererModulePresenterTests: XCTestCase {
    let presenter = RendererModulePresenter()
    var interactor: MockInteractor = MockInteractor()
    var view: MockView = MockView()
    
    override func setUp() {
        super.setUp()
        presenter.interactor = interactor
        presenter.view = view
    }
    
    func testViewLoaded() {
        XCTAssertFalse(view.viewDidLoad)
        presenter.viewIsReady()
        XCTAssertTrue(view.viewDidLoad)
    }
    
    func testFetchingFormulaImage() {
        presenter.requestFormulaImage(by: "2")
        XCTAssertTrue(interactor.fetchingFormulaImage)
    }
    
    func testErrorMessage() {
        presenter.error(message: "Bad request")
        XCTAssertTrue(view.failedToLoad)
    }
    
    func testLoadFormulaImage() {
        presenter.formulaData(Data())
        XCTAssertFalse(view.failedToLoad)
    }
    
    func testShowActivityViewAfterSharedButtonClicked() {
        XCTAssertFalse(view.showActivityView)
        presenter.shareFormula(text: "2")
        XCTAssertTrue(view.showActivityView)
    }
    
    func testShapingSharedText() {
        presenter.shareFormula(text: "    2 + \n 2 =           4")
        XCTAssertEqual(view.sharedText, "2 + 2 = 4")
    }
    
    func testEnableAndDisableRendererButtonAfactedByFormulaText() {
        // text is once space -> disable renderer button
        presenter.didChangeFormulaTextField(text: " ")
        XCTAssertEqual(view.isRendererButtonEnabled, false)
        
        // text is 2 then space -> enable renderer button
        presenter.didChangeFormulaTextField(text: "   2")
        XCTAssertEqual(view.isRendererButtonEnabled, true)
        
        // text is more than space with no chracters, symboles or even numbers
        // -> disable render button
        presenter.didChangeFormulaTextField(text: "                    ")
        XCTAssertEqual(view.isRendererButtonEnabled, false)
    }
    
    class MockInteractor: RendererModulePresenterToInteractor {
        var fetchingFormulaImage = false
        
        func requestFormulaImage(by text: String) {
            fetchingFormulaImage = true
        }
        
    }
    
    class MockView: RendererModulePresenterToView {
        var failedToLoad = false
        var viewDidLoad = false
        var showActivityView = false
        var isRendererButtonEnabled = false
        var sharedText = ""
        
        func failedToFetchFormaulaImage(message: String) {
            failedToLoad = true
        }
        
        func showFormulaImage(data: Data) {
            failedToLoad = false
        }
        
        func viewLoaded() {
            viewDidLoad = true
        }
        
        func showActivityController(text: String) {
            sharedText = text
            showActivityView = true
        }
        
        func willRequestFormulaImage() {
            isRendererButtonEnabled = false
        }
        
        func enableRenderButton() {
            isRendererButtonEnabled = true
        }
        
        func disableRenderButton() {
            isRendererButtonEnabled = false
        }
    }

}
