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
public protocol JatisCalendarProtocol: class {
    func didJatisTextBeginEditing(_ data: UITextField)
   
}



//  Declaration of class JatisTextField
open class JatisCalendar: UIView {
    
    //  Create an Int type to define textfield tag.
    fileprivate var tagCalendar: Int
    fileprivate var cornerRadius: CGFloat
    fileprivate var startDate: Date
    fileprivate var endDate : Date
    
  
    public weak var delegate: JatisCalendarProtocol?
    
    private let labelPlaceholder = UILabel()
    private let textField = UITextField()
    
  
    
    var calendarFrame = UIView(frame:CGRect.zero)
    
    required public init(tagCalendar: Int,
                        size: CGSize,
                        cornerRadius: CGFloat = 20,
                        startDate: Date = Date(),
                        endDate:Date = Date(timeIntervalSinceNow: 300000)
                        )
    {
        
        self.tagCalendar = tagCalendar
        self.cornerRadius = cornerRadius
        self.startDate = startDate
        self.endDate = endDate
        
        super.init(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height));
        self.layer.masksToBounds = true
        let gray = UIColor.darkGray.withAlphaComponent(0.5)
        self.backgroundColor = gray//UIColor(red: 75, green: 75, blue: 75, alpha: 0.5)
        
        self.setFormatter()
        self.generateActions()
        self.generateCalendarFrame()
        
        return
    }
    
    
    required public init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
 
    var jtsYearChooice = UIView()
    var jtsMonthChooice = UIView()
    
    var month = Date()
    var monthFormatter = DateFormatter()
    var yearFormatter = DateFormatter()
    var monthString = String()
    var yearString = String()
    
    var totalDateMonthBefore = Int()
    var totalDateMonthAfter = Int()
    var totalStartDate = Int()
}


//  Set Calendar
extension JatisCalendar {
    func setFormatter(){
        month = startDate
        monthFormatter.dateFormat = "MMMM"
        yearFormatter.dateFormat = "yyyy"
        monthString = monthFormatter.string(from: startDate)
        yearString = yearFormatter.string(from: startDate)
        
        monthFormatter.dateFormat = "MM"
        let startDateComponents = NSDateComponents()
        startDateComponents.year = Int(yearFormatter.string(from: startDate))!
        startDateComponents.month = Int(monthFormatter.string(from: startDate))!
        
        let beforeDateComponents = NSDateComponents()
        beforeDateComponents.year = Int(yearFormatter.string(from: startDate))! - 1
        beforeDateComponents.month = Int(monthFormatter.string(from: startDate))! - 1
        
        
        let afterDateComponents = NSDateComponents()
        afterDateComponents.year = Int(yearFormatter.string(from: startDate))! + 1
        afterDateComponents.month = Int(monthFormatter.string(from: startDate))! + 1
        
        
        let calendar = NSCalendar.current
        var tempCalendar = calendar.date(from: startDateComponents as DateComponents)
        var range = calendar.range(of: .day, in: .month, for: tempCalendar!)!
        totalStartDate = range.count
        
        tempCalendar = calendar.date(from: beforeDateComponents as DateComponents)
        range = calendar.range(of: .day, in: .month, for: tempCalendar!)!
        totalDateMonthBefore = range.count
        
        tempCalendar = calendar.date(from: afterDateComponents as DateComponents)
        range = calendar.range(of: .day, in: .month, for: tempCalendar!)!
        totalDateMonthAfter = range.count
        
        
        print("start date")
        print(startDateComponents.year)
        print(startDateComponents.month)
        print(startDateComponents.day)
        print(totalStartDate)
        print("============")
        
        print("before")
        print(beforeDateComponents.year)
        print(beforeDateComponents.month)
        print(totalDateMonthBefore)
        print("============")
        
        print("after")
        print(afterDateComponents.year)
        print(afterDateComponents.month)
        print(totalDateMonthAfter)
        print("============")
        
    }
}

