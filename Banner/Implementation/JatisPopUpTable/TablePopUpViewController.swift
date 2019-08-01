//
//  TablePopUpViewController.swift
//  Banner
//
//  Created by Guntur Budi on 25/06/19.
//  Copyright © 2019 Jati Piranti Solusindo. All rights reserved.
//

import UIKit

class TablePopUpViewController: UIViewController {
    let popUpTable = JatisPopUpTable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func actShowTable(_ sender: Any) {
        popUpTable.parentSize = self.view.frame.size
        popUpTable.tableSize = CGSize(width: 300, height: 300)
        popUpTable.center = self.view.center
        popUpTable.strings = ["a","b","c"]
        popUpTable.title = "aaa"
        popUpTable.maximumDisplayedCell = 3
        popUpTable.formatPopUp()
        popUpTable.delegate = self
        self.view.addSubview(popUpTable)
    }
}

extension TablePopUpViewController: JatisPopUpTableProtocol {
    func didSelect(_ data: String, row : Int) {
        print(data)
        self.popUpTable.removeFromSuperview()
    }
}
