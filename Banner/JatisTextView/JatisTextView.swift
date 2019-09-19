//
//  JatisTextView.swift
//  Banner
//
//  Created by Guntur Budi on 31/07/19.
//  Copyright © 2019 Jati Piranti Solusindo. All rights reserved.
//

import UIKit

public protocol JatisTextViewProtocol: class {
    func didJatisTextViewBeginEditing(_ data: String, tagTextView: Int)
    func didJatisTextViewEndEditing(_ data: String, tagTextView: Int)
    func didJatisTextViewChange(_ data: String, tagTextView: Int)
    func didJatisTextViewShouldEnd(_ data : String, tagTextView: Int) -> Bool
}



open class JatisTextView: UIView {

    //  Create an Int type to define textfield tag.
    open var tagTextView: Int = 0
    
    //  Create a String type that contain placeholder text that want to show.
    open var textPlaceholder : String = ""
    
    // Create a bool type to set textview is editable or not
    open var isEditable : Bool = true
    
    // Create a bool type to set textview is selectable or not
    open var isSelectable : Bool = true
    
    //  Create an UIFont type to define placeholder text font.
    open var fontPlaceholder : UIFont = UIFont(name: "Helvetica", size: 12)!
    
    // create size variable to define the size of the textfield
    open var size: CGSize = CGSize(width: 0, height: 0)
    
    //  Create an UIFont type to define textfield text font.
    open var fontTextView : UIFont  = UIFont(name: "Helvetica", size: 12)!
    
    //   Create an UIFont type to define placeholder text font.
    open var textColor : UIColor = .darkText
    
    //   Create a UIColor type to define placeholder text color before animated.
    open var placeHolderBeforeColor : UIColor = .gray
    
    //   Create an UIColor type to define placeholder after animated text font.
    open var placeHolderAfterColor : UIColor = .darkText
    
    //   Create an UIColor type to define done button color above the keyboard.
    open var doneButtonColor : UIColor = .blue
    
    //   Create a border style type to define textfield borderstyle
    open var borderStyle : UITextField.BorderStyle = .roundedRect
    
    //   Create a bool type to define textfield use clear button or not.
    open var shouldClearTextfield : Bool = true
    
    open var textAlignment : NSTextAlignment = .left
    
    open var isUnderlined : Bool = false
    
    open var underline = UIView()
    
    open var underlineColorBefore : UIColor = .gray
    
    open var underlineColorAfter : UIColor = .blue
    
    open var underlineHeight : CGFloat = 1.0
    
    open var initablePlaceholder : Bool = true
    
    
    // Declare a delegate to receiver actions of textfield
    public weak var delegate: JatisTextViewProtocol?
    
    open var labelPlaceholder = UILabel()
    open var textView = UITextView()
    open var buttonPeek = UIButton()
    
    
    open func setJatisTextView(){
        self.frame =  CGRect(x: 0, y: 0, width: size.width, height: size.height)
        self.layer.masksToBounds = false
        //self.layer.cornerRadius = self.cornerRadius
        self.formatTextView()
    }
    
    open func animatePlaceholderToTop(){
        self.expandPlaceholder()
    }
    
    open func animatePlaceholderToBottom(){
        self.minimizePlaceholder()
    }
    
}


extension JatisTextView {
    private func formatTextView(){
        textView.delegate = self
        textView.frame = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        textView.textColor = self.textColor
        textView.font = self.fontTextView
        textView.tag = self.tagTextView
        textView.isUserInteractionEnabled = true
        textView.isEditable = self.isEditable
        textView.isSelectable = self.isSelectable
        textView.textAlignment = self.textAlignment
        labelPlaceholder.text = textPlaceholder
        labelPlaceholder.font = fontPlaceholder
        labelPlaceholder.frame = CGRect(x: 5, y: self.bounds.origin.y/2+2, width: self.size.width-8, height: self.size.height-5)
        labelPlaceholder.textColor = self.placeHolderBeforeColor
        self.formateKeyboardOption()
        self.addSubview(textView)
        self.addSubview(labelPlaceholder)
        self.setupUnderlined()
        self.setupInitablePlaceholder()
    }
    
    func setupUnderlined(){
        if self.isUnderlined {
            underline.frame = CGRect(x: 0, y: self.bounds.origin.y + self.size.height - 1, width: self.size.width, height: self.underlineHeight)
            underline.backgroundColor = underlineColorBefore
            self.addSubview(underline)
        }
    }
    
    func setupInitablePlaceholder(){
        if initablePlaceholder {
            if textView.text != "" {
                self.setPlaceholderToTop()
            }else {
                self.setPlaceholderToBottom()
            }
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
        textView.inputAccessoryView = keyboardToolbar
       
    }
    
    @objc private func endEditingText(){
        self.endEditing(true)
    }
}



extension JatisTextView: UITextViewDelegate {
    
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        self.delegate?.didJatisTextViewBeginEditing(textView.text!, tagTextView: textView.tag)
        self.minimizePlaceholder()
        if isUnderlined {
            self.underlineStateOn()
        }
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        self.delegate?.didJatisTextViewEndEditing(textView.text!, tagTextView: textView.tag)
        if(textView.text?.count == 0){
            self.expandPlaceholder()
        }
        if isUnderlined {
            self.underlineStateOf()
        }
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        self.delegate?.didJatisTextViewChange(textView.text!, tagTextView: textView.tag)
    }
    
    public func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return self.delegate?.didJatisTextViewShouldEnd(textView.text! , tagTextView: textView.tag) ?? shouldClearTextfield
    }
}

extension JatisTextView {
    public func minimizePlaceholder(){
        UIView.animate(withDuration: 0.15, animations: {
           self.setPlaceholderToTop()
        })
        self.labelPlaceholder.font = UIFont(name: fontPlaceholder.fontName, size: fontPlaceholder.pointSize * 0.9)
        labelPlaceholder.textColor = self.placeHolderAfterColor
        
        
    }
    
    public func expandPlaceholder(){
        UIView.animate(withDuration: 0.15, animations: {
           self.setPlaceholderToBottom()
        })
        self.labelPlaceholder.font = fontPlaceholder
        labelPlaceholder.textColor = self.placeHolderBeforeColor
        
    }
    
    public func setPlaceholderToBottom(){
         self.labelPlaceholder.frame = CGRect(x: 5, y: self.bounds.origin.y/2+2, width: self.bounds.size.width-8, height: self.bounds.size.height-5)
    }
    
    public func setPlaceholderToTop(){
         self.labelPlaceholder.frame = CGRect(x: 5, y: -(self.fontPlaceholder.pointSize), width:  self.bounds.size.width-5, height: self.fontPlaceholder.pointSize)// * 0.5)
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
