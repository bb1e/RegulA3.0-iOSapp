//
//  EstrategiasFavoritasViewController.swift
//  ProjetoRegula3.0
//
//  Created by projeto on 06/07/2023.
//

import UIKit

class EstrategiasFavoritasViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var table: UITableView!
    var tituloEstrategia: String?
    var tipoEstrategia: String?
    var estrategias: [Estrategia] = []
    var crianca: Crianca?
    var criancasManager: CriancasManager!
    var estrategiaSelect: Estrategia?

    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        criancasManager = CriancasManager()
        let tabbar = tabBarController as! PrincipalTabBarController
        crianca = tabbar.crianca
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return estrategias.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        estrategiaSelect = estrategias[indexPath.row]
        performSegue(withIdentifier: "goToDetalhes2", sender: nil)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "tablecell", for: indexPath) as! EstrategiaTableViewCell
        let texto = "<p style = \"font-family: '-apple-system', 'HelveticaNeue'; font-size: \(cell.texto.font.pointSize)\">\(estrategias[indexPath.row].descricao)</p>"

        
        cell.texto.attributedText = texto.htmlToAttributedString
        cell.estrategia = estrategias[indexPath.row]
        cell.crianca = crianca
        
        criancasManager = CriancasManager()
        
        criancasManager.fetchEstrategiaFavCriancaId(crianca: crianca ?? Crianca(comentario: "null", created_at: -1, dataNascimento: DataNascimento(ano: 2001, dia: 11, horas: 11, idade: 1, mes: 1, mesStr: "Maio", miniAno: 01, minutos: 11), dataUltimaAvaliacao: "null", id: "", genero: "null", idSession: "null", idTerapeuta: "null", nome: "null", parentName: "null", status:"null", storageImageRef: "null", tipoAutismo: "null", estrategiasFavoritas: [], estrategiasRecomendadas: [],ssAv1: "Nenhum",ssAv2: "Nenhum",ssAv3:"Nenhum",ssAv4:"Nenhum",ssAv5:"Nenhum",ssAv6:"Nenhum",ssAv7:"Nenhum" )){result2 in
            
            var verificador = false
            for estrategiaFav in result2{
                if estrategiaFav.id == self.estrategias[indexPath.row].id{
                    verificador = true
                }
            }
            
            if verificador{
                cell.botaoFav.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }else{
                cell.botaoFav.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }

        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetalhes2" {
            if let destinationVC = segue.destination as? DetalhesEstrategiasViewController {
                
                destinationVC.estrategia = estrategiaSelect
                destinationVC.crianca = crianca
                
            }
        }
    }

    override func viewWillAppear(_ animated: Bool){
        print("entrei")
        estrategias = []
        let tabbar = tabBarController as! PrincipalTabBarController
        crianca = tabbar.crianca
        table.reloadData()

        criancasManager.fetchEstrategiaFavCriancaId(crianca:crianca ?? Crianca(comentario: "null", created_at: -1, dataNascimento: DataNascimento(ano: 2001, dia: 11, horas: 11, idade: 1, mes: 1, mesStr: "Maio", miniAno: 01, minutos: 11), dataUltimaAvaliacao: "null", id: "nao existe", genero: "null", idSession: "null", idTerapeuta: "null", nome: "null", parentName: "null", status:"null", storageImageRef: "null", tipoAutismo: "null", estrategiasFavoritas: [], estrategiasRecomendadas: [],ssAv1: "Nenhum",ssAv2: "Nenhum",ssAv3:"Nenhum",ssAv4:"Nenhum",ssAv5:"Nenhum",ssAv6:"Nenhum",ssAv7:"Nenhum")){result in
            
            for estrategia in result{
                self.estrategias.append(estrategia)
                self.table.reloadData()
                
            }
            
        }
    }
    override func viewWillDisappear(_ animated: Bool){
        estrategias = []
    }
}
