//
//  TextViewVC.swift
//  Banner
//
//  Created by Guntur Budi on 31/07/19.
//  Copyright © 2019 Jati Piranti Solusindo. All rights reserved.
//

import UIKit

class TextViewVC: UIViewController {
    @IBOutlet var txView1: UIView!
    @IBOutlet var txView2: UIView!
    
    let textView1 = JatisTextView()
    let textView2 = JatisTextView()
    
    var stringUsername : String = ""
    var stringPassword : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.generateTextView()
        // Do any additional setup after loading the view.
    }
    
    func generateTextView(){
        
        txView1.layoutIfNeeded()
        textView1.tagTextView = 1
        textView1.textPlaceholder = "Username"
        textView1.size = txView1.bounds.size
        textView1.fontPlaceholder = UIFont(name: "Futura", size: 10)!
        textView1.textColor = .darkText
        textView1.doneButtonColor = .orange
        textView1.placeHolderBeforeColor = .lightGray
        textView1.delegate = self
        textView1.borderStyle = .none
        textView1.isUnderlined = true
        self.textView1.backgroundColor = .darkGray
        textView1.setJatisTextView()
        txView1.addSubview(textView1)
        
        txView2.layoutIfNeeded()
        textView2.tagTextView = 2
        textView2.textPlaceholder = "Password"
        textView2.size = txView2.bounds.size
        textView2.fontPlaceholder = UIFont(name: "Futura", size: 10)!
        textView2.textColor = .darkText
        textView2.doneButtonColor = .orange
        textView2.placeHolderBeforeColor = .lightGray
        textView2.delegate = self
        textView2.labelPlaceholder.textAlignment = .center
        textView2.textView.textAlignment = .center
        self.textView2.backgroundColor = .darkGray
        textView2.setJatisTextView()
        txView2.addSubview(textView2)
    }

}

extension TextViewVC : JatisTextViewProtocol {
    func didJatisTextViewBeginEditing(_ data: String, tagTextView: Int) {
        print("did begin : \(data)")
    }
    
    func didJatisTextViewEndEditing(_ data: String, tagTextView: Int) {
         print("did end : \(data)")
    }
    
    func didJatisTextViewChange(_ data: String, tagTextView: Int) {
         print("did change : \(data)")
    }
    
    func didJatisTextViewShouldEnd(_ data: String, tagTextView: Int) -> Bool {
         print("did begin : \(data)")
        if tagTextView == 1 {
            return data.lowercased().contains("first") || data == ""
        }
        return true
    }
    
    
}
