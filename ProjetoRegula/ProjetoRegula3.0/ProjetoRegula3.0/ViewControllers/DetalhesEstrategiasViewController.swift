//
//  DetalhesEstrategiasViewController.swift
//  ProjetoRegula3.0
//
//  Created by projeto on 08/07/2023.
//

import UIKit
import Firebase
class DetalhesEstrategiasViewController: UIViewController {

    var estrategia : Estrategia?
    var crianca: Crianca?
    @IBOutlet weak var feedbackBtn: UIButton!
    @IBOutlet weak var feedbackText: UITextField!
    @IBOutlet weak var favBtn: UIBarButtonItem!
    @IBOutlet weak var barAvaliacao: UISlider!
    @IBOutlet weak var estretegia: UILabel!
    var criancasManager: CriancasManager!
    override func viewDidLoad() {
        super.viewDidLoad()

        let texto = "<p style = \"font-family: '-apple-system', 'HelveticaNeue'; font-size: \(estretegia.font.pointSize)\">\(estrategia?.descricao ?? "erro")</p>"
        estretegia.attributedText = texto.htmlToAttributedString
    
        barAvaliacao.isContinuous = false

        let criancaSel = crianca ?? Crianca(comentario: "null", created_at: -1, dataNascimento: DataNascimento(ano: 2001, dia: 11, horas: 11, idade: 1, mes: 1, mesStr: "Maio", miniAno: 01, minutos: 11), dataUltimaAvaliacao: "null", id: "", genero: "null", idSession: "null", idTerapeuta: "null", nome: "null", parentName: "null", status:"null", storageImageRef: "null", tipoAutismo: "null", estrategiasFavoritas: [], estrategiasRecomendadas: [],ssAv1: "Nenhum",ssAv2: "Nenhum",ssAv3:"Nenhum",ssAv4:"Nenhum",ssAv5:"Nenhum",ssAv6:"Nenhum",ssAv7:"Nenhum")
        
        estrategia = estrategia ?? Estrategia(data: -1, descricao: "", id: -1, tipoAlvo: "", titulo: "", verificado: false)
        
        criancasManager = CriancasManager()
        
        criancasManager.fetchEstrategiaFavCriancaId(crianca: criancaSel){ result2 in
            
            var verificador = false
            for estrategiaFav in result2{
                if estrategiaFav.id == self.estrategia?.id as? Int ?? -1{
                    verificador = true
                }
            }
            
            if verificador{
                    self.favBtn.image = UIImage(systemName: "heart.fill")
            }else{

                    self.favBtn.image = UIImage(systemName: "heart")
            }
        }
    }
    func addtoFav(crianca:Crianca,completion: @escaping (String)-> Void){
        let db = Firestore.firestore()
        let ref = db.collection("criancas_test").document(String(crianca.id))
        
        ref.getDocument{snapshot, error in
            //caso nao consiga dá erro
            guard error == nil else {
                print(error!.localizedDescription)
                return;
            }
            if let snapshot = snapshot{
                _ = snapshot.get("estrategiasFavoritas") as? [Estrategia] ?? []
                let sessionDoc: [String: Any] = [
                    "data": self.estrategia?.data ?? -1,
                    "descricao": self.estrategia?.descricao ?? "",
                    "id": self.estrategia?.id ?? -1,
                    "tipoAlvo": self.estrategia?.tipoAlvo ?? "",
                    "titulo": self.estrategia?.titulo ?? "",
                    "verificado": self.estrategia?.verificado ?? false
                ]
                

                    ref.updateData([
                        "estrategiasFavoritas": FieldValue.arrayUnion([sessionDoc])
                    ])

                
                
            }
        }

            
        completion("Correu certo")
    }
    
    func remtoFav(crianca:Crianca,completion: @escaping (String)-> Void){
        let db = Firestore.firestore()
        let ref = db.collection("criancas_test").document(String(crianca.id))
        
        ref.getDocument{snapshot, error in
            //caso nao consiga dá erro
            guard error == nil else {
                print(error!.localizedDescription)
                return;
            }
            if let snapshot = snapshot{
                let data = snapshot.get("estrategiasFavoritas") as? [Estrategia] ?? []
                let sessionDoc: [String: Any] = [
                    "data": self.estrategia?.data ?? -1,
                    "descricao": self.estrategia?.descricao ?? "",
                    "id": self.estrategia?.id ?? -1,
                    "tipoAlvo": self.estrategia?.tipoAlvo ?? "",
                    "titulo": self.estrategia?.titulo ?? "",
                    "verificado": self.estrategia?.verificado ?? false
                ]
                

                    ref.updateData([
                        "estrategiasFavoritas": FieldValue.arrayRemove([sessionDoc])
                    ])
                
                
            }
        }

            
        completion("Correu certo")
    }

    @IBAction func feedbackChange(_ sender: UISlider) {
        let roundedValue = round(sender.value)
        sender.value = roundedValue
    }
    

