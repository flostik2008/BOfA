//
//  TimeCell.swift
//  BOfA
//
//  Created by Evgeny Vlasov on 9/7/17.
//  Copyright © 2017 Evgeny Vlasov. All rights reserved.
//

import UIKit

protocol TimeCellDelegate {
    func timeCellTapped(cell: TimeCell)
}

class TimeCell: UICollectionViewCell {
    
    @IBOutlet weak var checkImg: UIImageView!
    
    var delegate: TimeCellDelegate?
    
    @IBAction func buttonTapped(sender: AnyObject) {
        delegate?.timeCellTapped(cell: self)
    }
}
