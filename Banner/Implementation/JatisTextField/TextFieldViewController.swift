//
//  TextFieldViewController.swift
//  Banner
//
//  Created by Guntur Budi on 29/04/19.
//  Copyright © 2019 Jati Piranti Solusindo. All rights reserved.
//

import UIKit

class TextFieldViewController: UIViewController {

    
    
    @IBOutlet var jatisTextField: UIView!
    
    @IBOutlet var secondJatisTextField: UIView!
    
    let usernameTextfield = JatisTextField()
    let passwordTextfield = JatisTextField()
    
    var stringUsername : String = ""
    var stringPassword : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.generateTextField()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actLogin(_ sender: Any) {
        if (stringPassword.count == 0){
            passwordTextfield.labelPlaceholder.text = "Please fill Password *"
            passwordTextfield.placeHolderBeforeColor = .red
            passwordTextfield.animatePlaceholderToTop()
        }
    }
    
    func generateTextField(){
        
        jatisTextField.layoutIfNeeded()
        usernameTextfield.tagTextfield = 1
        usernameTextfield.textField.text = "aaaa"
        usernameTextfield.textPlaceholder = "Username"
        usernameTextfield.size = jatisTextField.bounds.size
        usernameTextfield.fontPlaceholder = UIFont(name: "Futura", size: 10)!
        usernameTextfield.textColor = .darkText
        usernameTextfield.doneButtonColor = .orange
        usernameTextfield.placeHolderBeforeColor = .lightGray
        usernameTextfield.delegate = self
        usernameTextfield.borderStyle = .none
        usernameTextfield.isUnderlined = true
        usernameTextfield.setJatisTextField()
        jatisTextField.addSubview(usernameTextfield)
        
        
        secondJatisTextField.layoutIfNeeded()
        passwordTextfield.tagTextfield = 2
        passwordTextfield.isSecure = true
        passwordTextfield.isUsePeekButton = false
        passwordTextfield.textPlaceholder = "Password"
        passwordTextfield.size = secondJatisTextField.bounds.size
        passwordTextfield.fontPlaceholder = UIFont(name: "Futura", size: 10)!
        passwordTextfield.textColor = .darkText
        passwordTextfield.doneButtonColor = .orange
        passwordTextfield.placeHolderBeforeColor = .lightGray
        passwordTextfield.delegate = self
        passwordTextfield.labelPlaceholder.textAlignment = .center
        passwordTextfield.textField.textAlignment = .center
        passwordTextfield.setJatisTextField()
        secondJatisTextField.addSubview(passwordTextfield)
        
       
    }

}

extension TextFieldViewController: JatisTextFieldProtocol {
    func didJatisTextShouldEnd(_ data: String, tagTextField: Int) -> Bool {
        if data != "Asd"{
            return true
        }else {
            return false
        }
    }
    
   
    
    func didJatisTextBeginEditing(_ data: String, tagTextField: Int) {
//        print("text begin : \(data )")
        if(tagTextField == 2 ){
        passwordTextfield.animatePlaceholderToTop()
        passwordTextfield.labelPlaceholder.text = "Password"
        }
    }
    
    func didJatisTextEndEditing(_ data: String, tagTextField: Int) {
//        print("text end : \(data )")
          passwordTextfield.labelPlaceholder.textColor = .gray
        switch tagTextField {
        case 1:
            stringUsername = data
            break
        case 2:
            stringPassword = data
            break
        default:
            break
        }
    }
    
    func didJatisTextChange(_ data: String, tagTextField: Int) {
        
        if tagTextField == 1{
            print(data )
            print(data)
        }
        
        print(data)
    }
    
  
    
}
