//
//  JatisTextField.swift
//  Banner
//
//  Created by Guntur Budi on 29/04/19.
//  Copyright © 2019 Jati Piranti Solusindo. All rights reserved.
//

import UIKit


/*
 The code below is used to create a banner type display.
 The functions below include:
 1.  Make UIView type class with UITextfield display which animated placeholder.
 */



//  Protocol to receive actions of textfield.
//  This Protocol used to receive an actions with UITextfield delegate functions
public protocol JatisTextFieldProtocol: class {
    func didJatisTextBeginEditing(_ data: String, tagTextField: Int)
    func didJatisTextEndEditing(_ data: String, tagTextField: Int)
    func didJatisTextChange(_ data: String, tagTextField: Int)
    func didJatisTextShouldEnd(_ data : String, tagTextField: Int) -> Bool
}



//  Declaration of class JatisTextField
open class JatisTextField: UIView {
    
    //  Create an Int type to define textfield tag.
    open var tagTextfield: Int = 0
    
    //  Create a String type that contain placeholder text that want to show.
    open var textPlaceholder : String = ""
    
    //  Create an UIFont type to define placeholder text font.
    open var fontPlaceholder : UIFont = UIFont(name: "Helvetica", size: 12)!
    
    // create size variable to define the size of the textfield
    open var size: CGSize = CGSize(width: 0, height: 0)
    
    //  Create an UIFont type to define textfield text font.
    open var fontTextfield : UIFont  = UIFont(name: "Helvetica", size: 12)!
    
    //   Create an UIFont type to define placeholder text font.
    open var textColor : UIColor = .darkText
    
    //  Create an bool type variable to define if Textfield is securetype or not
    open var isSecure : Bool = false
    
    //  Create an bool type variable to define if Textfield is securetype or not
    open var isUsePeekButton : Bool = false
    
    //   Create a UIColor type to define placeholder text color before animated.
    open var placeHolderBeforeColor : UIColor = .gray
    
    //   Create an UIColor type to define placeholder after animated text font.
    open var placeHolderAfterColor : UIColor = .darkText
    
    //   Create a bool type to define textfield use clear button or not.
    open var useClearButton : Bool = true
    
    //   Create an UIColor type to define done button color above the keyboard.
    open var doneButtonColor : UIColor = .blue
    
    //   Create a border style type to define textfield borderstyle
    open var borderStyle : UITextField.BorderStyle = .roundedRect
    
    //   Create a bool type to define textfield use clear button or not.
    open var shouldClearTextfield : Bool = true
    
    open var isUnderlined : Bool = false
    
    open var underline = UIView()
    
    open var underlineColorBefore : UIColor = .gray
    
    open var underlineColorAfter : UIColor = .blue
    
    open var underlineHeight : CGFloat = 1.0
    
    
    // Declare a delegate to receiver actions of textfield
    public weak var delegate: JatisTextFieldProtocol?
    
    open var labelPlaceholder = UILabel()
    open var textField = UITextField()
    open var buttonPeek = UIButton()
    
    
    open func setJatisTextField(){
        self.frame =  CGRect(x: 0, y: 0, width: size.width, height: size.height)
        self.layer.masksToBounds = false
        //self.layer.cornerRadius = self.cornerRadius
        self.formatTextField()
    }
    
    open func animatePlaceholderToTop(){
        self.expandPlaceholder()
    }
    
    open func animatePlaceholderToBottom(){
        self.minimizePlaceholder()
    }
    
}


extension JatisTextField {
    private func formatTextField(){
        textField.delegate = self
        
        if isUsePeekButton {
            textField.frame = CGRect(x: 0, y: 0, width: self.size.width - 30, height: self.size.height)
        }else {
            textField.frame = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        }
        
        
        
        textField.textColor = self.textColor
        
        
        if isSecure {
            textField.isSecureTextEntry = true
            
            
        }
        textField.tag = self.tagTextfield
        
        labelPlaceholder.text = textPlaceholder
        labelPlaceholder.font = fontPlaceholder
        labelPlaceholder.frame = CGRect(x: 5, y: self.bounds.origin.y/2+2, width: self.size.width-8, height: self.size.height-5)
        //labelPlaceholder.frame = CGRect(x: 0, y: 10, width: self.size.width-8, height: self.size.height-5)
        // self.labelPlaceholder.backgroundColor = .clear
        labelPlaceholder.textColor = self.placeHolderBeforeColor
        
        self.formateKeyboardOption()
        self.addSubview(textField)
        self.addSubview(labelPlaceholder)
        
        if self.isSecure {
            self.addSubview(buttonPeek)
        }
        
        if self.isUnderlined {
            underline.frame = CGRect(x: 0, y: self.bounds.origin.y + self.size.height - 1, width: self.size.width, height: self.underlineHeight)
            underline.backgroundColor = underlineColorBefore
            self.addSubview(underline)
        }
        
    }
    
