//
//  ScheduleVCViewController.swift
//  BOfA
//
//  Created by Evgeny Vlasov on 9/6/17.
//  Copyright © 2017 Evgeny Vlasov. All rights reserved.
//

import UIKit

class ScheduleVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
  
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
}
