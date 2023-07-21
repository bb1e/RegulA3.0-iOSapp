//
//  PerfilViewController.swift
//  ProjetoRegula3.0
//
//  Created by projeto on 07/07/2023.
//

import UIKit

class PerfilViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var crianca: Crianca?
    
    @IBOutlet weak var tabletop5: UITableView!
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
    
    @IBOutlet weak var tituloregisto: UILabel!
    @IBOutlet weak var tableregisto: UITableView!
    var top5: [Top5]  = []
    var relatorio: [RegistoSemanal] = []
    var dataManager: DataManager!
    var relatorioManager: RelatorioManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabbar = tabBarController as! PrincipalTabBarController
        crianca = tabbar.crianca
        tabletop5.dataSource = self
        tabletop5.delegate = self
        tableregisto.dataSource = self
        tableregisto.delegate = self
        
        tabletop5.isHidden = true
        tituloregisto.isHidden = true
        tableregisto.isHidden = true
        nome.text = crianca?.nome
        dataAni.text = "\(crianca?.dataNascimento.dia ?? 1) / \(crianca?.dataNascimento.mes ?? 1) / \(crianca?.dataNascimento.ano ?? 1970)"
        
        tatil.setTitle(crianca?.ssAv1, forSegmentAt: 1)
        auditivo.setTitle(crianca?.ssAv2, forSegmentAt: 1)
        visual.setTitle(crianca?.ssAv3, forSegmentAt: 1)
        olfativo.setTitle(crianca?.ssAv4, forSegmentAt: 1)
        gustativo.setTitle(crianca?.ssAv5, forSegmentAt: 1)
        propriocetivo.setTitle(crianca?.ssAv6, forSegmentAt: 1)
        vestibular.setTitle(crianca?.ssAv7, forSegmentAt: 1)

        dataManager = DataManager()
        
        dataManager.fetchTop5EstrategiasByFeedback(idCrianca: crianca?.id ?? ""){
            top5atr, valorestop5 in
            for i in 0..<valorestop5.count{
                if top5atr[i] != " "{
                    self.top5.append(Top5(valor: valorestop5[i], texto: top5atr[i]))
                    self.top5 = self.top5.sorted(by: {$0.valor > $1.valor})
                    self.tabletop5.reloadData()
                    
                }
            }
            for i in 0..<self.top5.count{
                self.dataManager.fetchEstrategiaById(id: self.top5[i].texto){
                    result in
                    
                    self.top5[i].texto = result
                    self.tabletop5.reloadData()
                }
            }
            
        }
        relatorioManager = RelatorioManager()
        
        relatorioManager.fetchRelatoriosCriancaId(crianca: crianca ??  Crianca(comentario: "null", created_at: -1, dataNascimento: DataNascimento(ano: 2001, dia: 11, horas: 11, idade: 1, mes: 1, mesStr: "Maio", miniAno: 01, minutos: 11), dataUltimaAvaliacao: "null", id: "nao existe", genero: "null", idSession: "null", idTerapeuta: "null", nome: "null", parentName: "null", status:"null", storageImageRef: "null", tipoAutismo: "null", estrategiasFavoritas: [], estrategiasRecomendadas: [],ssAv1: "Nenhum",ssAv2: "Nenhum",ssAv3:"Nenhum",ssAv4:"Nenhum",ssAv5:"Nenhum",ssAv6:"Nenhum",ssAv7:"Nenhum")) { result in
            
            for i in result{
                self.relatorio.append(i)
                self.tableregisto.reloadData()
            }
        }
    


    }
    
    @IBAction func changeChoice(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex

        if selectedIndex == 0 {
            dataAni.isHidden = false
            nome.text = crianca?.nome
            
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
            tituloregisto.isHidden = true
            tabletop5.isHidden = true
            tableregisto.isHidden = true
            
        }else{
            
            nome.text = "Top 5 Estrategias"

            tabletop5.isHidden = false
            tituloregisto.isHidden = false
            tableregisto.isHidden = false
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
        if chooseInforDash.selectedSegmentIndex == 1 {
            nome.text = "Top 5 Estrategias"
        }else{
            nome.text = crianca?.nome
        }
        dataAni.text = "\(crianca?.dataNascimento.dia ?? 1) / \(crianca?.dataNascimento.mes ?? 1) / \(crianca?.dataNascimento.ano ?? 1970)"
        
        tatil.setTitle(crianca?.ssAv1, forSegmentAt: 1)
        auditivo.setTitle(crianca?.ssAv2, forSegmentAt: 1)
        visual.setTitle(crianca?.ssAv3, forSegmentAt: 1)
        olfativo.setTitle(crianca?.ssAv4, forSegmentAt: 1)
        gustativo.setTitle(crianca?.ssAv5, forSegmentAt: 1)
        propriocetivo.setTitle(crianca?.ssAv6, forSegmentAt: 1)
        vestibular.setTitle(crianca?.ssAv7, forSegmentAt: 1)
        
        dataManager = DataManager()
        
        top5 = []
        relatorio = []
        
        tabletop5.reloadData()
        tableregisto.reloadData()
        
        dataManager.fetchTop5EstrategiasByFeedback(idCrianca: crianca?.id ?? ""){
            top5atr, valorestop5 in
            for i in 0..<valorestop5.count{
                if top5atr[i] != " "{
                    self.top5.append(Top5(valor: valorestop5[i], texto: top5atr[i]))
                    self.top5 = self.top5.sorted(by: {$0.valor > $1.valor})
                    self.tabletop5.reloadData()
                    
                }
            }
            for i in 0..<self.top5.count{
                self.dataManager.fetchEstrategiaById(id: self.top5[i].texto){
                    result in
                    
                    self.top5[i].texto = result
                    self.tabletop5.reloadData()
                }
            }
            
        }
        relatorioManager = RelatorioManager()
        
        relatorioManager.fetchRelatoriosCriancaId(crianca: crianca ??  Crianca(comentario: "null", created_at: -1, dataNascimento: DataNascimento(ano: 2001, dia: 11, horas: 11, idade: 1, mes: 1, mesStr: "Maio", miniAno: 01, minutos: 11), dataUltimaAvaliacao: "null", id: "nao existe", genero: "null", idSession: "null", idTerapeuta: "null", nome: "null", parentName: "null", status:"null", storageImageRef: "null", tipoAutismo: "null", estrategiasFavoritas: [], estrategiasRecomendadas: [],ssAv1: "Nenhum",ssAv2: "Nenhum",ssAv3:"Nenhum",ssAv4:"Nenhum",ssAv5:"Nenhum",ssAv6:"Nenhum",ssAv7:"Nenhum")) { result in
            
            for i in result{
                self.relatorio.append(i)
                self.tableregisto.reloadData()
            }
        }
    


    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tabletop5 == tableView {
            if top5.count <= 5 {
                return top5.count
            }
            return 5
        }
        if tableregisto == tableView {
            return relatorio.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tabletop5{
            let cell = tabletop5.dequeueReusableCell(withIdentifier: "tabletop5", for: indexPath) as! Top5TableViewCell
            
            let texto = "<p style = \"font-family: '-apple-system', 'HelveticaNeue'; font-size: \(cell.titulo.font.pointSize)\">\(top5[indexPath.row].texto)</p>"
            
            
            cell.titulo.attributedText = texto.htmlToAttributedString
            
            cell.valor.text = String(top5[indexPath.row].valor)
            
            return cell
        }else{
            let cell = tableregisto.dequeueReusableCell(withIdentifier: "tableregistosemanal", for: indexPath) as! RegistoSemanalTableViewCell
            
            cell.banho.text = String(relatorio[indexPath.row].avaliacao1)
            cell.vestir.text = String(relatorio[indexPath.row].avaliacao2)
            cell.alimentacao.text = String(relatorio[indexPath.row].avaliacao3)
            cell.higieneS.text = String(relatorio[indexPath.row].avaliacao4)
            cell.decanso.text = String(relatorio[indexPath.row].avaliacao5)
            cell.jogar.text = String(relatorio[indexPath.row].avaliacao6)
            cell.higieneP.text = String(relatorio[indexPath.row].avaliacao7)
            
            cell.semana.text = relatorio[indexPath.row].semana
            cell.comentario.text = relatorio[indexPath.row].comentario

            cell.contentView.frame.size.height = 260

            return cell

        }
    }
    
}

