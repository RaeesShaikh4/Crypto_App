//
//  SignupViewController.swift
//  coinApp
//
//  Created by Vishal on 09/01/24.
//

import UIKit

class SignupViewController: UIViewController {
    
    // MARK: - UI Outlets
    @IBOutlet var backBtnOutlet: UIButton!
    @IBOutlet var nameView: UIView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailView: UIView!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordView: UIView!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var eyeBtnOutlet: UIButton!
    @IBOutlet var DOBView: UIView!
    @IBOutlet var DOBtextField: UITextField!
    @IBOutlet var registerBtnOutlet: UIButton!
    @IBOutlet var userSignupView: UIView!
    @IBOutlet var checkBox: UIButton!
    @IBOutlet var checkBoxText: UIButton!
    
    var isCheckboxClicked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        passwordTextField.delegate = self
        
        let buttonText = "I agree with the Terms of services & privacy policy"
        let attributedString = NSMutableAttributedString(string: buttonText)
        
        // Range for the "Terms of services" text
        let rangeTerms = (attributedString.string as NSString).range(of: "Terms of services")
        
        // Set color for "Terms of services"
        attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: rangeTerms)
        
        // Set color for the rest of the text
        let rangeRest = NSRange(location: 0, length: attributedString.length)
        attributedString.addAttribute(.foregroundColor, value: UIColor.gray, range: rangeRest)
        
        // Set the attributed string as the button title
        checkBoxText.setAttributedTitle(attributedString, for: .normal)
        
        // Set an empty string for the button's plain title
        checkBoxText.setTitle("", for: .normal)
        
        DOBtextField.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
        
        
    }
    
    
    // MARK: - UI Configuration
    private func configureUI() {
        navigationController?.isNavigationBarHidden = true
        configureRoundedViews()
        configureBorders()
    }
    
    private func configureRoundedViews() {
        backBtnOutlet.layer.cornerRadius = backBtnOutlet.frame.size.width / 2
        nameView.layer.cornerRadius = 15
        emailView.layer.cornerRadius = 15
        passwordView.layer.cornerRadius = 15
        DOBView.layer.cornerRadius = 15
        registerBtnOutlet.layer.cornerRadius = 15
    }
    
    private func configureBorders() {
        Styles.shared.setBorderColor(hexColor: 0x3D9CF9, for: nameView)
        Styles.shared.setBorderColor(hexColor: 0x3D9CF9, for: emailView)
        Styles.shared.setBorderColor(hexColor: 0x3D9CF9, for: passwordView)
        Styles.shared.setBorderColor(hexColor: 0x3D9CF9, for: DOBView)
    }
    
    // MARK: - Actions
    @IBAction func backBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func eyeBtnForPass(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        let imageName = passwordTextField.isSecureTextEntry ? "eye.slash.fill" : "eye.fill"
        eyeBtnOutlet.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    @IBAction func checkBoxClicked(_ sender: UIButton) {
        isCheckboxClicked = !isCheckboxClicked
        
        // Update checkbox symbol based on the state
        let symbolName = isCheckboxClicked ? "checkmark.square.fill" : "square"
        sender.setImage(UIImage(systemName: symbolName), for: .normal)
    }
    
    
    @IBAction func registerBtn(_ sender: UIButton) {
        // Perform text field validations
        guard let name = nameTextField.text, !name.isEmpty else {
            Alert.shared.ShowAlertWithOKBtn(title: "Empty Name", message: "Please enter your name.")
            return
        }
        
        guard let email = emailTextField.text, !email.isEmpty, isValidEmail(email) else {
            Alert.shared.ShowAlertWithOKBtn(title: "Invalid Email", message: "Please enter a valid email.")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            Alert.shared.ShowAlertWithOKBtn(title: "Empty Password", message: "Please enter your password.")
            return
        }
        
        guard password.count >= 8 else {
                Alert.shared.ShowAlertWithOKBtn(title: "Invalid Password", message: "Password must be 8 characters long.")
                return
            }
        
        guard let dob = DOBtextField.text, !dob.isEmpty else {
            Alert.shared.ShowAlertWithOKBtn(title: "Date of Birth", message: "Please enter your Date of Birth.")
            return
        }
        
        guard isCheckboxClicked else {
            Alert.shared.ShowAlertWithOKBtn(title: "Checkbox Not Clicked", message: "Please accept terms & services.")
            return
        }
        
        let tabBar = storyboard?.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
        navigationController?.pushViewController(tabBar, animated: true)
    }
    
    // MARK: - Email Validation
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    // MARK: - Date Picker 0bjc func
    @objc func doneButtonPressed() {
        if let  datePicker = self.DOBtextField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            self.DOBtextField.text = dateFormatter.string(from: datePicker.date)
        }
        self.DOBtextField.resignFirstResponder()
    }
    
}

// MARK: - UITextFieldDelegate extension
extension SignupViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == passwordTextField {
            let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
            
            if newText.count >= 8 {
                // Password is valid
            } else {
                // Password is not valid
                // No need to show alert here, as it will be handled in the registerBtn action
            }
        }

        return true
    }

}

// MARK: - UIDatePicker extension
extension UITextField {

    func addInputViewDatePicker(target: Any, selector: Selector) {
        let screenWidth = UIScreen.main.bounds.width

        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        datePicker.datePickerMode = .date
        self.inputView = datePicker

        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)

        self.inputAccessoryView = toolBar

        self.inputView?.frame.size.height = datePicker.frame.size.height

        if let inputView = self.inputView {
            let textFieldBottomY = self.convert(self.bounds.origin, to: nil).y + self.bounds.height
            let inputViewHeight = inputView.frame.size.height
            let adjustedY = max(textFieldBottomY - inputViewHeight, 0)
            inputView.frame.origin.y = adjustedY
        }
    }

    @objc func cancelPressed() {
        self.resignFirstResponder()
    }
}
