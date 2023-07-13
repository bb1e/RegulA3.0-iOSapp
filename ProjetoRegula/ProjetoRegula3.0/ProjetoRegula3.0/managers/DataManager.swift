//
//  DataManager.swift
//  ProjetoRegula3.0
//
//  Created by projeto on 19/05/2023.
//


import Firebase

class DataManager{

    init(){
        
    }
    
    func fetchEstrategiasByTipoAndTitulo(tipo: String,titulo: String,completion: @escaping ([Estrategia]) -> Void){
    
        //connectar ao firebase
        let db = Firestore.firestore()
        
        let ref = db.collection("estrategias_demo")
        var result = ref.whereField("tipoAlvo", isEqualTo: tipo).whereField("titulo", isEqualTo: titulo)
        
        if(titulo == "Estratégias Regulatórias"){
            result = ref.whereField("tipoAlvo", isEqualTo: "Nenhum").whereField("titulo", isEqualTo: titulo)
        }
            
        
        result.getDocuments{snapshot, error in
            //caso nao consiga dá erro
            guard error == nil else {
                print(error!.localizedDescription)
                return;
            }
            
            var fetchedEstrategia: [Estrategia] = []
            //Por dentro do Array
            if let snapshot = snapshot{
                for document in snapshot.documents{
                    let data = document.data()
                    
                    let id = data["id"] as? Int ?? -1
                    let descricao = data["descricao"] as? String ?? ""
                    let tipoAlvo = data["tipoAlvo"] as? String ?? ""
                    let titulo = data["titulo"] as? String ?? ""
                    let datap = data["data"] as? Int ?? -1
                    let verificado = data["verificado"] as? Bool ?? false
                    
                    let estrategia = Estrategia(data: datap,descricao: descricao,id: id, tipoAlvo: tipoAlvo, titulo: titulo ,verificado: verificado)
                    
                    fetchedEstrategia.append(estrategia)
                }
               
            }
            completion(fetchedEstrategia)
        }
    }
    
    func fetchTipoEstrategias(completion: @escaping ([String]) -> Void){
    
        //connectar ao firebase
        let db = Firestore.firestore()
        let ref = db.collection("estrategias_demo")
        
        ref.getDocuments{snapshot, error in
            //caso nao consiga dá erro
            guard error == nil else {
                print(error!.localizedDescription)
                return;
            }
            
            var fetchedTipo: [String] = []
            //Por dentro do Array
            if let snapshot = snapshot{
                for document in snapshot.documents{
                    let data = document.data()
                    
                    if !fetchedTipo.contains(data["tipoAlvo"] as? String ?? " "){
                        
                        if(data["tipoAlvo"]  as? String ?? " " != "Nenhum"){
                            fetchedTipo.append(data["tipoAlvo"] as? String ?? " ")
                        }
                    }
                }
            }
            completion(fetchedTipo)
        }
    }
    
    
    func fetchTituloEstrategiasByTipo(tipo: String,completion: @escaping ([String]) -> Void){
    
        //connectar ao firebase
        let db = Firestore.firestore()
        let ref = db.collection("estrategias_demo").whereField("tipoAlvo", in: [tipo,"Nenhum"])
        
        ref.getDocuments{snapshot, error in
            //caso nao consiga dá erro
            guard error == nil else {
                print(error!.localizedDescription)
                return;
            }
            
            var fetchedTipo: [String] = []
            //Por dentro do Array
            if let snapshot = snapshot{
                for document in snapshot.documents{
                    let data = document.data()
                    
                    if !fetchedTipo.contains(data["titulo"] as? String ?? " "){
                        fetchedTipo.append(data["titulo"] as? String ?? " ")
                    }
                }
            }
            completion(fetchedTipo)
        }
    }
}
