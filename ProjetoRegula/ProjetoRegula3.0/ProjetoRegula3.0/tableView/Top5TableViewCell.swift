//
//  Top5TableViewCell.swift
//  ProjetoRegula3.0
//
//  Created by projeto on 13/07/2023.
//

import UIKit

class Top5TableViewCell: UITableViewCell {

    @IBOutlet weak var valor: UILabel!
    @IBOutlet weak var titulo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
