//
//  RegistoSemanalViewController.swift
//  ProjetoRegula3.0
//
//  Created by projeto on 06/07/2023.
//

import UIKit
import Firebase

class RegistoSemanalViewController: UIViewController {
    @IBOutlet weak var tomarBanho: UISlider!
    
    @IBOutlet weak var enviarBtn: UIButton!
    @IBOutlet weak var comentario: UITextField!
    @IBOutlet weak var higienePessoal: UISlider!
    @IBOutlet weak var brincarJogar: UISlider!
    @IBOutlet weak var descansoSono: UISlider!
    @IBOutlet weak var vestireDespir: UISlider!
    @IBOutlet weak var alimentacao: UISlider!
    @IBOutlet weak var higieneSanitaria: UISlider!
    
    @IBOutlet weak var barraInicio: UINavigationItem!
    
    var dataHoje: Date?
    var dataInicio: Date?
    var dataFim: Date?
    var relatorioManager: RelatorioManager!
    var crianca: Crianca?
    var semana: String?
    var idRelatorio: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
         dataHoje = Date()
         dataInicio = Date().startOfWeek
         dataFim = Date().endOfWeek
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd/MM/yyyy"

        let dataf = dateFormatter.string(from: dataFim ?? Date())
        let datai = dateFormatter.string(from: dataInicio ?? Date())
        semana = "Semana de \(datai) a \(dataf)"

        barraInicio.title = semana
        tomarBanho.isContinuous = false
        vestireDespir.isContinuous = false
        alimentacao.isContinuous = false
        higieneSanitaria.isContinuous = false
        descansoSono.isContinuous = false
        brincarJogar.isContinuous = false
        higienePessoal.isContinuous = false
        
        relatorioManager = RelatorioManager()
        
