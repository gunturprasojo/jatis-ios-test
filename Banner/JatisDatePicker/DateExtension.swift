//
//  DateExtension.swift
//  Banner
//
//  Created by Tirta Rivaldi on 02/08/19.
//  Copyright © 2019 Jati Piranti Solusindo. All rights reserved.
//

import Foundation

extension Date {
    func convertTo(format: String) -> String{
        let formatter = Foundation.DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        formatter.dateFormat = format
        let resultTime = formatter.string(from: self)
        
        return resultTime
    }

}
