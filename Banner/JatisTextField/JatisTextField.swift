////
////  JatisTextField.swift
////  Banner
////
////  Created by Guntur Budi on 29/04/19.
////  Copyright © 2019 Jati Piranti Solusindo. All rights reserved.
////
//
//import UIKit
//
//
///*
// The code below is used to create a banner type display.
// The functions below include:
// 1.  Make UIView type class with UITextfield display which animated placeholder.
// */
//
//
//
////  Protocol to receive actions of textfield.
////  This Protocol used to receive an actions with UITextfield delegate functions
//public protocol JatisTextFieldProtocol: class {
//    func didJatisTextBeginEditing(_ data: String, tagTextField: Int)
//    func didJatisTextEndEditing(_ data: String, tagTextField: Int)
//    func didJatisTextChange(_ data: String, tagTextField: Int)
//}
//
//
//
////  Declaration of class JatisTextField
//open class JatisTextField: UIView {
//    
//    //  Create an Int type to define textfield tag.
//    fileprivate var tagTextfield: Int
//    
//    //  Create a String type that contain placeholder text that want to show.
//    fileprivate var textPlaceholder : String
//    
//    //  Create an UIFont type to define placeholder text font.
//    fileprivate var fontPlaceholder : UIFont
//    
//    //  Create an UIFont type to define textfield text font.
//    fileprivate var fontTextfield : UIFont
//    
//    //   Create an UIFont type to define placeholder text font.
//    fileprivate var textColor : UIColor
//    
//    //  Create an bool type variable to define if Textfield is securetype or not
//    fileprivate var isSecure : Bool
//    
//    //  Create an bool type variable to define if Textfield is securetype or not
//    fileprivate var isUsePeekButton : Bool
//    
//    //   Create a UIColor type to define placeholder text color before animated.
//    fileprivate var placeHolderBeforeColor : UIColor
//    
//    //   Create an UIColor type to define placeholder after animated text font.
//    fileprivate var placeHolderAfterColor : UIColor
//    
//    //   Create a bool type to define textfield use clear button or not.
//    fileprivate var useClearButton : Bool
//    
//    //   Create an UIColor type to define done button color above the keyboard.
//    fileprivate var doneButtonColor : UIColor
//    
//    //   Create a border style type to define textfield borderstyle
//    fileprivate var borderStyle : UITextField.BorderStyle
//    
//    
//    // Declare a delegate to receiver actions of textfield
//    public weak var delegate: JatisTextFieldProtocol?
//    
//    private let labelPlaceholder = UILabel()
//    private let textField = UITextField()
//    private let buttonPeek = UIButton()
//    
//    required public init(tagTextfield: Int,
//                         textPlaceHolder:String,
//                         isSecure:Bool, isUsePeekButton: Bool,
//                         size:CGSize,
//                         fontPlaceholder : UIFont = UIFont(name: "Helvetica", size: 12)!,
//                         fontTextField : UIFont = UIFont(name: "Helvetica", size: 12)!,
//                         textColor : UIColor = .black,
//                         placeHolderBeforeColor: UIColor = UIColor.lightGray,
//                         placeHolderAfterColor: UIColor = .blue,
//                         useClearButton : Bool = true, doneButtonColor : UIColor = .blue,
//                         borderStyle : UITextField.BorderStyle = UITextField.BorderStyle.roundedRect
//        )
//    {
//        
//        self.tagTextfield = tagTextfield
//        self.isSecure = isSecure
//        self.isUsePeekButton = isUsePeekButton
//        self.textPlaceholder = textPlaceHolder
//        self.labelPlaceholder.text = self.textPlaceholder
//        
//        self.fontPlaceholder = fontPlaceholder
//        self.fontTextfield = fontTextField
//        self.textColor = textColor
//        self.placeHolderBeforeColor = placeHolderBeforeColor
//        self.placeHolderAfterColor = placeHolderAfterColor
//        
//        self.useClearButton = useClearButton
//        self.doneButtonColor = doneButtonColor
//        self.borderStyle = borderStyle
//        
//        
//        super.init(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height));
//        self.layer.masksToBounds = false
//        
//        
//        self.formatTextField()
//        return
//    }
//    
//    
//    required public init?(coder aDecoder: NSCoder){
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//}
//
//
//extension JatisTextField {
//    private func formatTextField(){
//        textField.delegate = self
//        
//        if isUsePeekButton {
//             textField.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width - 20, height: self.bounds.size.height)
//        }else {
//            textField.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
//        }
//        
//        
//        
//        textField.textColor = self.textColor
//        
//        
//        if isSecure {
//            textField.isSecureTextEntry = true
//            
//            
//        }
//        textField.tag = self.tagTextfield
//        
//        labelPlaceholder.font = fontPlaceholder//UIFont(name: "Helvetica", size: self.bounds.size.height * 0.5)
//        labelPlaceholder.frame = CGRect(x: 5, y: self.bounds.origin.y/2+2, width: self.bounds.size.width-8, height: self.bounds.size.height-5)
//        self.labelPlaceholder.backgroundColor = .clear
//        
//        labelPlaceholder.textColor = self.placeHolderBeforeColor
//        
//        self.formateKeyboardOption()
//        self.addSubview(textField)
//        self.addSubview(labelPlaceholder)
//        
//        if self.isSecure {
//             self.addSubview(buttonPeek)
//        }
//        
//    }
//    
//    private func formateKeyboardOption(){
//        let keyboardToolbar = UIToolbar()
//        keyboardToolbar.barStyle = UIBarStyle.default
//        keyboardToolbar.isTranslucent = true
//        keyboardToolbar.sizeToFit()
//        let flexBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
//        
//        let doneBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.endEditingText))
//        
//        
//        keyboardToolbar.setItems([ flexBarButton,doneBarButton], animated: true)
//        
//        doneBarButton.tintColor = self.doneButtonColor
//        textField.inputAccessoryView = keyboardToolbar
//        
//        
//        textField.addTarget(self, action:  #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
//        if self.useClearButton {
//            textField.clearButtonMode = .whileEditing
//        }
//        textField.borderStyle = self.borderStyle
//        
//        if self.isUsePeekButton {
//            buttonPeek.frame =  CGRect(x:self.bounds.size.width - 15, y: self.bounds.size.height/2 - 10, width: 20,height: 20)
//            let peekImage = UIImage(named: "eye.png")
//            buttonPeek.contentMode = .scaleAspectFit
//            buttonPeek.setImage(peekImage, for: .normal)
//            buttonPeek.addTarget(self, action: #selector(self.peekTextfield), for: .touchDown)
//            buttonPeek.addTarget(self, action: #selector(unPeekTextfield), for: [.touchUpInside, .touchUpOutside])
//            buttonPeek.setTitleColor(.white, for: .normal)
//        }
//    }
//    
//    @objc private func endEditingText(){
//        self.endEditing(true)
//    }
//    
//    @objc private func peekTextfield(_ sender: UIButton) {
//        self.textField.isSecureTextEntry = false
//    }
//    
//    @objc private func unPeekTextfield(_ sender: UIButton) {
//       self.textField.isSecureTextEntry = true
//    }
//}
//
//
//
//extension JatisTextField: UITextFieldDelegate {
//    
//    
//    public func textFieldDidBeginEditing(_ textField: UITextField) {
//        self.delegate?.didJatisTextBeginEditing(textField.text!, tagTextField: textField.tag)
//        self.minimizePlaceholder()
//    }
//    
//    public func textFieldDidEndEditing(_ textField: UITextField) {
//        self.delegate?.didJatisTextEndEditing(textField.text!, tagTextField: textField.tag)
//        if(textField.text?.count == 0){
//            self.expandPlaceholder()
//        }
//    }
//    
//    @objc func textFieldDidChange(textField: UITextField) {
//        self.delegate?.didJatisTextChange(textField.text!, tagTextField: textField.tag)
//    }
//}
//
//extension JatisTextField {
//    private func minimizePlaceholder(){
//        UIView.animate(withDuration: 0.15, animations: {
//            self.labelPlaceholder.frame = CGRect(x: 5, y: -(self.bounds.size.height/2), width:  self.bounds.size.width*0.25, height: self.bounds.size.height*0.5)// * 0.5)
//            
//        })
//        self.labelPlaceholder.font = UIFont(name: fontPlaceholder.fontName, size: fontPlaceholder.pointSize * 0.9)
//        labelPlaceholder.textColor = self.placeHolderAfterColor
//        
//        
//    }
//    
//    private func expandPlaceholder(){
//        UIView.animate(withDuration: 0.15, animations: {
//            self.labelPlaceholder.frame = CGRect(x: 5, y: self.bounds.origin.y/2+2, width: self.bounds.size.width-8, height: self.bounds.size.height-5)
//        })
//        self.labelPlaceholder.font = fontPlaceholder
//        labelPlaceholder.textColor = self.placeHolderBeforeColor
//    }
//}
