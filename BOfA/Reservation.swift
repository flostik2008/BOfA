//
//  Reservation.swift
//  BOfA
//
//  Created by Evgeny Vlasov on 9/8/17.
//  Copyright © 2017 Evgeny Vlasov. All rights reserved.
//

import Foundation

class Reservation: NSObject, NSCoding {

    var date: String
    var time: String
    var partySize: String

    init(date: String, time: String, partySize: String) {
        self.date = date
        self.time = time
        self.partySize = partySize
    }
    
    required init(coder aDecoder: NSCoder) {
        
        self.date = aDecoder.decodeObject(forKey: "date") as? String ?? ""
        self.time = aDecoder.decodeObject(forKey: "time") as? String ?? ""
        self.partySize = aDecoder.decodeObject(forKey: "partySize") as? String ?? ""
        
        
//        let date = aDecoder.decodeObject(forKey: "date") as! String
//        let time = aDecoder.decodeObject(forKey: "time") as! String
//        let partySize = aDecoder.decodeObject(forKey: "partySize") as! String
//        self.init(date: date, time: time, partySize: partySize)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(date, forKey: "date")
        aCoder.encode(time, forKey: "time")
        aCoder.encode(partySize, forKey: "partySize")
    }

}
