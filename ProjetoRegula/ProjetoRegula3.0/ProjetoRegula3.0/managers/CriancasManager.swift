//
//  CriançasManager.swift
//  ProjetoRegula3.0
//
//  Created by projeto on 29/05/2023.
//

import Firebase
import FirebaseAuth
class CriancasManager{
    
    init(){

        
        
    }
    func fetchEstrategiaFavCriancaId(crianca: Crianca,completion: @escaping ([Estrategia]) -> Void){
       
        //connectar ao firebase
        let db = Firestore.firestore()
        let ref = db.collection("criancas_test").whereField("id", isEqualTo: crianca.id)
        
        ref.getDocuments{snapshot, error in
            //caso nao consiga dá erro
            guard error == nil else {
                print(error!.localizedDescription)
                return;
            }
            var fetchedEstrategias: [Estrategia] = []
            
            //Por dentro do Array
            if let snapshot = snapshot{
                for document in snapshot.documents{
                    let data = document.data()
                    
                    let data2 = data["estrategiasFavoritas"] as? [Any] ?? []
                    for estrategiasfav in data2{
                        
        
                        if let estrategiasfav = estrategiasfav as? [String: Any] {
                            let dataEstrategia = estrategiasfav["data"] as? Int ?? -1
                            let descricaoEstrategia = estrategiasfav["descricao"] as? String ?? ""
                            let idEstrategia = estrategiasfav["id"] as? Int ?? -1
                            let tipoEstrategia = estrategiasfav["tipoAlvo"] as? String ?? ""
                            let tituloEstrategia = estrategiasfav["titulo"] as? String ?? ""
                            
                            let verifica = estrategiasfav["verificado"] as? Int ?? -1
                            var verificado = true
                            if verifica == -1 || verifica == 0{
                                verificado = false
                            }else{
                                verificado = true
                            }
                            
                            let novaEstrategia = Estrategia(data: dataEstrategia, descricao: descricaoEstrategia, id: idEstrategia, tipoAlvo: tipoEstrategia, titulo: tituloEstrategia, verificado: verificado)
                         
                            fetchedEstrategias.append(novaEstrategia)
                        }
                    
                    }
                    
                    let data3 = data["estrategiasRecomendadas"] as? [Any] ?? []
                    var estrategiasRecomendadas:[Estrategia] = []
                    
                    for estrategiasfav in data3{
                        
        
                        if let estrategiasfav = estrategiasfav as? [String: Any] {
                            let dataEstrategia = estrategiasfav["data"] as? Int ?? -1
                            let descricaoEstrategia = estrategiasfav["descricao"] as? String ?? ""
                            let idEstrategia = estrategiasfav["id"] as? Int ?? -1
                            let tipoEstrategia = estrategiasfav["tipoAlvo"] as? String ?? ""
                            let tituloEstrategia = estrategiasfav["titulo"] as? String ?? ""
                            
                            let verifica = estrategiasfav["verificado"] as? Int ?? -1
                            var verificado = true
                            if verifica == -1 || verifica == 0{
                                verificado = false
                            }else{
                                verificado = true
                            }
                            
                            let novaEstrategia = Estrategia(data: dataEstrategia, descricao: descricaoEstrategia, id: idEstrategia, tipoAlvo: tipoEstrategia, titulo: tituloEstrategia, verificado: verificado)
                         
                            estrategiasRecomendadas.append(novaEstrategia)
                        }
                    
                    }
                }
            }
            completion(fetchedEstrategias)
        }
    }
    
    
    func fetchCriancas(completion: @escaping ([Crianca]) -> Void){
       
        //connectar ao firebase
        let db = Firestore.firestore()
        let ref = db.collection("criancas_test").whereField("idSession", isEqualTo: Auth.auth().currentUser!.uid)
        
        ref.getDocuments{snapshot, error in
            //caso nao consiga dá erro
            guard error == nil else {
                print(error!.localizedDescription)
                return;
            }
            var fetchedCriancas: [Crianca] = []
            
            //Por dentro do Array
            if let snapshot = snapshot{
                for document in snapshot.documents{
                    let data = document.data()
                    
                    
                    let comentario = data["comentario"] as? String ?? ""
                    let created_at = data["created_at"] as? Int ?? -1
                    let dataUltimaAvaliacao = data["dataUltimaAvaliacao"] as? String ?? ""
                    let genero = data["genero"] as? String ?? ""
                    let idSession = data["idSession"] as? String ?? ""
                    let idTerapeuta = data["idTerapeuta"] as? String ?? ""
                    let nome = data["nome"] as? String ?? ""
                    let parentName = data["parentName"] as? String ?? ""
                    let status = data["status"] as? String ?? ""
                    let storageImageRef = data["storageImageRef"] as? String ?? ""
                    let tipoAutismo = data["tipoAutismo"] as? String ?? ""
                    let id = data["id"] as? String ?? ""
                    let ssAv1f = data["ssAv1"] as? String ?? ""
                    let ssAv2f = data["ssAv2"] as? String ?? ""
                    let ssAv3f = data["ssAv3"] as? String ?? ""
                    let ssAv4f = data["ssAv4"] as? String ?? ""
                    let ssAv5f = data["ssAv5"] as? String ?? ""
                    let ssAv6f = data["ssAv6"] as? String ?? ""
                    let ssAv7f = data["ssAv7"] as? String ?? ""
                    let data2 = data["estrategiasFavoritas"] as? [Any] ?? []
                    var estrategiasFavoritas:[Estrategia] = []
                    var dataNascimento: DataNascimento = DataNascimento(ano: 1970, dia: 1, horas: 1, idade: 1, mes: 1, mesStr: "JAN", miniAno: 21, minutos: 1)
                    for estrategiasfav in data2{
                        
        
                        if let estrategiasfav = estrategiasfav as? [String: Any] {
                            let dataEstrategia = estrategiasfav["data"] as? Int ?? -1
                            let descricaoEstrategia = estrategiasfav["descricao"] as? String ?? ""
                            let idEstrategia = estrategiasfav["id"] as? Int ?? -1
                            let tipoEstrategia = estrategiasfav["tipoAlvo"] as? String ?? ""
                            let tituloEstrategia = estrategiasfav["titulo"] as? String ?? ""
                            
                            let verifica = estrategiasfav["verificado"] as? Int ?? -1
                            var verificado = true
                            if verifica == -1 || verifica == 0{
                                verificado = false
                            }else{
                                verificado = true
                            }
                            
                            let novaEstrategia = Estrategia(data: dataEstrategia, descricao: descricaoEstrategia, id: idEstrategia, tipoAlvo: tipoEstrategia, titulo: tituloEstrategia, verificado: verificado)
                         
                            estrategiasFavoritas.append(novaEstrategia)
                        }
                    
                    }
                    
                    let data3 = data["estrategiasRecomendadas"] as? [Any] ?? []
                    
                    var estrategiasRecomendadas:[Estrategia] = []
                    
                    for estrategiasfav in data3{
                        
        
                        if let estrategiasfav = estrategiasfav as? [String: Any] {
                            let dataEstrategia = estrategiasfav["data"] as? Int ?? -1
                            let descricaoEstrategia = estrategiasfav["descricao"] as? String ?? ""
                            let idEstrategia = estrategiasfav["id"] as? Int ?? -1
                            let tipoEstrategia = estrategiasfav["tipoAlvo"] as? String ?? ""
                            let tituloEstrategia = estrategiasfav["titulo"] as? String ?? ""
                            

                            
                            
                            let verifica = estrategiasfav["verificado"] as? Int ?? -1
                            var verificado = true
                            if verifica == -1 || verifica == 0{
                                verificado = false
                            }else{
                                verificado = true
                            }
                            
                            let novaEstrategia = Estrategia(data: dataEstrategia, descricao: descricaoEstrategia, id: idEstrategia, tipoAlvo: tipoEstrategia, titulo: tituloEstrategia, verificado: verificado)
                         
                            estrategiasRecomendadas.append(novaEstrategia)
                        }
                    
                    }
                    
                    let dataani = data["dataNascimento"] as? Dictionary ?? [:]
                    
        
                    let ano = dataani[AnyHashable("ano")] as? Int ?? -1
                    let dia = dataani[AnyHashable("dia")] as? Int ?? -1
                    let horas = dataani[AnyHashable("horas")] as? Int ?? -1
                    let idade = dataani[AnyHashable("idade")] as? Int ?? -1
                    let mes = dataani[AnyHashable("mes")] as? Int ?? -1
                    let mesStr = dataani[AnyHashable("mesStr")] as? String ?? ""
                    let miniAno = dataani[AnyHashable("miniAno")] as? String ?? ""
                    let minutos = dataani[AnyHashable("minutos")] as? Int ?? -1



                    dataNascimento = DataNascimento(ano: ano, dia: dia, horas: horas, idade: idade, mes: mes, mesStr: mesStr.prefix(3).uppercased(), miniAno: Int(miniAno) ?? -1, minutos: minutos)
                    let crianca = Crianca(comentario: comentario, created_at: created_at, dataNascimento: dataNascimento, dataUltimaAvaliacao: dataUltimaAvaliacao, id: id, genero: genero, idSession: idSession, idTerapeuta: idTerapeuta, nome: nome, parentName: parentName, status:status, storageImageRef: storageImageRef, tipoAutismo: tipoAutismo, estrategiasFavoritas: estrategiasFavoritas, estrategiasRecomendadas: estrategiasRecomendadas, ssAv1: ssAv1f,ssAv2: ssAv2f,ssAv3:ssAv3f,ssAv4:ssAv4f,ssAv5:ssAv5f,ssAv6:ssAv6f,ssAv7:ssAv7f)
                    
                    fetchedCriancas.append(crianca)
                    
                }
            }
            completion(fetchedCriancas)
        }
    }
    
    
}

