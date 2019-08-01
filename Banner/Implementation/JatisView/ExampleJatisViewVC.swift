//
//  ExampleJatisViewVC.swift
//  Banner
//
//  Created by Guntur Budi on 24/04/19.
//  Copyright © 2019 Jati Piranti Solusindo. All rights reserved.
//

import UIKit


class ExampleJatisViewVC: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    let maxSection = 5
    
    
    var currentSection  = 0
    let duration = 5
    let animationInterval = 5.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.generateView()
    }
    
    
    var timer=Timer()
    
    func generateView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "someView", bundle: nil), forCellWithReuseIdentifier: "someViewCell")
        collectionView.reloadData()
        
//        timer = Timer.scheduledTimer(timeInterval: animationInterval, target: self, selector: #selector(animateCollectionView), userInfo: nil, repeats: true)
        self.startTimer()
    }
    
    func scrollToNextCell(){
        print("work")
        //get cell size
        let cellSize = CGSize(width: self.view.frame.width, height: self.view.frame.height);
    
        //get current content Offset of the Collection view
        let contentOffset = collectionView.contentOffset;
        
        //scroll to next cell
        collectionView.scrollRectToVisible(CGRect(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true);
    }
    
    func startTimer() {
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: Selector("scrollToNextCell"), userInfo: nil, repeats: true);
//        timer.fire()
    }
    
}

extension ExampleJatisViewVC: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return maxSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "someViewCell", for: indexPath) as! SomeView
        cell.lblTitle.text = "Hello World"
        cell.lblSubtitle.text = "hello too"
        
        DispatchQueue.main.async {
        cell.lblTitle.font = UIFont(name: "Helvetica", size: cell.bgView.frame.height * 0.15)
        cell.lblSubtitle.font = UIFont(name: "HelveticaNeue-Italic", size: cell.bgView.frame.height * 0.1)
      
        }
        print("IndexPath : \(indexPath)")
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: collectionView.frame.width/2 - 2, height: collectionView.frame.width/2-2)
    }
    
    
}

