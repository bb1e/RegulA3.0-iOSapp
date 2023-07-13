//
//  TipoEstrategiaCollectionViewCell.swift
//  ProjetoRegula3.0
//
//  Created by projeto on 01/06/2023.
//

import UIKit


class TipoEstrategiaCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var titulo: UILabel!
    
    @IBAction func goToCurrentType(_ sender: Any) {
        if let tituloText = titulo.text {
            parentViewController?.performSegue(withIdentifier: "byEstrategiaSegue", sender: tituloText)
        }
    }
    
    public weak var parentViewController: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Find the parent view controller
        if let responder = self.next, let viewController = responder as? UIViewController {
            parentViewController = viewController
        }
    }
}