        relatorioManager.fetchRelatorioCriancaId(crianca: crianca ?? Crianca(comentario: "null", created_at: -1, dataNascimento: DataNascimento(ano: 2001, dia: 11, horas: 11, idade: 1, mes: 1, mesStr: "Maio", miniAno: 01, minutos: 11), dataUltimaAvaliacao: "null", id: "nao existe", genero: "null", idSession: "null", idTerapeuta: "null", nome: "null", parentName: "null", status:"null", storageImageRef: "null", tipoAutismo: "null", estrategiasFavoritas: [], estrategiasRecomendadas: [],ssAv1: "Nenhum",ssAv2: "Nenhum",ssAv3:"Nenhum",ssAv4:"Nenhum",ssAv5:"Nenhum",ssAv6:"Nenhum",ssAv7:"Nenhum")){result in
            self.idRelatorio = result.id
            if result.id != -1{
                self.tomarBanho.setValue(Float(result.avaliacao1), animated: false)
                self.vestireDespir.setValue(Float(result.avaliacao2), animated: false)
                self.alimentacao.setValue(Float(result.avaliacao3), animated: false)
                self.higieneSanitaria.setValue(Float(result.avaliacao4), animated: false)
                self.descansoSono.setValue(Float(result.avaliacao5), animated: false)
                self.brincarJogar.setValue(Float(result.avaliacao6), animated: false)
                self.higienePessoal.setValue(Float(result.avaliacao7), animated: false)
                self.comentario.text = result.comentario
            }
        }
        
    }
   
    @IBAction func vestireDespirChanged(_ sender: UISlider) {
        let roundedValue = round(sender.value)
        sender.value = roundedValue
    
}
    
    @IBAction func alimentacaoChanged(_ sender: UISlider) {
        let roundedValue = round(sender.value)
        sender.value = roundedValue
    
}
    @IBAction func higieneSanitariaChanged(_ sender: UISlider) {
        let roundedValue = round(sender.value)
        sender.value = roundedValue
    
}
    @IBAction func descansoChanged(_ sender: UISlider) {
        let roundedValue = round(sender.value)
        sender.value = roundedValue
    
}
    @IBAction func brincarChanged(_ sender: UISlider) {
        let roundedValue = round(sender.value)
        sender.value = roundedValue
    
}
    
    @IBAction func higienePessoalChanged(_ sender: UISlider) {
        let roundedValue = round(sender.value)
        sender.value = roundedValue
    
}
    
    
    @IBAction func tomarBanhoChanged(_ sender: UISlider) {
            let roundedValue = round(sender.value)
            sender.value = roundedValue
        
    }
    @IBAction func enviarRelatorio(_ sender: Any) {
        
        if idRelatorio == -1{
            addRelatorioSemanal(crianca: crianca ?? Crianca(comentario: "null", created_at: -1, dataNascimento: DataNascimento(ano: 2001, dia: 11, horas: 11, idade: 1, mes: 1, mesStr: "Maio", miniAno: 01, minutos: 11), dataUltimaAvaliacao: "null", id: "nao existe", genero: "null", idSession: "null", idTerapeuta: "null", nome: "null", parentName: "null", status:"null", storageImageRef: "null", tipoAutismo: "null", estrategiasFavoritas: [], estrategiasRecomendadas: [],ssAv1: "Nenhum",ssAv2: "Nenhum",ssAv3:"Nenhum",ssAv4:"Nenhum",ssAv5:"Nenhum",ssAv6:"Nenhum",ssAv7:"Nenhum")){result in
                print("adicionei relatorio")
                self.showToast(message: "O relatorio foi adicionado", font: .systemFont(ofSize: 16.0))
            }
            
        }else{
            updateRelatorioSemanal(crianca: crianca ?? Crianca(comentario: "null", created_at: -1, dataNascimento: DataNascimento(ano: 2001, dia: 11, horas: 11, idade: 1, mes: 1, mesStr: "Maio", miniAno: 01, minutos: 11), dataUltimaAvaliacao: "null", id: "nao existe", genero: "null", idSession: "null", idTerapeuta: "null", nome: "null", parentName: "null", status:"null", storageImageRef: "null", tipoAutismo: "null", estrategiasFavoritas: [], estrategiasRecomendadas: [],ssAv1: "Nenhum",ssAv2: "Nenhum",ssAv3:"Nenhum",ssAv4:"Nenhum",ssAv5:"Nenhum",ssAv6:"Nenhum",ssAv7:"Nenhum")){result in
                print("adicionei relatorio")
                self.showToast(message: "O relatorio foi atualizado", font: .systemFont(ofSize: 16.0))
            }
            
        }
    }
    
   
    func updateRelatorioSemanal(crianca:Crianca,completion: @escaping (String)-> Void){
        let db = Firestore.firestore()


        let idCrianca = String(crianca.id)
        
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let year: String = dateFormatter.string(from: dataHoje ?? Date())
        let yeari: String = dateFormatter.string(from: dataInicio ?? Date())
        let yearf: String = dateFormatter.string(from: dataFim ?? Date())

        dateFormatter.dateFormat = "MM"
        let month: String = dateFormatter.string(from:dataHoje ?? Date())
        let monthi: String = dateFormatter.string(from: dataInicio ?? Date())
        let monthf: String = dateFormatter.string(from: dataFim ?? Date())


        dateFormatter.dateFormat = "dd"
        let day: String = dateFormatter.string(from:dataHoje ?? Date())
        let dayi: String = dateFormatter.string(from: dataInicio ?? Date())
        let dayf: String = dateFormatter.string(from: dataFim ?? Date())

        dateFormatter.dateFormat = "HH"
        let hour: String = dateFormatter.string(from:dataHoje ?? Date())
        let houri: String = dateFormatter.string(from: dataInicio ?? Date())
        let hourf: String = dateFormatter.string(from: dataFim ?? Date())

        
        dateFormatter.dateFormat = "mm"
        let minutes: String = dateFormatter.string(from:dataHoje ?? Date())
        let minutesi: String = dateFormatter.string(from: dataInicio ?? Date())
        let minutesf: String = dateFormatter.string(from: dataFim ?? Date())

        
        dateFormatter.dateFormat = "MMM"
        let extenso: String = dateFormatter.string(from:dataHoje ?? Date())
        let extensoi: String = dateFormatter.string(from: dataInicio ?? Date())
        let extensof: String = dateFormatter.string(from: dataFim ?? Date())

        
        
        let newSession = db.collection("relatorioSemanal").document(String(idRelatorio ?? -1))
        let sessionDoc: [String: Any] = [
            "idCrianca": idCrianca,
            "id": idRelatorio ?? -1,
            "comentario" : comentario.text ?? "",
            "semana" : semana ?? " ",
            "diaInicioSemana": [
                            "ano": yeari,
                            "dia": dayi,
                            "horas": houri,
                            "idade": 0,
                            "mes": monthi,
                            "mesStr": String(extensoi.prefix(3)).uppercased(),
                            "miniAno": yeari.suffix(2),
                            "minutos": minutesi
                        ],
                        "dataFimSemana": [
                            "ano": yearf,
                            "dia": dayf,
                            "horas": hourf,
                            "idade": 0,
                            "mes": monthf,
                            "mesStr": String(extensof.prefix(3)).uppercased(),
                            "miniAno": yearf.suffix(2),
                            "minutos": minutesf
                        ],
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
            "avaliacao1" : tomarBanho.value,
            "avaliacao2" : vestireDespir.value,
            "avaliacao3" : alimentacao.value,
            "avaliacao4" : higieneSanitaria.value,
            "avaliacao5" : descansoSono.value,
            "avaliacao6" : brincarJogar.value,
            "avaliacao7" : higienePessoal.value
        ]
        newSession.updateData(sessionDoc){[weak self] err in
            guard let strongSelf = self else {return}
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
        }
            
        completion("Correu certo")
    }
    
    func addRelatorioSemanal(crianca:Crianca,completion: @escaping (String)-> Void){
        let db = Firestore.firestore()

        
        let idCrianca = String(crianca.id)
        let doct = String(format:"%.0f",round(Date().timeIntervalSince1970 * 1000))
        let created_at = Int(doct)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let year: String = dateFormatter.string(from: dataHoje ?? Date())
        let yeari: String = dateFormatter.string(from: dataInicio ?? Date())
        let yearf: String = dateFormatter.string(from: dataFim ?? Date())

        dateFormatter.dateFormat = "MM"
        let month: String = dateFormatter.string(from:dataHoje ?? Date())
        let monthi: String = dateFormatter.string(from: dataInicio ?? Date())
        let monthf: String = dateFormatter.string(from: dataFim ?? Date())


        dateFormatter.dateFormat = "dd"
        let day: String = dateFormatter.string(from:dataHoje ?? Date())
        let dayi: String = dateFormatter.string(from: dataInicio ?? Date())
        let dayf: String = dateFormatter.string(from: dataFim ?? Date())

        dateFormatter.dateFormat = "HH"
        let hour: String = dateFormatter.string(from:dataHoje ?? Date())
        let houri: String = dateFormatter.string(from: dataInicio ?? Date())
        let hourf: String = dateFormatter.string(from: dataFim ?? Date())

        
        dateFormatter.dateFormat = "mm"
        let minutes: String = dateFormatter.string(from:dataHoje ?? Date())
        let minutesi: String = dateFormatter.string(from: dataInicio ?? Date())
        let minutesf: String = dateFormatter.string(from: dataFim ?? Date())

        
        dateFormatter.dateFormat = "MMM"
        let extenso: String = dateFormatter.string(from:dataHoje ?? Date())
        let extensoi: String = dateFormatter.string(from: dataInicio ?? Date())
        let extensof: String = dateFormatter.string(from: dataFim ?? Date())

        
        
        let newSession = db.collection("relatorioSemanal").document(doct)
        let sessionDoc: [String: Any] = [
            "idCrianca": idCrianca,
            "id": created_at ?? "",
            "comentario" : comentario.text ?? "",
            "semana" : semana ?? " ",
            "diaInicioSemana": [
                            "ano": yeari,
                            "dia": dayi,
                            "horas": houri,
                            "idade": 0,
                            "mes": monthi,
                            "mesStr": String(extensoi.prefix(3)).uppercased(),
                            "miniAno": yeari.suffix(2),
                            "minutos": minutesi
                        ],
                        "dataFimSemana": [
                            "ano": yearf,
                            "dia": dayf,
                            "horas": hourf,
                            "idade": 0,
                            "mes": monthf,
                            "mesStr": String(extensof.prefix(3)).uppercased(),
                            "miniAno": yearf.suffix(2),
                            "minutos": minutesf
                        ],
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
            "avaliacao1" : tomarBanho.value,
            "avaliacao2" : vestireDespir.value,
            "avaliacao3" : alimentacao.value,
            "avaliacao4" : higieneSanitaria.value,
            "avaliacao5" : descansoSono.value,
            "avaliacao6" : brincarJogar.value,
            "avaliacao7" : higienePessoal.value
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

}
	
extension Date {
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }

    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 7, to: sunday)
    }
}

extension UIViewController{
    func showToast(message: String, font: UIFont){
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/3 , y: self.view.frame.size.height - 100,width: 300, height: 30))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        toastLabel.sizeToFit()
        toastLabel.numberOfLines = 0
        toastLabel.frame.size.height = 30
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseIn, animations: {
            toastLabel.alpha = 0.0
        },completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
}