    @IBAction func feedbackSend(_ sender: Any) {
        createFeedback(crianca: crianca ?? Crianca(comentario: "null", created_at: -1, dataNascimento: DataNascimento(ano: 2001, dia: 11, horas: 11, idade: 1, mes: 1, mesStr: "Maio", miniAno: 01, minutos: 11), dataUltimaAvaliacao: "null", id: "", genero: "null", idSession: "null", idTerapeuta: "null", nome: "null", parentName: "null", status:"null", storageImageRef: "null", tipoAutismo: "null", estrategiasFavoritas: [], estrategiasRecomendadas: [],ssAv1: "Nenhum",ssAv2: "Nenhum",ssAv3:"Nenhum",ssAv4:"Nenhum",ssAv5:"Nenhum",ssAv6:"Nenhum",ssAv7:"Nenhum"),estrategia: estrategia ?? Estrategia(data: -1, descricao: "", id: -1, tipoAlvo: "", titulo: "", verificado: false)){result in
            print("Enviei feedback")
            self.showToast(message: "O seu feedback foi enviado", font: .systemFont(ofSize: 16.0))
        }
    }
    
    func createFeedback(crianca:Crianca,estrategia:Estrategia,completion: @escaping (String)-> Void){
        let db = Firestore.firestore()

        let dataHoje = Date()

        
        let idCrianca = String(crianca.id)
        let estrategiaId = String(estrategia.id)
        let doct = String(format:"%.0f",round(Date().timeIntervalSince1970 * 1000))
        let created_at = Int(doct)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let year: String = dateFormatter.string(from: dataHoje)

        dateFormatter.dateFormat = "MM"
        let month: String = dateFormatter.string(from:dataHoje)


        dateFormatter.dateFormat = "dd"
        let day: String = dateFormatter.string(from:dataHoje)

        dateFormatter.dateFormat = "HH"
        let hour: String = dateFormatter.string(from:dataHoje)

        
        dateFormatter.dateFormat = "mm"
        let minutes: String = dateFormatter.string(from:dataHoje)

        
        dateFormatter.dateFormat = "MMM"
        let extenso: String = dateFormatter.string(from:dataHoje)

        
        
        let newSession = db.collection("feedbackEstrategias_demo").document(doct)
        let sessionDoc: [String: Any] = [
            "idCrianca": idCrianca,
            "id": created_at ?? "",
            "comentario" : feedbackText.text ?? "",
            "data": [
                "ano": year,
                "dia": day,
                "horas": hour,
                "idade": 0,
                "mes": month,
                "mesStr": String(extenso.prefix(3)).uppercased(),
                "miniAno": year.suffix(2),
                "minutos": minutes
            ],
            "realizou" : true,
            "idEstrategia": estrategiaId,
            "avaliacao": barAvaliacao.value
        ]
        newSession.setData(sessionDoc){[weak self] err in
            guard let strongSelf = self else {return}
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
        }
            
        completion("Correu certo")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func favPressed(_ sender: Any) {
        let criancaSel = crianca ?? Crianca(comentario: "null", created_at: -1, dataNascimento: DataNascimento(ano: 2001, dia: 11, horas: 11, idade: 1, mes: 1, mesStr: "Maio", miniAno: 01, minutos: 11), dataUltimaAvaliacao: "null", id: "", genero: "null", idSession: "null", idTerapeuta: "null", nome: "null", parentName: "null", status:"null", storageImageRef: "null", tipoAutismo: "null", estrategiasFavoritas: [], estrategiasRecomendadas: [],ssAv1: "Nenhum",ssAv2: "Nenhum",ssAv3:"Nenhum",ssAv4:"Nenhum",ssAv5:"Nenhum",ssAv6:"Nenhum",ssAv7:"Nenhum")
        
        criancasManager = CriancasManager()
        
        criancasManager.fetchEstrategiaFavCriancaId(crianca: criancaSel){result2 in
            
            var verificador = false
            for estrategiaFav in result2{
                if estrategiaFav.id == self.estrategia?.id as? Int ?? -1{
                    verificador = true
                }
            }
            
            if verificador{
                self.remtoFav(crianca: criancaSel){result in
                    print("removi")
                    self.favBtn.image = UIImage(systemName: "heart")

                }
            }else{
                self.addtoFav(crianca: criancaSel){ result in
                    self.favBtn.image = UIImage(systemName: "heart.fill")
                    print("adicionei")
                }
            }
        }
    }
    override func viewWillAppear(_ animated: Bool){
        let criancaSel = crianca ?? Crianca(comentario: "null", created_at: -1, dataNascimento: DataNascimento(ano: 2001, dia: 11, horas: 11, idade: 1, mes: 1, mesStr: "Maio", miniAno: 01, minutos: 11), dataUltimaAvaliacao: "null", id: "", genero: "null", idSession: "null", idTerapeuta: "null", nome: "null", parentName: "null", status:"null", storageImageRef: "null", tipoAutismo: "null", estrategiasFavoritas: [], estrategiasRecomendadas: [],ssAv1: "Nenhum",ssAv2: "Nenhum",ssAv3:"Nenhum",ssAv4:"Nenhum",ssAv5:"Nenhum",ssAv6:"Nenhum",ssAv7:"Nenhum")
        
        criancasManager = CriancasManager()
        
        criancasManager.fetchEstrategiaFavCriancaId(crianca: criancaSel){ result2 in
            
            var verificador = false
            for estrategiaFav in result2{
                if estrategiaFav.id == self.estrategia?.id as? Int ?? -1{
                    verificador = true
                }
            }
            
            if verificador{
                    self.favBtn.image = UIImage(systemName: "heart.fill")
            }else{

                    self.favBtn.image = UIImage(systemName: "heart")
            }
        }
    }
}

extension String{
    var htmlToAttributedString: NSAttributedString?
    {
        guard let data = data(using: .utf8) else {return nil}
        do{
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }catch{
            return nil
        }
    }
}
