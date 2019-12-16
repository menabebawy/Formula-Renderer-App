//
//  RendererModuleViewController.swift
//  RendererModule
//
//  Created by MacBook on 12/16/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit

public protocol RendererModuleViewControllerDelegate: class {
    func showErrorAlert(message: String)
}

public final class RendererModuleViewController: UIViewController {
    @IBOutlet weak private var formulaTextField: UITextField!
    @IBOutlet weak private var renderButton: UIButton!
    @IBOutlet weak private var formulaImageView: UIImageView!
    @IBOutlet weak private var activityIndicatorView: UIActivityIndicatorView!

    var viewToPresenterProtocol: RendererModuleViewToPresenter!
    weak public var delegate: RendererModuleViewControllerDelegate?

    override public func viewDidLoad() {
        super.viewDidLoad()
        viewToPresenterProtocol.viewIsReady()
    }
    
    @IBAction private func renderButtonClicked() {
        print("clicked")
    }

}

// MARK: - Renderer module presenter to view

extension RendererModuleViewController: RenderModulePresenterToView {
    func viewLoaded() {
        disableRenderButton()
        activityIndicatorView.stopAnimating()
    }
    
    func failedToGetFormaulaWithError(message: String) {
        gotResponse()
        delegate?.showErrorAlert(message: message)
    }
    
    func enableRenderButton() {
        renderButton.isEnabled = true
        renderButton.backgroundColor = .blue
    }
    
    func disableRenderButton() {
        renderButton.isEnabled = false
        renderButton.backgroundColor = .gray
    }
    
    func showFormulaImage(_ image: UIImage) {
        gotResponse()
    }
    
    func willRequestFormulaImage() {
        activityIndicatorView.startAnimating()
        formulaTextField.isEnabled = false
        disableRenderButton()
    }
    
    private func gotResponse() {
        activityIndicatorView.stopAnimating()
        formulaTextField.isEnabled = true
        enableRenderButton()
    }
    
}
