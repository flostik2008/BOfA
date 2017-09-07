//
//  ScheduleVCViewController.swift
//  BOfA
//
//  Created by Evgeny Vlasov on 9/6/17.
//  Copyright © 2017 Evgeny Vlasov. All rights reserved.
//

import UIKit

class ScheduleVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var callendarCollection: UICollectionView!
    @IBOutlet weak var timeCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callendarCollection.delegate = self
        callendarCollection.dataSource = self
        timeCollection.delegate = self
        timeCollection.dataSource = self
        
        let titleDict = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Helvetica", size: 23)!]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict
        self.navigationItem.title = "SCHEDULE"
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }

        if let image = UIImage(named: "back"){
            UIBarButtonItem.appearance().setBackButtonBackgroundImage(image, for: .normal, barMetrics: .default)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if collectionView == self.callendarCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "callendarCell", for: indexPath) as! CalendarCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "timeCell", for: indexPath) as! TimeCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.callendarCollection {
        // return number of days in current mnth.count
            return 9
        } else {
            return 12
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
