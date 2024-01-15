//
//  WelcomeViewController.swift
//  coinApp
//
//  Created by Vishal on 08/01/24.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet var backBtnOutlet: UIButton!
    @IBOutlet var googleLoginView: UIView!
    @IBOutlet var googleLoginImageView: UIImageView!
    @IBOutlet var facebookLoginView: UIView!
    @IBOutlet var fbLoginImageView: UIImageView!
    @IBOutlet var emailLoginView: UIView!
    @IBOutlet var emailLoginImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        navigateToMainViewController()
    }
    
    private func configureUI() {
        navigationController?.isNavigationBarHidden = true
        applyCornerRadius()
        setBorderForEmailLoginView()
    }
    
    private func applyCornerRadius() {
        backBtnOutlet.layer.cornerRadius = backBtnOutlet.frame.size.width / 2
        googleLoginImageView.layer.cornerRadius = googleLoginImageView.frame.size.width / 2
        fbLoginImageView.layer.cornerRadius = fbLoginImageView.frame.size.width / 2
        emailLoginImageView.layer.cornerRadius = emailLoginImageView.frame.size.width / 2
        
        googleLoginView.layer.cornerRadius = 10
        facebookLoginView.layer.cornerRadius = 10
        emailLoginView.layer.cornerRadius = 10
    }
    
    private func setBorderForEmailLoginView() {
        Styles.shared.setBorderColor(hexColor: 0x3D9CF9, for: emailLoginView)
    }
    
    private func navigateToMainViewController() {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}




