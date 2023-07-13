//
//  ViewController.swift
//  ProjetoRegula3.0
//
//  Created by projeto on 19/05/2023.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
     var criancaManager: CriancasManager!

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var filhonome: UILabel!
    
    var criancaSelecionada: Crianca?
    
    
    override func viewDidLoad() {
        let tabbar =  tabBarController as! PrincipalTabBarController
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        super.viewDidLoad()
        
        criancaManager = CriancasManager()
                   
        
        criancaManager.fetchCriancas{result in
            self.spinner.stopAnimating()
            if(result.count == 0){
                let storyboard = UIStoryboard(name: "Main",bundle: nil)
                let vc = storyboard.instantiateViewController(identifier: "createchildpage")
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc,animated: true)
            }else{
                self.criancaSelecionada = result[0]
                self.filhonome.text = self.criancaSelecionada?.nome
                print(self.criancaSelecionada?.dataNascimento)
                tabbar.crianca = self.criancaSelecionada
            }
        }
       
    }

    @IBAction func goToRegisto(_ sender: Any) {
        performSegue(withIdentifier: "goToRegistoSemanal", sender: self)
    }
    @IBAction func goToTrocar(_ sender: Any) {
        performSegue(withIdentifier: "goToTrocarCriancas", sender: self)
    }
    @IBAction func didTapButton(){
       
       performSegue(withIdentifier: "goToEstrategias", sender: self)
    }
    
    @IBAction func unwindToMainPage(_ sender: UIStoryboardSegue){
        filhonome.text = criancaSelecionada?.nome
        let tabbar = tabBarController as! PrincipalTabBarController
        tabbar.crianca = criancaSelecionada
        
    }
    
    ///Preparacao dos Segues para enviar informacao para outras janelas
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEstrategias" {
            if let destinationVC = segue.destination as? EstrategiasViewController {
                // Access the variable from the segue and assign it to a property in the destination view controller
                destinationVC.crianca = criancaSelecionada
            }
        }
        if segue.identifier == "goToRegistoSemanal" {
            if let destinationVC = segue.destination as? RegistoSemanalViewController {
                // Access the variable from the segue and assign it to a property in the destination view controller
                destinationVC.crianca = criancaSelecionada
            }
        }
    }
    
    @IBAction func createCrianca(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main",bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "createchildpage")
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc,animated: true)
    }
    override func viewWillDisappear(_ animated: Bool){
        let tabbar = tabBarController as! PrincipalTabBarController
        tabbar.crianca = criancaSelecionada
    }
}

