//
//  DatePickerVC.swift
//  Banner
//
//  Created by Tirta Rivaldi on 02/08/19.
//  Copyright © 2019 Jati Piranti Solusindo. All rights reserved.
//

import UIKit

class DatePickerVC: UIViewController {

    @IBOutlet weak var lbDate: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        JatisDatePicker.delegate = self
    }
    
    @IBAction func showDatePicker(_ sender: UIButton) {
        JatisDatePicker.show(nil, nil)
    }
    
    /*
    // MARK: - Navigation

     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DatePickerVC: JatisDatePickerDelegate {
    func getSelectedDate(date: Date) {
        lbDate.text = date.convertTo(format: "dd-MMM-yyyy")
    }
    
    
}
