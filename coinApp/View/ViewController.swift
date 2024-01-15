//
//  ViewController.swift
//  coinApp
//
//  Created by Vishal on 08/01/24.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var backBtnOulet: UIButton!
    @IBOutlet var passwordView: UIView!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var eyeBtnOutlet: UIButton!
    @IBOutlet var emailView: UIView!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordValidLabel: UILabel!
    @IBOutlet var signInBtn: UIButton!
    @IBOutlet var userLoginView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        passwordTextField.delegate = self
        passwordValidLabel.isHidden = true
        
    }
    
       // MARK: - UI Setup
    private func setupUI() {
           setupRoundedCorners()
           Styles.shared.setBorderColor(hexColor: 0x3D9CF9, for: emailView)
           Styles.shared.setBorderColor(hexColor: 0x3D9CF9, for: passwordView)
           navigationController?.isNavigationBarHidden = true
       }
       
       private func setupRoundedCorners() {
           passwordView.layer.cornerRadius = 15
           passwordView.clipsToBounds = true
           emailView.layer.cornerRadius = 15
           emailView.clipsToBounds = true
           signInBtn.layer.cornerRadius = 15
           backBtnOulet.layer.cornerRadius = backBtnOulet.frame.size.width / 2
       }

       
       // MARK: - Actions
       @IBAction func backBtn(_ sender: UIButton) {
           navigationController?.popToRootViewController(animated: true)
       }
       
       @IBAction func eyeBtn(_ sender: UIButton) {
           passwordTextField.isSecureTextEntry.toggle()
           let imageName = passwordTextField.isSecureTextEntry ? "eye.slash.fill" : "eye.fill"
           eyeBtnOutlet.setImage(UIImage(systemName: imageName), for: .normal)
       }
       
       @IBAction func SigninBtn(_ sender: UIButton) {
           guard let email = emailTextField.text, !email.isEmpty else {
               showAlert(title: "Empty Email", message: "Please enter your email!")
               return
           }
           
           guard let password = passwordTextField.text, !password.isEmpty else {
               showAlert(title: "Empty Password", message: "Please enter your password!")
               return
           }
           
           guard password.count >= 8 else {
               showAlert(title: "Short Password", message: "Password should be at least 8 characters long.")
               return
           }
           
           if isValidEmail(email) {
               showAlert(title: "Success", message: "Login Successful")
               let tabBar = storyboard?.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
               navigationController?.pushViewController(tabBar, animated: true)
           } else {
               showAlert(title: "Invalid Email or Password", message: "Please enter valid credentials.")
           }
       }
       
       @IBAction func signUpBtn(_ sender: Any) {
           let signupViewController = storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
           navigationController?.pushViewController(signupViewController, animated: true)
       }
   }

   // MARK: - UITextFieldDelegate
   extension ViewController: UITextFieldDelegate {
       func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
           if textField == emailTextField {
               if let email = textField.text, !email.isEmpty {
                   if isValidEmail(email) {
                       return true
                   } else {
                       showAlert(title: "Invalid Email", message: "Please enter a valid email!")
                       return false
                   }
               }
           }
           return true
       }
       
       func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
           
           if newText.count >= 8 {
               passwordValidLabel.isHidden = true
               print("Password is valid")
           } else {
               passwordValidLabel.isHidden = false
               print("Password should be at least 8 characters long")
           }
           
           return true
       }
   }

   // MARK: - Email Validation
   private extension ViewController {
       func isValidEmail(_ email: String) -> Bool {
           let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
           let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
           return emailPredicate.evaluate(with: email)
       }
   }

   // MARK: - Alert Helper
   private extension ViewController {
       func showAlert(title: String, message: String) {
           Alert.shared.ShowAlertWithOKBtn(title: title, message: message)
       }
   }
