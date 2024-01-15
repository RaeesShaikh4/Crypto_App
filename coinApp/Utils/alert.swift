//
//  validation.swift
//  coinApp
//
//  Created by Vishal on 09/01/24.
//

import Foundation
import UIKit

class Alert {
    
    static let shared = Alert()
    private init(){}

    func ShowAlertWithOKBtn(title:String,message:String){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
        }
    }
}
