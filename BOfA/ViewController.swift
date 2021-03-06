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
        
        NotificationCenter.default.addObserver(self, selector: #selector(closeApp), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        
        let defaults = UserDefaults.standard
        
        if let decoded = defaults.object(forKey: "reservations") as? Data {
            let decodedReservations = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [Reservation]
            reservations = decodedReservations
        }

    }
    
    func openApp(){
        print("viewWillAppear is called")
        let defaults = UserDefaults.standard
        
        if let decoded = defaults.object(forKey: "reservations") as? Data {
            let decodedReservations = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [Reservation]
            reservations = decodedReservations
        }
    }
    
    func closeApp() {
        
        print("viewWillDisappear is called")
        
        let defaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: reservations)
        
        defaults.set(encodedData, forKey: "reservations")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GelManicure") as! TableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Massage") as! TableViewCell
            
            let reservation = reservations[indexPath.row]
            
            let formattedDate = formatTheDate(reservation.date)
            
            cell.configureCell(date: formattedDate, time: reservation.time, partySize: reservation.partySize)
            
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
    
    func formatTheDate(_ date: String) -> String {
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E MMMM d"
        let date1 = dateFormatter.date(from: date)
        
        dateFormatter.dateFormat = "EEEE, MMMM d"
        let finalDate = dateFormatter.string(from: date1!) + ", 2017"
        
        return finalDate
    }

}

