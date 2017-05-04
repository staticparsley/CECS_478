//
//  RCells.swift
//  f-Humanity
//
//  Created by Ahmed Al Sadiq on 5/2/17.
//  Copyright © 2017 Ahmed Al Sadiq. All rights reserved.
//

import UIKit

class RCells: UITableViewCell {

    @IBOutlet weak var usrName: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let theWidth = UIScreen.main.bounds.width
        
        usrName.center = CGPoint(x: 230, y: 55)
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
