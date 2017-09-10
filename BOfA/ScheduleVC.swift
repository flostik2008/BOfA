//
//  ScheduleVCViewController.swift
//  BOfA
//
//  Created by Evgeny Vlasov on 9/6/17.
//  Copyright © 2017 Evgeny Vlasov. All rights reserved.
//

import UIKit

class ScheduleVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, CustomCellDelegate, TimeCellDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var currentMonthLbl: UILabel!
    @IBOutlet weak var callendarCollection: UICollectionView!
    @IBOutlet weak var timeCollection: UICollectionView!
    @IBOutlet weak var partySizeTxtView: UITextField!
    @IBOutlet weak var reserveBtn: UIButton!
    
    var reservations = [Reservation]()
    let partySizePicker = UIPickerView()
    var partySizeOptions = [String]()
    var dayAlreadyClicked = false
    var timeAlreadyClicked = false
    var calendarDatesArray = [CalendarDates]()
    var timeSpansArray = [TimeStapms]()
    var selectedCalDay = String()
    var selectedTime = String()
    
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
        
        callendarCollection.delegate = self
        callendarCollection.dataSource = self
        timeCollection.delegate = self
        timeCollection.dataSource = self
        
        partySizePicker.delegate = self
        partySizePicker.dataSource = self
        navigationController?.delegate = self

        
        partySizeTxtView.inputView = partySizePicker
        partySizeTxtView.text = "1"
        
        for i in 1...12 {
            partySizeOptions.append(String(i))
        }

        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red:0.26, green:0.24, blue:0.24, alpha:1.0)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        partySizeTxtView.inputAccessoryView = toolBar
        reserveBtn.backgroundColor = UIColor(red:0.65, green:0.82, blue:0.95, alpha:1.0)
        reserveBtn.titleLabel?.textColor = UIColor.black
        reserveBtn.setTitleColor(UIColor(red:0.65, green:0.82, blue:0.95, alpha:1.0), for: .disabled)
        reserveBtn.isEnabled = false
        
        createCalDateArray()
        createTimeArr(todayChosen: false)
        
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.callendarCollection {
        // return number of days in current mnth.count
            return calendarDatesArray.count
        } else {
            return timeSpansArray.count
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return partySizeOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return partySizeOptions.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        let partySize = partySizeOptions[partySizePicker.selectedRow(inComponent: 0)]
        partySizeTxtView.text = partySize
    }
    
    func donePicker(sender: UIBarButtonItem) {
        partySizeTxtView.resignFirstResponder()
    }
    
    
    func timeCellTapped(cell: TimeCell) {
        
        if cell.checkImg.isHidden && !timeAlreadyClicked {
            cell.checkImg.isHidden = false
            timeAlreadyClicked = true
            
            if dayAlreadyClicked {
                reserveBtn.isEnabled = true
                reserveBtn.backgroundColor = UIColor(red:0.36, green:0.69, blue:0.94, alpha:1.0)
            }
            // grab cell's values and save it to global var.
            selectedTime = cell.timeLbl.text!
            
        } else if !cell.checkImg.isHidden {
            cell.checkImg.isHidden = true
            timeAlreadyClicked = false
            
            createTimeArr(todayChosen: false)
            
            reserveBtn.isEnabled = false
            reserveBtn.backgroundColor = UIColor(red:0.65, green:0.82, blue:0.95, alpha:1.0)
            selectedTime = ""
        }
    }
    
    
    func createTimeArr(todayChosen: Bool) {
        if !todayChosen {
            print("Hello")
            for i in 9...20 {
                let calendar = Calendar.current
                let now = Date()
                var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now)
                
                components.hour = i
                components.minute = 00
                components.second = 0
                
                let date = calendar.date(from: components)!
                
                let formatter = DateFormatter()
                formatter.dateFormat = "h:mm a"
                
                let timeStamp = TimeStapms(time: formatter.string(from: date))
                timeSpansArray.append(timeStamp)
            }
            print(timeSpansArray.count)
            timeCollection.reloadData()


        } else {
            timeSpansArray.removeAll()
            
            let calendar = Calendar.current
            let now = Date()
            var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now)
            
            var i = components.hour!
            
            if i < 9 {
                i = 9
            }
            
            for k in i...20 {
                let calendar = Calendar.current
                let now = Date()
                
                var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now)
                
                components.hour = k
                components.minute = 00
                components.second = 0
                
                let date = calendar.date(from: components)!
                
                let formatter = DateFormatter()
                formatter.dateFormat = "h:mm a"
                
                let timeStamp = TimeStapms(time: formatter.string(from: date))
                timeSpansArray.append(timeStamp)
            }
            
            timeCollection.reloadData()
        }
    }
    
    @IBAction func reserveBtnTapped(_ sender: Any) {
        
        let dateString = "Friday, September 8, 2017"
        let timeString = "10:00 AM"
        let reservation = Reservation(date: dateString, time: timeString, partySize: partySizeTxtView.text!)
        
        reservations.append(reservation)
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        (viewController as? ViewController)?.reservations = reservations
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.callendarCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "callendarCell", for: indexPath) as! CalendarCell
            cell.delegate = self
            
            let calDate = calendarDatesArray[indexPath.row]
            cell.configureCell(weekDay: calDate.weekDay, dayDate: calDate.date)
            currentMonthLbl.text = calDate.month
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "timeCell", for: indexPath) as! TimeCell
            cell.delegate = self
            
            let timeStamp = timeSpansArray[indexPath.row]
            cell.configureCell(time: timeStamp.time)
            
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.callendarCollection {
            if let cell = collectionView.cellForItem(at: indexPath) {
                cellButtonTapped(cell: cell as! CalendarCell)
            }
            
            if indexPath.row == 0 {
                createTimeArr(todayChosen: true)
            } else {
                createTimeArr(todayChosen: false)
            }
            
        } else {
            if let cell = collectionView.cellForItem(at: indexPath) {
                timeCellTapped(cell: cell as! TimeCell)
            }
        }
    }

    func cellButtonTapped(cell: CalendarCell) {
        
        if cell.checkMarkImg.isHidden && !dayAlreadyClicked {
            cell.checkMarkImg.isHidden = false
            dayAlreadyClicked = true
            
            if timeAlreadyClicked {
                reserveBtn.isEnabled = true
                reserveBtn.backgroundColor = UIColor(red:0.36, green:0.69, blue:0.94, alpha:1.0)
            }
            
            // these 3 calls are for saving date for the main VC.
            var date = cell.dayDateLbl.text!
            var weekDay = cell.weekDayLbl.text!
            selectedCalDay = date + " " + weekDay
            
        } else if !cell.checkMarkImg.isHidden {
            cell.checkMarkImg.isHidden = true
            dayAlreadyClicked = false
            
            reserveBtn.isEnabled = false
            reserveBtn.backgroundColor = UIColor(red:0.65, green:0.82, blue:0.95, alpha:1.0)
            createTimeArr(todayChosen: false)
            selectedCalDay = ""
            
            // reload calendar dates array and reload collection. 
            
        }
    }

    func createCalDateArray() {
        
        var calendar = Calendar.current
        var today = Date() // first date
        
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: calendar.startOfDay(for: today)))!
        
        var comps2 = DateComponents()
        comps2.month = 1
        comps2.day = 0
        let endOfMonth = calendar.date(byAdding: comps2, to: startOfMonth)
        
        let fmtMonth = DateFormatter()
        fmtMonth.dateFormat = "MMMM"
        let fmtDate = DateFormatter()
        fmtDate.dateFormat = "d"
        let fmtWeekday = DateFormatter()
        fmtWeekday.dateFormat = "EEE"
        
        while today <= endOfMonth! {
            
            let mnthString = fmtMonth.string(from: today)
            let weekdayString = fmtWeekday.string(from: today)
            let dateDay = fmtDate.string(from: today)
            
            let dateForArray = CalendarDates(mnth: mnthString, date: dateDay, weekDay: weekdayString)
            calendarDatesArray.append(dateForArray)
            
            today = calendar.date(byAdding: .day, value: 1, to: today)!
        }
    }

}



















