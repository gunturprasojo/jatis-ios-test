//
//  JatisDatePicker.swift
//  Jatis-iOS
//
//  Created by Tirta Rivaldi on 01/08/19.
//

import Foundation
import UIKit

public protocol JatisDatePickerDelegate: class {
    func getSelectedDate(date: Date)
}

open class JatisDatePicker: UIView {
    
    static var view = UIView()
    static var datePicker = UIDatePicker()
    static var toolBar = UIToolbar()
    
    static weak var delegate: JatisDatePickerDelegate?
    
    class func show(_ minDate: Date?,_ maxDate: Date?){
        //Check if datepicker view is exist on View Controller
        if view.isDescendant(of: UIApplication.topViewController()!.view) {
            return
        }
        
        //Set up Frame
        view = UIView(frame: CGRect(x: 0, y: UIApplication.topViewController()!.view.bounds.height, width: UIApplication.topViewController()!.view.frame.width, height: UIApplication.topViewController()!.view.frame.height * 0.4))
        datePicker = UIDatePicker(frame: CGRect(x: 0 , y: 40, width: view.frame.size.width, height: view.frame.height - 40))
        
        //Set up background
        datePicker.backgroundColor = UIColor.white
        
        //Set up Datepicker Mode
        datePicker.datePickerMode = UIDatePicker.Mode.date
        
        //Set up Min and Max Date on Datepicker
        datePicker.date = Date()
        if let min = minDate {
            datePicker.minimumDate = min
        }
        if let max = maxDate {
            datePicker.maximumDate = max
        }
        view.addSubview(datePicker)
        
        //Setup ToolBar
        toolBar = UIToolbar(frame: CGRect(x: 0, y: self.datePicker.frame.origin.y - 40, width: view.frame.size.width, height: 40))
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        //Add Datepicker view on View Controller
        view.addSubview(toolBar)
        UIApplication.topViewController()!.view.addSubview(view)
        
        //Show Datepicker with animation
        DispatchQueue.main.async {
            view.animShow()
        }
        
    }
    
    //Action when click Done
    @objc class func doneClick() {
        //selectedDate?(datePicker.date)
        delegate?.getSelectedDate(date: datePicker.date)
        cancelClick()
        
    }
    
    //Action when click Cancel
    @objc class func cancelClick() {
        view.animHide({(res) in
            view.removeFromSuperview()
        })
    }
    
}
