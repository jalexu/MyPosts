//
//  TablePostsViewCell.swift
//  MyPosts
//
//  Created by Jaime Uribe on 10/13/19.
//  Copyright © 2019 Jaime Uribe. All rights reserved.
//

import UIKit

class TablePostsViewCell: UITableViewCell {
    
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
