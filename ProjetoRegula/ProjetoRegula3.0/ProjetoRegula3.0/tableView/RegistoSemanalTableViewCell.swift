//
//  RegistoSemanalTableViewCell.swift
//  ProjetoRegula3.0
//
//  Created by projeto on 13/07/2023.
//

import UIKit

class RegistoSemanalTableViewCell: UITableViewCell {

    @IBOutlet weak var comentario: UILabel!
    @IBOutlet weak var higieneP: UILabel!
    @IBOutlet weak var jogar: UILabel!
    @IBOutlet weak var decanso: UILabel!
    @IBOutlet weak var higieneS: UILabel!
    @IBOutlet weak var alimentacao: UILabel!
    @IBOutlet weak var vestir: UILabel!
    @IBOutlet weak var banho: UILabel!
    @IBOutlet weak var semana: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
