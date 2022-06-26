//
//  SigninViewController.swift
//  FavoritesUIKit
//
//  Created by Scott Richards on 4/17/21.
//

import UIKit

protocol SignInViewControllerDelegate: AnyObject {
    func doUserSignedIn()
}

class SigninViewController: UIViewController {
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var switchModeButton: UIButton!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var changeModeContainerView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    weak var delegate: SignInViewControllerDelegate?
    
    var mode: Mode = .signIn {
        didSet {
            if isViewLoaded {
                updateUI()
            }
        }
    }
    
    enum Mode {
        case signIn
        case signUp

        
        func titleText() -> String {
            switch self {
            case .signIn: return "Sign in below"
            case .signUp: return "Create an Account"
            }
        }
        
        func buttonText() -> String {
            switch self {
            case .signIn: return "Sign In"
            case .signUp: return "Sign Up"
            }
        }
        
        func explanationText() -> String {
            switch self {
            case .signIn: return "Don't have an account? Sign Up Here"
            case .signUp: return "Have an account? Sign In Here"
            }
        }
        
        func resetButtonText() -> String {
            switch self {
            case .signIn: return "Forgot Password"
            case .signUp: return ""
            }
        }
    }
    
    var errorState: ErrorState = .none
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        signInButton.layer.cornerRadius = 8
        updateUI()
        forgotPasswordButton.setStyle(.LinkSecondary)
        switchModeButton.setStyle(.LinkPrimary)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        switch mode {
        case .signUp:   emailTextField.resignFirstResponder()
                        nameTextField.becomeFirstResponder()
        case .signIn: emailTextField.becomeFirstResponder()
        }
    }
    
    func updateUI() {
        signInButton.setTitle(mode.buttonText(), for: .normal)
        navigationItem.title = mode.buttonText()
        switchModeButton.setTitle(mode.explanationText(), for: .normal)
        titleLabel.text = mode.titleText()
        switch mode {
        case .signIn:
            emailLabel.text = "Your Email"
            passwordTextField.text = ""
            passwordTextField.keyboardType = .default
            passwordTextField.textContentType = .password
            passwordTextField.returnKeyType = .done
            confirmPasswordLabel.isHidden = true
            confirmPasswordTextField.isHidden = true
            nameLabel.isHidden = true
            nameTextField.isHidden = true
            signInButton.isEnabled = validateInput()
        case .signUp:
            emailLabel.text = "Your Email"
            passwordTextField.text = ""
            passwordTextField.keyboardType = .default
            passwordTextField.textContentType = .password
            passwordTextField.returnKeyType = .next
            confirmPasswordLabel.isHidden = false
            confirmPasswordTextField.isHidden = false
            nameLabel.isHidden = false
            nameTextField.isHidden = false
            signInButton.isEnabled = validateInput() && passwordsMatch()
        }
        // depending on errorState show or hide error
        switch errorState {
        case .none:
            errorLabel.isHidden = true
        case .error:
            errorLabel.isHidden = false
        }
    }
    
    @IBAction func doToggleMode(_ sender: Any) {
        if mode == .signIn {
            mode = .signUp
        } else {
            mode = .signIn
        }
        emailTextField.text = ""
        passwordTextField.text = ""
        updateUI()
        switch mode {
        case .signUp:   emailTextField.resignFirstResponder()
                        nameTextField.becomeFirstResponder()
        case .signIn: emailTextField.becomeFirstResponder()
        }
    }
    
    @IBAction func onForgotPassword(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        if let forgotPasswordViewController = storyBoard.instantiateViewController(withIdentifier: "ForgotPassword") as? ForgotPasswordViewController {
//            forgotPasswordViewController.email = emailTextField.text
//            forgotPasswordViewController.modalPresentationStyle = .fullScreen
//            self.present(forgotPasswordViewController, animated: true, completion: nil)
//        }
    }
    
    
    @IBAction func doAction(_ sender: Any) {
        guard let email = emailTextField.text?.lowercased(), let password = passwordTextField.text, let displayName = nameTextField.text else {
            displayAlert("Please provide an email password and name")
            return
        }
        showSpinner()
        switch mode {
        case .signIn: UserManager.singleton.signIn(email: email, password: password) { (result, error) in
            // Success
//            DispatchQueue.main.async {
                self.hideSpinner()
                if (result != nil && error == nil) {
                    self.errorState = .none
                    self.dismiss(animated: true)

                } else if let error = error as? NSError {
                    self.errorState = .error
                    self.errorLabel.text = error.localizedDescription
                    self.updateUI()
                    print("error code: \(error.code) \(error.localizedDescription)")
                    // Password is not valid
                    if error.code == 17009 {
                        self.passwordTextField.setStyle(.error)
                    }
                    // User does not exist
                    if error.code == 17011 {
                        self.emailTextField.setStyle(.error)
                    }
                    Log.error(error: error)
//                    self.displayAlert(error.localizedDescription)
                }
//            }
        }
        case .signUp:
            UserManager.singleton.signUp(email: email, password: password, displayName: displayName) { (result, error) in
                self.hideSpinner()
                AnalyticsManager.log(event: AnalyticsManagerEvent.SignUp, error: error)
                if (result != nil && error == nil) {
                    self.errorState = .none
                    self.dismiss(animated: true)
                } else if let error = error {
                    self.errorState = .error
                    self.errorLabel.text = error.localizedDescription
                    self.updateUI()
 //                   self.displayAlert(error.localizedDescription)
                }
            }
        }
    }
    
    @IBAction func doClose(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    // Returns true if the user has entered a valid email
    func emailEntered() -> Bool {
        if let emailText = emailTextField.text, !emailText.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    func validateInput() -> Bool {
        guard let passwordText = passwordTextField.text, let emailText = emailTextField.text else {
            return false
        }
        return !passwordText.isEmpty && !emailText.isEmpty
    }
    
    func passwordsMatch() -> Bool {
        guard let passwordText = passwordTextField.text, let confirmText = confirmPasswordTextField.text  else {
            return false
        }
        return passwordText == confirmText
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func validateEmailAddress(email: String) -> Bool {
        if !ValidationManager.isValidEmailAddress(emailAddressString: email) {
            emailTextField.setStyle(.error)
            errorLabel.text = "That email is not a valid email address"
            errorState = .error
            updateUI()
            return false
        } else {
            errorState = .none
            updateUI()
            return true
        }
    }
}

extension SigninViewController: UITextFieldDelegate {
    //  User edited text field so check and enable sign in button if the inputs validate
    func textFieldDidChangeSelection(_ textField: UITextField) {
        signInButton.isEnabled = validateInput()
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            if let emailAddress = emailTextField.text, !emailAddress.isEmpty, validateEmailAddress(email: emailAddress) {
                textField.resignFirstResponder()
                return true
            } else {
                return false
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing")
        textField.layer.borderWidth = 0.0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if mode == .signUp, textField == passwordTextField {
            confirmPasswordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.setStyle(.focus)
//        textField.layer.borderColor = Styles.Colors.TextFieldFocus?.cgColor
//        textField.layer.borderWidth = 2.0
    }
    
}
