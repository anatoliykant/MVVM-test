//
//  TableViewCell.swift
//  MVVM Test
//
//  Created by kant on 10.08.17.
//  Copyright © 2017 kant. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
  
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var populateLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }  
}
