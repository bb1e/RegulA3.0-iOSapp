//
//  TrocarCriancasViewController.swift
//  ProjetoRegula3.0
//
//  Created by projeto on 31/05/2023.
//

import UIKit

class TrocarCriancasViewController: UIViewController {
    var criancaManager: CriancasManager!
    var criancasdoPai: [Crianca] = []
    @IBOutlet weak var criancaspicker: UIPickerView!
    var criancaEscolhida: Crianca?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        criancaManager = CriancasManager()
                   
        criancasdoPai = []
        
        criancaManager.fetchCriancas{result in
            for criancas in result {
                self.criancasdoPai.append(criancas)
            }
            self.criancaEscolhida = self.criancasdoPai[0]
            self.criancaspicker.delegate = self
            self.criancaspicker.dataSource = self
            self.criancaspicker.tag = 1
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapToGuardar(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! ViewController
        destVC.criancaSelecionada = criancaEscolhida
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

extension TrocarCriancasViewController:UIPickerViewDataSource,UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return criancasdoPai.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return criancasdoPai[row].nome
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        criancaEscolhida = criancasdoPai[row]
    }
}
