//
//  CreateChildViewController.swift
//  ProjetoRegula3.0
//
//  Created by projeto on 29/05/2023.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class CreateChildViewController: UIViewController {
    @IBOutlet weak var criancanome: UITextField!
    var criancaManager: CriancasManager!

    @IBOutlet weak var voltarAtrasBtn: UIButton!
    @IBOutlet weak var genero: UISegmentedControl!
    @IBOutlet weak var dataNascimento: UIDatePicker!
    
    override func viewDidLoad() {
        criancaManager = CriancasManager()
        super.viewDidLoad()
        
        criancaManager.fetchCriancas(){ result in
            if result.isEmpty{
                self.voltarAtrasBtn.isHidden = true
            }
        }
    
        // Do any additional setup after loading the view.
    }
    

    @IBAction func register(_ sender: Any) {
        if(criancanome.text?.isEmpty == true){
            print("Por favor preencher nome da crianca")
            return
        }
        
        let date3y = Calendar.current.date(byAdding: .year, value: -3, to: Date()) ?? Date()
        let date6y = Calendar.current.date(byAdding: .year, value: -6, to: Date()) ?? Date()
        
        print(dataNascimento.date.timeIntervalSince(date6y))
        print(dataNascimento.date.timeIntervalSince(date3y))
        if (dataNascimento.date.timeIntervalSince(date3y) > 0 || dataNascimento.date.timeIntervalSince(date6y) < 0){
            print("Por favor meter uma data entre 3 a 6 anos atras")
            return
        }
        
     addCrianca()
    }
    
    @IBAction func voltarAtrasBtnPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main",bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "mainpage")
        vc.modalPresentationStyle = .overFullScreen
        present(vc,animated: true)
    }
    func addCrianca(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let year: String = dateFormatter.string(from: self.dataNascimento.date)
        dateFormatter.dateFormat = "MM"
        let month: String = dateFormatter.string(from:self.dataNascimento.date)
        dateFormatter.dateFormat = "dd"
        let day: String = dateFormatter.string(from:self.dataNascimento.date)
        dateFormatter.dateFormat = "HH"
        let hour: String = dateFormatter.string(from:self.dataNascimento.date)
        dateFormatter.dateFormat = "mm"
        let minutes: String = dateFormatter.string(from:self.dataNascimento.date)
        dateFormatter.dateFormat = "MMM"
        let extenso: String = dateFormatter.string(from:self.dataNascimento.date)
        
        let generoS = genero.titleForSegment(at: genero.selectedSegmentIndex) ?? "error"
        let age = Calendar.current.dateComponents([.year], from: dataNascimento.date, to: Date()).year!
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let datetoday = dateFormatter.string(from: Date())
        let nomeC = criancanome.text!

        let db = Firestore.firestore()
        
        let filename = String(format:"%.0f",round(Date().timeIntervalSince1970 * 1000))
    
        let created_at = Int(filename)
    
        
        let newCrianca = db.collection("criancas_test").document(filename)
       

        
        let criancaDoc: [String: Any] = [
            "comentario": NSNull(),
            "dataNascimento": [
                "ano": Int(year) ?? -1,
                "dia": Int(day) ?? -1,
                "horas": Int(hour) ?? -1,
                "idade": Int(age),
                "mes": Int(month) ?? -1,
                "mesStr": extenso,
                "miniAno": year.suffix(2),
                "minutos": Int(minutes) ?? -1
            ],
            "dataUltimaAvaliacao": datetoday,
            "genero": generoS,
            "idSession": Auth.auth().currentUser!.uid,
            "idTerapeuta": "Teste",
            "nome": nomeC,
            "id": filename,
            "created_at": created_at ?? -1,
            "parentName": "Teste",
            "status": "Hello World!!!",
            "storageImageRef": NSNull(),
            "tipoAutismo": "Nenhum",
            "estrategiasFavoritas": [],
            "estrategiasRecomendadas": [],
            "ssAv1": "Nenhum",
            "ssAv2": "Nenhum",
            "ssAv3": "Nenhum",
            "ssAv4": "Nenhum",
            "ssAv5": "Nenhum",
            "ssAv6": "Nenhum",
            "ssAv7": "Nenhum"
        ]
        
    
        
        newCrianca.setData(criancaDoc){[weak self] err in
            guard let strongSelf = self else {return}
            if let err = err {
                print(err.localizedDescription)
            return
        
    }
            
        }
        let storyboard = UIStoryboard(name: "Main",bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "mainpage")
        vc.modalPresentationStyle = .overFullScreen
        present(vc,animated: true)
        
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
