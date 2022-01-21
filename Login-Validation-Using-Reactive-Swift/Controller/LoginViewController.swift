//
//  LoginViewController.swift
//  Login-Validation-Using-Reactive-Swift
//
//  Created by Mac on 14/01/22.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userNameErrorLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    private typealias InputValidator = (_ name: String?) throws -> String
    let userNameSubject: PublishRelay = PublishRelay<String>()
    let emailSubject: PublishRelay = PublishRelay<String>()
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        validateInput(field: userNameTextField,
                      errorLabel: userNameErrorLabel,
                      subject: userNameSubject,
                      validator: InputValidationService.validateFirstName)
        validateInput(field: emailTextField,
                      errorLabel: emailErrorLabel,
                      subject: emailSubject,
                      validator: InputValidationService.validateEmail)
    }
    
    private func validateInput(field: UITextField,
                               errorLabel: UILabel,
                               subject: PublishRelay<String>,
                               validator: @escaping InputValidator) {
        errorLabel.isHidden = true
        field.rx.text
            .orEmpty
            .subscribe{ subject.accept($0.element ?? "") }
            .disposed(by: disposeBag)
        
        subject
            .map{ try validator($0) }
            .catch{
                errorLabel.isHidden = false
                errorLabel.text = $0.localizedDescription
                throw $0
            }
            .retry()
            .subscribe(onNext: { errorLabel.isHidden = true })
            .disposed(by: disposeBag)
    }
    @IBAction func loginNow(_ sender: Any) {
        
    }
}

