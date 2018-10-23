//
//  TrashCellTableViewCell.swift
//  ComeApp
//
//  Created by kobi on 27/08/2017.
//  Copyright © 2017 Kobi Kanetti. All rights reserved.
//

import UIKit
import SDWebImage

class TrashCell: UITableViewCell {

    // Labels
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var proNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var conditionLabel: UILabel!
    
    // ImageView
    @IBOutlet weak var photoImageView: UIImageView!

    
    
    func configure(with item : Item){
        
        addressLabel?.text = item.address
        proNameLabel?.text = item.description
        if let con = item.condition{
            conditionLabel?.text = "Condition: " + con
        } else {
            conditionLabel.text = nil
        }
        dateLabel?.text = item.date?.dateString

        if let url = item.imageUrl{
            photoImageView.sd_setImage(with: url)
        } else {
            photoImageView.image = #imageLiteral(resourceName: "icon_avatar")
        }
    }



    
}
