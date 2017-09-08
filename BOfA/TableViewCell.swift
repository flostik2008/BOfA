//
//  TableViewCell.swift
//  BOfA
//
//  Created by Evgeny Vlasov on 9/6/17.
//  Copyright © 2017 Evgeny Vlasov. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var rescheduleBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var partySizeLbl: UILabel!
    @IBOutlet weak var timeSpanLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var startTimeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        rescheduleBtn.layer.cornerRadius = 5
        cancelBtn.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(date: String, time: String, partySize: String) {
        dateLbl.text = date
        timeSpanLbl.text = time
        partySizeLbl.text = partySize
    }

}
