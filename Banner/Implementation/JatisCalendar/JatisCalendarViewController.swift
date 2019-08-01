//
//  JatisCalendarViewController.swift
//  Banner
//
//  Created by Guntur Budi on 30/04/19.
//  Copyright © 2019 Jati Piranti Solusindo. All rights reserved.
//

import UIKit

class JatisCalendarViewController: UIViewController {

    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func actShowCalendar(_ sender: Any) {
        let jatisCalendar = JatisCalendar(tagCalendar: 1, size: self.view!.bounds.size)
        self.view.addSubview(jatisCalendar)
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
