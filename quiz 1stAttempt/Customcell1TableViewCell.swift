//
//  Customcell1TableViewCell.swift
//  quiz 1stAttempt
//
//  Created by 渡辺唯都 on 2017/11/12.
//  Copyright © 2017年 渡辺唯都. All rights reserved.
//

import UIKit

class Customcell1TableViewCell: UITableViewCell {
    
    /// イメージを表示するImageView
    @IBOutlet weak var ImageView: UIImageView!
    /// タイトルを表示するLabel
    @IBOutlet weak var TitleLabel: UILabel!
    /// 説明を表示するLabel
    @IBOutlet weak var DescriptionLabel: UILabel!
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    
    

}
