//
//  JatisPopUpTable.swift
//  Banner
//
//  Created by Guntur Budi on 25/06/19.
//  Copyright © 2019 Jati Piranti Solusindo. All rights reserved.
//

import UIKit

open class JatisPopUpTable: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    //  Create an array type of String that want to show.
    open var strings: [String] = []
    
    // Title of Pop Up
    open var title: String = ""
    
    //  Create Size of parent of table view
    open var parentSize: CGSize = CGSize(width: 0, height: 0)
    
    //  Create an array of String -> Id of an image.
    open var tableSize: CGSize = CGSize(width: 0, height: 0)
    
    //  Create a float type variable to set corner radius,
    //  that used to set the radius of the corner of a view.
    open var cornerRadius: CGFloat = 10.0
    
 
    // Create variable color to set title background
    open var titleBackroundColor : UIColor = .white
    
    // Create variable color to set backround of content color
    open var contentBackgroundColor : UIColor = .white
    
    // Create variable color to set title color
    open var titleTextColor : UIColor = .darkGray
    
     // Create variable color to set content text color
    open var contentTextColor : UIColor = .darkGray
    
     // Create variable color to set close button color
    open var closeButtonColor : UIColor = .darkGray
    
     // Create variable to set is selectable cell
    open var isSelectable : Bool = true
    
    // Create variable to set is close button available in title
    open var isUseCloseButton : Bool = true
    
    // Create variable height to set is height of content
    open var cellHeight : CGFloat = 50
    
    // Create variable height to set is height of title
    open var titleHeight : CGFloat = 50
    
    // Create variable string to set title close
    open var closeButtonTitle : String = "x"
    
    
    //===== update .2
    
    // Create variable to set is scrollable table
    open var isScrollable : Bool = false
    
    // Create variable to set color separator betweeen title and cell
    open var separatorTitleColor : UIColor = .gray
    
    // Create variable to set height of separator betweeen title and cell
    open var separatorTitleHeight : CGFloat = 0.5
    
    // Create variable to set height of separator betweeen title and cell
    open var maximumDisplayedCell : CGFloat = 5
    
    
    // Declare a delegate to receiver an action of tableview
    public weak var delegate: JatisPopUpTableProtocol?
    
    
    open var tableView = UITableView()
    
    open var closeButton = UIButton()
    
    open var selectionStyle : UITableViewCell.SelectionStyle = .blue
    
    open func formatPopUp(){
        self.frame =  CGRect(x: 0, y: 0, width: parentSize.width, height: parentSize.height)
        self.layer.masksToBounds = true
        let gray = UIColor.darkGray.withAlphaComponent(0.5)
        self.backgroundColor = gray
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.cornerRadius
        self.formatTableView()
    }
    
    private func generateActions(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(singleTap(sender:)))
        self.addGestureRecognizer(tap)
    }
    
    @objc private func singleTap(sender: UITapGestureRecognizer? = nil) {
        if(sender?.numberOfTouches == 1){
            self.removeFromSuperview()
        }
    }

}


extension JatisPopUpTable : UITableViewDataSource, UITableViewDelegate{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.strings.count
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewSection = UIView(frame: CGRect(x: 0, y: 0, width:self.tableView.frame.size.width, height: self.titleHeight))
        let titleLbl = UILabel(frame: CGRect(x: 0, y: 0, width:self.tableView.frame.size.width, height: self.titleHeight))
        viewSection.backgroundColor = titleBackroundColor
        titleLbl.textAlignment = .center
        titleLbl.text = title
        titleLbl.textColor = titleTextColor
        viewSection.addSubview(titleLbl)
        if isUseCloseButton {
            closeButton.frame = CGRect(x: self.tableView.frame.size.width - 50, y: 0, width: 50, height: self.titleHeight)
            closeButton.addTarget(self, action: #selector(self.close), for: .touchDown)
            closeButton.setTitle(closeButtonTitle, for: .normal)
            closeButton.setTitleColor(self.closeButtonColor, for: .normal)
            viewSection.addSubview(closeButton)
        }
        let separatorSection = UIView(frame: CGRect(x: 0, y: self.titleHeight, width:self.tableView.frame.size.width, height: separatorTitleHeight))
        separatorSection.backgroundColor = separatorTitleColor
        viewSection.addSubview(separatorSection)
        return viewSection
    }
    
    @objc func close(){
        self.removeFromSuperview()
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.titleHeight
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let popUpCell = tableView.dequeueReusableCell(withIdentifier: "jatisPopUpTableCell", for: indexPath)
        let titleLbl = UILabel(frame: CGRect(x: 0, y: 0, width:self.tableView.frame.size.width, height: self.cellHeight))
        titleLbl.backgroundColor = contentBackgroundColor
        titleLbl.textAlignment = .center
        titleLbl.text = strings[indexPath.row]
        titleLbl.textColor = contentTextColor
        popUpCell.addSubview(titleLbl)
        popUpCell.selectionStyle = self.selectionStyle
        return popUpCell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(strings[indexPath.row], row: indexPath.row)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.cellHeight
    }
    
    private func formatTableView(){
        let heightTable = self.maximumDisplayedCell * self.cellHeight + self.titleHeight
        self.tableView = UITableView(frame: CGRect(x: parentSize.width/2 - self.tableSize.width/2, y:  parentSize.height/2 - self.tableSize.height/2, width: self.tableSize.width, height: heightTable), style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "jatisPopUpTableCell")
        tableView.isScrollEnabled = isScrollable
        self.addSubview(tableView)
        self.tableView.layer.cornerRadius = self.cornerRadius
        self.tableView.clipsToBounds = true
        
        if isSelectable {
            tableView.allowsSelection = true
        }else {
            tableView.allowsSelection = false
        }
        
        tableView.reloadData()
    }
    
    private func formatCell(){

    }
    
    open func formatCloseButton(){
      
    }
}

public protocol JatisPopUpTableProtocol: class {
    func didSelect(_ data: String , row : Int)
}


