//
//  Reservation.swift
//  BOfA
//
//  Created by Evgeny Vlasov on 9/8/17.
//  Copyright © 2017 Evgeny Vlasov. All rights reserved.
//

import Foundation

class Reservation {

    var date: String
    var time: String
    var partySize: String

    init(date: String, time: String, partySize: String) {
        self.date = date
        self.time = time
        self.partySize = partySize
    }

}
