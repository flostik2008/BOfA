//
//  CalendarDates.swift
//  BOfA
//
//  Created by Evgeny Vlasov on 9/7/17.
//  Copyright © 2017 Evgeny Vlasov. All rights reserved.
//

import Foundation

class CalendarDates {

    var month: String
    var date: String
    var weekDay: String
    
    init(mnth: String, date: String, weekDay: String) {
        self.date = date
        self.weekDay = weekDay
        self.month = mnth
    }


}
