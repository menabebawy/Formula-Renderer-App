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
    func showActivityController(text: String, image: UIImage)
}

public final class RendererModuleViewController: UIViewController {
    @IBOutlet weak private var formulaTextField: UITextField!
    @IBOutlet weak private var renderButton: UIButton!
    @IBOutlet weak private var formulaImageView: UIImageView!
    @IBOutlet weak private var shareButton: UIButton!
    @IBOutlet weak private var activityIndicatorView: UIActivityIndicatorView!

    var viewToPresenterProtocol: RendererModuleViewToPresenter!
    weak public var delegate: RendererModuleViewControllerDelegate?

    override public func viewDidLoad() {
        super.viewDidLoad()
        viewToPresenterProtocol.viewIsReady()
    }
    
    @IBAction private func renderButtonClicked() {
        viewToPresenterProtocol.requestFormulaImage(by: formulaTextField.text ?? "")
    }
    
    @IBAction private func shareButtonClicked() {
        viewToPresenterProtocol.shareFormula(text: formulaTextField.text ?? "")
    }

}

// MARK: - Renderer module presenter to view

extension RendererModuleViewController: RenderModulePresenterToView {
    func viewLoaded() {
        title = "Formula renderer"
        formulaTextField.delegate = self
        disableRenderButton()
        activityIndicatorView.stopAnimating()
        formulaImageView.addObserver(self, forKeyPath: "image", options: .new, context: nil)
        formulaImageView.image = nil
    }
    
    public override func observeValue(forKeyPath keyPath: String?,
                                      of object: Any?,
                                      change: [NSKeyValueChangeKey : Any]?,
                                      context: UnsafeMutableRawPointer?) {
        if keyPath == "image" {
            shareButton.isHidden = formulaImageView.image == nil
        }
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
    
    func showFormulaImage(data: Data) {
        gotResponse()
        formulaImageView.image = UIImage(data: data)
    }
    
    func showActivityController(text: String) {
        guard let image = formulaImageView.image else {
            delegate?.showErrorAlert(message: "Formula image is not found")
            return
        }
        delegate?.showActivityController(text: text, image: image)
    }
    
    func willRequestFormulaImage() {
        formulaTextField.resignFirstResponder()
        activityIndicatorView.startAnimating()
        formulaTextField.isEnabled = false
        formulaImageView.image = nil
        disableRenderButton()
    }
    
    private func gotResponse() {
        activityIndicatorView.stopAnimating()
        formulaTextField.isEnabled = true
        enableRenderButton()
    }
    
}

// MARK: - Text field delegate

extension RendererModuleViewController: UITextFieldDelegate {
    public func textField(_ textField: UITextField,
                          shouldChangeCharactersIn range: NSRange,
                          replacementString string: String) -> Bool {
        let updatedNSString = textField.text as NSString?
        let updatedString = updatedNSString?.replacingCharacters(in: range, with: string) ?? ""
        viewToPresenterProtocol.didChangeFormulaTextField(text: updatedString)
        return true
    }
}
