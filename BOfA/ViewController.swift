//
//  ViewController.swift
//  BOfA
//
//  Created by Evgeny Vlasov on 9/6/17.
//  Copyright © 2017 Evgeny Vlasov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    var reservations = [Reservation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleDict = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Helvetica", size: 23)!]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
        
        for i in 0..<reservations.count {
            var huy = reservations[i]
            print(huy.date)
        }

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GelManicure") as! TableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Massage") as! TableViewCell
            
            var reservation = reservations[indexPath.row]
            cell.configureCell(date: reservation.date, time: reservation.time, partySize: reservation.partySize)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return reservations.count
        default:
            assert(false, "section \(section)")
            return 0
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createReservation" {
                if let scheduleVC = segue.destination as? ScheduleVC {
                    scheduleVC.reservations = reservations
                }
         }
    }
    
}

