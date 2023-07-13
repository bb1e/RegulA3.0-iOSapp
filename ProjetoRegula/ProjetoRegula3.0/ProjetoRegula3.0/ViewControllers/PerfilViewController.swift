//
//  PerfilViewController.swift
//  ProjetoRegula3.0
//
//  Created by projeto on 07/07/2023.
//

import UIKit

class PerfilViewController: UIViewController {

    var crianca: Crianca?
    
    @IBOutlet weak var texto2: UILabel!
    @IBOutlet weak var texto3: UILabel!
    @IBOutlet weak var titulo1: UILabel!
    @IBOutlet weak var textoPlace: UILabel!
    @IBOutlet weak var sensorial: UILabel!
    @IBOutlet weak var dataNascimento: UILabel!
    @IBOutlet weak var vestibular: UISegmentedControl!
    @IBOutlet weak var propriocetivo: UISegmentedControl!
    @IBOutlet weak var gustativo: UISegmentedControl!
    @IBOutlet weak var olfativo: UISegmentedControl!
    @IBOutlet weak var visual: UISegmentedControl!
    @IBOutlet weak var tatil: UISegmentedControl!
    @IBOutlet weak var auditivo: UISegmentedControl!
    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var dataAni: UILabel!
    @IBOutlet weak var chooseInforDash: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabbar = tabBarController as! PrincipalTabBarController
        crianca = tabbar.crianca
        
        nome.text = crianca?.nome
        dataAni.text = "\(crianca?.dataNascimento.dia ?? 1) / \(crianca?.dataNascimento.mes ?? 1) / \(crianca?.dataNascimento.ano ?? 1970)"
        
        tatil.setTitle(crianca?.ssAv1, forSegmentAt: 1)
        auditivo.setTitle(crianca?.ssAv2, forSegmentAt: 1)
        visual.setTitle(crianca?.ssAv3, forSegmentAt: 1)
        olfativo.setTitle(crianca?.ssAv4, forSegmentAt: 1)
        gustativo.setTitle(crianca?.ssAv5, forSegmentAt: 1)
        propriocetivo.setTitle(crianca?.ssAv6, forSegmentAt: 1)
        vestibular.setTitle(crianca?.ssAv7, forSegmentAt: 1)




    }
    
    @IBAction func changeChoice(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex

        if selectedIndex == 0 {
            nome.isHidden = false
            dataAni.isHidden = false
            
            tatil.isHidden = false
            auditivo.isHidden = false
            visual.isHidden = false
            olfativo.isHidden = false
            gustativo.isHidden = false
            propriocetivo.isHidden = false
            vestibular.isHidden = false
            
            texto2.isHidden = false
            texto3.isHidden = false
            titulo1.isHidden = false
            textoPlace.isHidden = false
            sensorial.isHidden = false
            dataNascimento.isHidden = false
        }else{
            nome.isHidden = true
            dataAni.isHidden = true
            
            tatil.isHidden = true
            auditivo.isHidden = true
            visual.isHidden = true
            olfativo.isHidden = true
            gustativo.isHidden = true
            propriocetivo.isHidden = true
            vestibular.isHidden = true
       
            
            texto2.isHidden = true
            texto3.isHidden = true
            titulo1.isHidden = true
            textoPlace.isHidden = true
            sensorial.isHidden = true
            dataNascimento.isHidden = true
        }
    }

    override func viewWillAppear(_ animated: Bool){
        print("entrei")
        let tabbar = tabBarController as! PrincipalTabBarController
        crianca = tabbar.crianca
        
        nome.text = crianca?.nome
        dataAni.text = "\(crianca?.dataNascimento.dia ?? 1) / \(crianca?.dataNascimento.mes ?? 1) / \(crianca?.dataNascimento.ano ?? 1970)"
        
        tatil.setTitle(crianca?.ssAv1, forSegmentAt: 1)
        auditivo.setTitle(crianca?.ssAv2, forSegmentAt: 1)
        visual.setTitle(crianca?.ssAv3, forSegmentAt: 1)
        olfativo.setTitle(crianca?.ssAv4, forSegmentAt: 1)
        gustativo.setTitle(crianca?.ssAv5, forSegmentAt: 1)
        propriocetivo.setTitle(crianca?.ssAv6, forSegmentAt: 1)
        vestibular.setTitle(crianca?.ssAv7, forSegmentAt: 1)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