    private func formateKeyboardOption(){
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.barStyle = UIBarStyle.default
        keyboardToolbar.isTranslucent = true
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.endEditingText))
        
        
        keyboardToolbar.setItems([ flexBarButton,doneBarButton], animated: true)
        
        doneBarButton.tintColor = self.doneButtonColor
        textField.inputAccessoryView = keyboardToolbar
        
        
        textField.addTarget(self, action:  #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        if self.useClearButton {
            textField.clearButtonMode = .whileEditing
        }
        textField.borderStyle = self.borderStyle
        
        if self.isUsePeekButton {
            buttonPeek.frame =  CGRect(x:self.bounds.size.width - 25, y: self.bounds.size.height/2 - 10, width: 20,height: 20)
            let peekImage = UIImage(named: "eye.png")
            buttonPeek.contentMode = .scaleAspectFit
            buttonPeek.setImage(peekImage, for: .normal)
            buttonPeek.addTarget(self, action: #selector(self.peekTextfield), for: .touchDown)
            buttonPeek.addTarget(self, action: #selector(unPeekTextfield), for: [.touchUpInside, .touchUpOutside])
            buttonPeek.setTitleColor(.white, for: .normal)
        }
    }
    
    @objc private func endEditingText(){
        self.endEditing(true)
    }
    
    @objc private func peekTextfield(_ sender: UIButton) {
        self.textField.isSecureTextEntry = false
    }
    
    @objc private func unPeekTextfield(_ sender: UIButton) {
        self.textField.isSecureTextEntry = true
    }
    
}



extension JatisTextField: UITextFieldDelegate {
    
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        self.delegate?.didJatisTextBeginEditing(textField.text!, tagTextField: textField.tag)
        self.minimizePlaceholder()
        if isUnderlined {
            self.underlineStateOn()
        }
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        self.delegate?.didJatisTextEndEditing(textField.text!, tagTextField: textField.tag)
        if(textField.text?.count == 0){
            self.expandPlaceholder()
        }
        if isUnderlined {
            self.underlineStateOf()
        }
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        self.delegate?.didJatisTextChange(textField.text!, tagTextField: textField.tag)
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return self.delegate?.didJatisTextShouldEnd(textField.text! , tagTextField: textField.tag) ?? shouldClearTextfield
    }
}

extension JatisTextField {
    public func minimizePlaceholder(){
        UIView.animate(withDuration: 0.15, animations: {
            if self.isUsePeekButton {
                self.labelPlaceholder.frame = CGRect(x: 5, y: -(self.bounds.size.height/2), width:  self.bounds.size.width-35, height: self.bounds.size.height*0.5)// *
            }else {
                self.labelPlaceholder.frame = CGRect(x: 5, y: -(self.bounds.size.height/2), width:  self.bounds.size.width-5, height: self.bounds.size.height*0.5)// * 0.5)
            }
        })
        self.labelPlaceholder.font = UIFont(name: fontPlaceholder.fontName, size: fontPlaceholder.pointSize * 0.9)
        labelPlaceholder.textColor = self.placeHolderAfterColor
        
        
    }
    
    public func expandPlaceholder(){
        UIView.animate(withDuration: 0.15, animations: {
            if self.isUsePeekButton {
                self.labelPlaceholder.frame = CGRect(x: 5, y: self.bounds.origin.y/2+2, width: self.bounds.size.width-30, height: self.bounds.size.height-5)
            }else {
                self.labelPlaceholder.frame = CGRect(x: 5, y: self.bounds.origin.y/2+2, width: self.bounds.size.width-8, height: self.bounds.size.height-5)
            }
        })
        self.labelPlaceholder.font = fontPlaceholder
        labelPlaceholder.textColor = self.placeHolderBeforeColor
        
    }
    
    public func underlineStateOn(){
        //        UIView.animate(withDuration: 0.15, animations: {
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: [.curveEaseInOut , .allowUserInteraction],
                       animations: {
                        self.underline.backgroundColor = self.underlineColorAfter
        })
        
        
    }
    
    public func underlineStateOf(){
        //        UIView.animate(withDuration: 0.15, animations: {
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: [.curveEaseInOut , .allowUserInteraction],
                       animations: {
                        self.underline.backgroundColor = self.underlineColorBefore
        })
    }
}
