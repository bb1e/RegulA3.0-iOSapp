//
//  EstrategiaTableViewCell.swift
//  ProjetoRegula3.0
//
//  Created by projeto on 01/06/2023.
//

import UIKit
import Firebase
import FirebaseAuth

class EstrategiaTableViewCell: UITableViewCell {

    @IBOutlet weak var texto: UILabel!
    var crianca: Crianca?
    var estrategia: Estrategia?
    @IBOutlet weak var botaoComen: UIButton!
    @IBOutlet weak var botaoFav: UIButton!
    var criancasManager: CriancasManager!
	
    @IBAction func pressButtonFav(_ sender: Any) {
        
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
                    self.botaoFav.setImage(UIImage(systemName: "heart"), for: .normal)
                }
            }else{
                self.addtoFav(crianca: criancaSel){ result in
                    self.botaoFav.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                    print("adicionei")
                }
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


    
}




    