//  Build calendar view
extension JatisCalendar {
    private func generateActions(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(singleTap(sender:)))
        self.addGestureRecognizer(tap)
    }
    
    @objc private func singleTap(sender: UITapGestureRecognizer? = nil) {
        if(sender?.numberOfTouches == 1){
            self.removeFromSuperview()
        }
    }
    
    private func generateCalendarFrame(){
        let rectFrame = CGRect(x: self.bounds.size.width/10,// - self.bounds.size.width/4,
                                y:  self.bounds.size.height/2 - self.bounds.size.height * 0.25,// -  self.bounds.size.height/4,
                                width: self.bounds.size.width * 0.8,
                                height: self.bounds.size.width * 0.6)
        calendarFrame = UIView(frame: rectFrame)
        calendarFrame.backgroundColor = .white
        calendarFrame.layer.cornerRadius = self.cornerRadius
        calendarFrame.addSubview(buildNavigationView(size: rectFrame.size))
        self.addSubview(self.calendarFrame)
    }
    
    private func generateDateChoice(){
        
    }
    
    private func buildNavigationView(size: CGSize) -> UIView{
        let navigationView = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height*0.25))
        navigationView.backgroundColor = .red
        navigationView.layer.mask = self.buildTopCornerRadiusMask(bounds: navigationView.bounds)
        navigationView.addDefaultShadow(offset: CGSize(width: 2, height: 2))
        navigationView.addSubview(self.buildButtonMonth(size: size))
        navigationView.addSubview(self.buildButtonYear(size: size))
        return navigationView
    }
    
  

    private func buildButtonMonth(size : CGSize)-> UIButton {
        let buttonMonth = UIButton(frame: CGRect(x: 0, y: 0, width: size.width * 0.3, height: size.height*0.25))
        buttonMonth.setTitle(monthString, for: .normal)
        buttonMonth.setTitleColor(.white, for: .normal)
        buttonMonth.backgroundColor = .blue
        buttonMonth.addTarget(self, action: #selector(monthPressed), for: .touchUpInside)
        return buttonMonth
    }
    
    private func buildButtonYear(size : CGSize) -> UIButton {
        let buttonYear = UIButton(frame: CGRect(x: size.width - size.width*0.3, y: 0, width: size.width * 0.3, height: size.height*0.25))
        buttonYear.setTitle(yearString, for: .normal)
        buttonYear.setTitleColor(.white, for: .normal)
        buttonYear.backgroundColor = .blue
        buttonYear.addTarget(self, action: #selector(yearPressed), for: .touchUpInside)
        return buttonYear
    }
    
    private func buildMonthChooice(){
        self.jtsMonthChooice = UIView(frame: CGRect(x: self.bounds.size.width/10,// - self.bounds.size.width/4,
            y:  self.bounds.size.height/2 - self.bounds.size.height * 0.25,// -  self.bounds.size.height/4,
            width: self.bounds.size.width * 0.8,
            height: self.bounds.size.width * 0.6))
        jtsMonthChooice.layer.cornerRadius = self.cornerRadius
        jtsMonthChooice.backgroundColor = .darkGray
        jtsMonthChooice.layer.masksToBounds = true
        let btnCloseYear = UIButton(frame: CGRect(x: jtsMonthChooice.bounds.width - jtsMonthChooice.bounds.width*0.3, y: 0, width: jtsMonthChooice.bounds.width * 0.3, height: jtsMonthChooice.bounds.height*0.25))
        btnCloseYear.setTitle("Close", for: .normal)
        btnCloseYear.setTitleColor(.white, for: .normal)
        btnCloseYear.backgroundColor = .blue
        btnCloseYear.addTarget(self, action: #selector(closeMonthView), for: .touchUpInside)
        jtsMonthChooice.addSubview(btnCloseYear)
        self.addSubview(jtsMonthChooice)
    }
    
    private func buildYearChooice(){
        self.jtsYearChooice = UIView(frame: CGRect(x: self.bounds.size.width/10,// - self.bounds.size.width/4,
                                    y:  self.bounds.size.height/2 - self.bounds.size.height * 0.25,// -  self.bounds.size.height/4,
                                    width: self.bounds.size.width * 0.8,
                                    height: self.bounds.size.width * 0.6))
        jtsYearChooice.layer.cornerRadius = self.cornerRadius
        jtsYearChooice.backgroundColor = .green
        jtsYearChooice.layer.masksToBounds = true
        let btnCloseYear = UIButton(frame: CGRect(x: jtsYearChooice.bounds.width - jtsYearChooice.bounds.width*0.3, y: 0, width: jtsYearChooice.bounds.width * 0.3, height: jtsYearChooice.bounds.height*0.25))
        btnCloseYear.setTitle("Close", for: .normal)
        btnCloseYear.setTitleColor(.white, for: .normal)
        btnCloseYear.backgroundColor = .blue
        btnCloseYear.addTarget(self, action: #selector(closeYearView), for: .touchUpInside)
        jtsYearChooice.addSubview(btnCloseYear)
        self.addSubview(jtsYearChooice)
    }
    
}

extension JatisCalendar{
    
    @objc private func monthPressed(){
        print("month Pressed")
        self.buildMonthChooice()
    }
    
    @objc private func yearPressed(){
        print("year Pressed")
        self.buildYearChooice()
    }
    
    @objc private func closeYearView(){
        print("close year")
        self.jtsYearChooice.removeFromSuperview()
    }
    
    @objc private func closeMonthView(){
        print("close year")
        self.jtsMonthChooice.removeFromSuperview()
    }
}


//  Layout Formatting
extension JatisCalendar{
    private func buildTopCornerRadiusMask(bounds: CGRect) -> CAShapeLayer{
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        return mask
    }
}




