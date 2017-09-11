//
//  CalendarCell.swift
//  BOfA
//
//  Created by Evgeny Vlasov on 9/7/17.
//  Copyright © 2017 Evgeny Vlasov. All rights reserved.
//

import UIKit

protocol CustomCellDelegate {
    func cellButtonTapped(cell: CalendarCell, indexPathRow: Int)
}

class CalendarCell: UICollectionViewCell {
    
    @IBOutlet weak var weekDayLbl: UILabel!
    @IBOutlet weak var dayDateLbl: UILabel!
    
    @IBOutlet weak var checkMarkImg: UIImageView!
    var delegate: CustomCellDelegate?
    
//    @IBAction func buttonTapped(sender: AnyObject) {
//        delegate?.cellButtonTapped(cell: self)
//    }
    
    func configureCell(weekDay: String, dayDate: String) {
        weekDayLbl.text = weekDay
        dayDateLbl.text = dayDate
    }
    
}
