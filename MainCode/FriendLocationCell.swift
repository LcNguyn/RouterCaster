//
//  FriendLocationCell.swift
//  MainCode
//
//  Created by Apple on 5/4/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit

class FriendLocationCell: UITableViewCell {
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var checkBox: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
