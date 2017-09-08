//
//  CalendarCell.swift
//  BOfA
//
//  Created by Evgeny Vlasov on 9/7/17.
//  Copyright © 2017 Evgeny Vlasov. All rights reserved.
//

import UIKit

protocol CustomCellDelegate {
    func cellButtonTapped(cell: CalendarCell)
}

class CalendarCell: UICollectionViewCell {
    
    @IBOutlet weak var checkMarkImg: UIImageView!
    var delegate: CustomCellDelegate?
    
    @IBAction func buttonTapped(sender: AnyObject) {
        delegate?.cellButtonTapped(cell: self)
    }
    
}
