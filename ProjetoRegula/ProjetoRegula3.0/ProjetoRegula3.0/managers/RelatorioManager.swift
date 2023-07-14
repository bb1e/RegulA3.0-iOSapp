//
//  RelatorioManager.swift
//  ProjetoRegula3.0
//
//  Created by projeto on 07/07/2023.
//

import Foundation
import Firebase

class RelatorioManager{
    init(){

        
        
    }
    
    func fetchRelatorioCriancaId(crianca: Crianca,completion: @escaping (RegistoSemanal) -> Void){
        let db = Firestore.firestore()
        var dataInicio = Date().startOfWeek
        var dataFim = Date().endOfWeek
        let dateFormatter = DateFormatter()
       
       dateFormatter.dateFormat = "dd/MM/yyyy"

       let dataf = dateFormatter.string(from: dataFim ?? Date())
       let datai = dateFormatter.string(from: dataInicio ?? Date())
       var semana = "Semana de \(datai) a \(dataf)"
        
        let ref = db.collection("relatorioSemanal").whereField("idCrianca", isEqualTo: crianca.id).whereField("semana", isEqualTo: semana)
        
        var registoSemanal = RegistoSemanal(dataFimSemana: DataNascimento(ano: 2001, dia: 11, horas: 11, idade: 1, mes: 1, mesStr: "Maio", miniAno: 01, minutos: 11), diaInicioSemana: DataNascimento(ano: 2001, dia: 11, horas: 11, idade: 1, mes: 1, mesStr: "Maio", miniAno: 01, minutos: 11), avaliacao1: -1, avaliacao2: -1, avaliacao3: -1, avaliacao4: -1, avaliacao5: -1, avaliacao6: -1, avaliacao7: -1, comentario: "", data: DataNascimento(ano: 2001, dia: 11, horas: 11, idade: 1, mes: 1, mesStr: "Maio", miniAno: 01, minutos: 11), id: -1, idCrianca: "", semana: "")
        
        ref.getDocuments{snapshot, error in
            //caso nao consiga dá erro
            guard error == nil else {
                print(error!.localizedDescription)
                return;
            }
            
        
            if let snapshot = snapshot{
                for document in snapshot.documents{
                    let data = document.data()
                    let avaliacao1 = data["avaliacao1"] as? Int ?? -1
                    let avaliacao2 = data["avaliacao2"] as? Int ?? -1
                    let avaliacao3 = data["avaliacao3"] as? Int ?? -1
                    let avaliacao4 = data["avaliacao4"] as? Int ?? -1
                    let avaliacao5 = data["avaliacao5"] as? Int ?? -1
                    let avaliacao6 = data["avaliacao6"] as? Int ?? -1
                    let avaliacao7 = data["avaliacao7"] as? Int ?? -1
                    let comentario = data["comentario"] as? String ?? ""
                    let id = data["id"] as? Int ?? -1
                    let idCrianca = data["idCrianca"] as? String ?? ""
                    let semana = data["semana"] as? String ?? ""
                    
                    let datafim = data["dataFimSemana"] as? Dictionary ?? [:]
                    
        
                    let anof = datafim[AnyHashable("ano")] as? String ?? ""
                    let diaf = datafim[AnyHashable("dia")] as? String ?? ""
                    let horasf = datafim[AnyHashable("horas")] as? String ?? ""
                    let idadef = datafim[AnyHashable("idade")] as? Int ?? -1
                    let mesf = datafim[AnyHashable("mes")] as? String ?? ""
                    let mesStrf = datafim[AnyHashable("mesStr")] as? String ?? ""
                    let miniAnof = datafim[AnyHashable("miniAno")] as? String ?? ""
                    let minutosf = datafim[AnyHashable("minutos")] as? String ?? ""
                    
                    let datah = data["diaInicioSemana"] as? Dictionary ?? [:]
                    
        
                    let anoh = datah[AnyHashable("ano")] as? String ?? ""
                    let diah = datah[AnyHashable("dia")] as? String ?? ""
                    let horash = datah[AnyHashable("horas")] as? String ?? ""
                    let idadeh = datah[AnyHashable("idade")] as? Int ?? -1
                    let mesh = datah[AnyHashable("mes")] as? String ?? ""
                    let mesStrh = datah[AnyHashable("mesStr")] as? String ?? ""
                    let miniAnoh = datah[AnyHashable("miniAno")] as? String ?? ""
                    let minutosh = datah[AnyHashable("minutos")] as? String ?? ""
                    
                    let datai = data["data"] as? Dictionary ?? [:]
                    
        
                    let anoi = datai[AnyHashable("ano")] as? String ?? ""
                    let diai = datai[AnyHashable("dia")] as? String ?? ""
                    let horasi = datai[AnyHashable("horas")] as? String ?? ""
                    let idadei = datai[AnyHashable("idade")] as? Int ?? -1
                    let mesi = datai[AnyHashable("mes")] as? String ?? ""
                    let mesStri = datai[AnyHashable("mesStr")] as? String ?? ""
                    let miniAnoi = datai[AnyHashable("miniAno")] as? String ?? ""
                    let minutosi = datai[AnyHashable("minutos")] as? String ?? ""
                    
                    registoSemanal = RegistoSemanal(dataFimSemana: DataNascimento(ano: Int(anof) ?? -1, dia: Int(diaf) ?? -1, horas: Int(horasf) ?? -1, idade: idadef, mes: Int(mesf) ?? -1, mesStr: mesStrf, miniAno: Int(miniAnof) ?? -1, minutos: Int(minutosf) ?? -1), diaInicioSemana: DataNascimento(ano: Int(anoh) ?? -1, dia: Int(diah) ?? -1, horas: Int(horash) ?? -1, idade: idadeh, mes: Int(mesh) ?? -1, mesStr: mesStrh, miniAno: Int(miniAnoh) ?? -1, minutos: Int(minutosh) ?? -1), avaliacao1: avaliacao1, avaliacao2: avaliacao2, avaliacao3: avaliacao3, avaliacao4: avaliacao4, avaliacao5: avaliacao5, avaliacao6: avaliacao6, avaliacao7: avaliacao7, comentario: comentario, data: DataNascimento(ano: Int(anoi) ?? -1, dia: Int(diai) ?? -1, horas: Int(horasi) ?? -1, idade: idadei, mes: Int(mesi) ?? -1, mesStr: mesStri, miniAno: Int(miniAnoi) ?? -1, minutos: Int(minutosi) ?? -1), id: id, idCrianca: idCrianca, semana: semana)
                    
                    completion(registoSemanal)
                }
                
            }
        }
            completion(registoSemanal)
        }
    
    
    func fetchRelatoriosCriancaId(crianca: Crianca,completion: @escaping ([RegistoSemanal]) -> Void){
        let db = Firestore.firestore()
        var dataInicio = Date().startOfWeek
        var dataFim = Date().endOfWeek
        let dateFormatter = DateFormatter()
        
       dateFormatter.dateFormat = "dd/MM/yyyy"

       let dataf = dateFormatter.string(from: dataFim ?? Date())
       let datai = dateFormatter.string(from: dataInicio ?? Date())
       var semana = "Semana de \(datai) a \(dataf)"
        
        let ref = db.collection("relatorioSemanal").whereField("idCrianca", isEqualTo: crianca.id)
        
        var registoSemanal = RegistoSemanal(dataFimSemana: DataNascimento(ano: 2001, dia: 11, horas: 11, idade: 1, mes: 1, mesStr: "Maio", miniAno: 01, minutos: 11), diaInicioSemana: DataNascimento(ano: 2001, dia: 11, horas: 11, idade: 1, mes: 1, mesStr: "Maio", miniAno: 01, minutos: 11), avaliacao1: -1, avaliacao2: -1, avaliacao3: -1, avaliacao4: -1, avaliacao5: -1, avaliacao6: -1, avaliacao7: -1, comentario: "", data: DataNascimento(ano: 2001, dia: 11, horas: 11, idade: 1, mes: 1, mesStr: "Maio", miniAno: 01, minutos: 11), id: -1, idCrianca: "", semana: "")
        
        ref.getDocuments{snapshot, error in
            //caso nao consiga dá erro
            guard error == nil else {
                print(error!.localizedDescription)
                return;
            }
            var relatorios: [RegistoSemanal] = []
        
            if let snapshot = snapshot{
                for document in snapshot.documents{
                    let data = document.data()
                    let avaliacao1 = data["avaliacao1"] as? Int ?? -1
                    let avaliacao2 = data["avaliacao2"] as? Int ?? -1
                    let avaliacao3 = data["avaliacao3"] as? Int ?? -1
                    let avaliacao4 = data["avaliacao4"] as? Int ?? -1
                    let avaliacao5 = data["avaliacao5"] as? Int ?? -1
                    let avaliacao6 = data["avaliacao6"] as? Int ?? -1
                    let avaliacao7 = data["avaliacao7"] as? Int ?? -1
                    let comentario = data["comentario"] as? String ?? ""
                    let id = data["id"] as? Int ?? -1
                    let idCrianca = data["idCrianca"] as? String ?? ""
                    let semana = data["semana"] as? String ?? ""
                    
                    let datafim = data["dataFimSemana"] as? Dictionary ?? [:]
                    
        
                    let anof = datafim[AnyHashable("ano")] as? String ?? ""
                    let diaf = datafim[AnyHashable("dia")] as? String ?? ""
                    let horasf = datafim[AnyHashable("horas")] as? String ?? ""
                    let idadef = datafim[AnyHashable("idade")] as? Int ?? -1
                    let mesf = datafim[AnyHashable("mes")] as? String ?? ""
                    let mesStrf = datafim[AnyHashable("mesStr")] as? String ?? ""
                    let miniAnof = datafim[AnyHashable("miniAno")] as? String ?? ""
                    let minutosf = datafim[AnyHashable("minutos")] as? String ?? ""
                    
                    let datah = data["diaInicioSemana"] as? Dictionary ?? [:]
                    
        
                    let anoh = datah[AnyHashable("ano")] as? String ?? ""
                    let diah = datah[AnyHashable("dia")] as? String ?? ""
                    let horash = datah[AnyHashable("horas")] as? String ?? ""
                    let idadeh = datah[AnyHashable("idade")] as? Int ?? -1
                    let mesh = datah[AnyHashable("mes")] as? String ?? ""
                    let mesStrh = datah[AnyHashable("mesStr")] as? String ?? ""
                    let miniAnoh = datah[AnyHashable("miniAno")] as? String ?? ""
                    let minutosh = datah[AnyHashable("minutos")] as? String ?? ""
                    
                    let datai = data["data"] as? Dictionary ?? [:]
                    
        
                    let anoi = datai[AnyHashable("ano")] as? String ?? ""
                    let diai = datai[AnyHashable("dia")] as? String ?? ""
                    let horasi = datai[AnyHashable("horas")] as? String ?? ""
                    let idadei = datai[AnyHashable("idade")] as? Int ?? -1
                    let mesi = datai[AnyHashable("mes")] as? String ?? ""
                    let mesStri = datai[AnyHashable("mesStr")] as? String ?? ""
                    let miniAnoi = datai[AnyHashable("miniAno")] as? String ?? ""
                    let minutosi = datai[AnyHashable("minutos")] as? String ?? ""
                    
                    registoSemanal = RegistoSemanal(dataFimSemana: DataNascimento(ano: Int(anof) ?? -1, dia: Int(diaf) ?? -1, horas: Int(horasf) ?? -1, idade: idadef, mes: Int(mesf) ?? -1, mesStr: mesStrf, miniAno: Int(miniAnof) ?? -1, minutos: Int(minutosf) ?? -1), diaInicioSemana: DataNascimento(ano: Int(anoh) ?? -1, dia: Int(diah) ?? -1, horas: Int(horash) ?? -1, idade: idadeh, mes: Int(mesh) ?? -1, mesStr: mesStrh, miniAno: Int(miniAnoh) ?? -1, minutos: Int(minutosh) ?? -1), avaliacao1: avaliacao1, avaliacao2: avaliacao2, avaliacao3: avaliacao3, avaliacao4: avaliacao4, avaliacao5: avaliacao5, avaliacao6: avaliacao6, avaliacao7: avaliacao7, comentario: comentario, data: DataNascimento(ano: Int(anoi) ?? -1, dia: Int(diai) ?? -1, horas: Int(horasi) ?? -1, idade: idadei, mes: Int(mesi) ?? -1, mesStr: mesStri, miniAno: Int(miniAnoi) ?? -1, minutos: Int(minutosi) ?? -1), id: id, idCrianca: idCrianca, semana: semana)
                    
                    relatorios.append(registoSemanal)
                }
                
            }
            completion(relatorios)
        }
            
        }
}
