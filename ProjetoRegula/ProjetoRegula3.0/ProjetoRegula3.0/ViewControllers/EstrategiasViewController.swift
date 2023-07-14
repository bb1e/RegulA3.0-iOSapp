//
//  EstrategiasViewController.swift
//  ProjetoRegula3.0
//
//  Created by projeto on 19/05/2023.
//

import UIKit

class EstrategiasViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate{
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBOutlet weak var segmentationTipo: UISegmentedControl!
    var dataManager: DataManager!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var tipoEstrategia: [String] = []
    var tituloEstrategia: [String] = []
    var tipoSelecionado: String = " "
    var tituloEstrategiainicial: [String] = []
    var crianca:Crianca?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        collectionView.isUserInteractionEnabled = true
        collectionView.delegate = self
        dataManager = DataManager()
    
        dataManager.fetchTipoEstrategias{result in
            
            self.tipoEstrategia = result
            
            self.segmentationTipo.removeAllSegments()
            
            for (index, title) in self.tipoEstrategia.enumerated() {
                            self.segmentationTipo.insertSegment(withTitle: title, at: index, animated: false)
                        }
                        
                        
            self.segmentationTipo.reloadInputViews()
            self.segmentationTipo.selectedSegmentIndex = 0
            
            self.dataManager.fetchTituloEstrategiasByTipo(tipo: self.tipoEstrategia[0]){ result2 in
                self.tituloEstrategia = []
                self.tituloEstrategiainicial = []
                for titulo in result2 {
                                
                    print(result2)
                    
                                self.tituloEstrategia.append(titulo)
                                let newIndexPath = IndexPath(item: self.tituloEstrategia.count - 1, section: 0)
                    self.tituloEstrategiainicial.append(titulo)
                                
                                
                                self.collectionView.insertItems(
                                    at: [newIndexPath])

                            }
                if let selectedTitle = self.segmentationTipo.titleForSegment(at: 0) {
                    self.tipoSelecionado = selectedTitle
                }
                
            }
            
        }
    
    }


    @IBAction func changeTipo(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
               
               if let selectedTitle = sender.titleForSegment(at: selectedIndex) {
                   self.tipoSelecionado = selectedTitle
                   self.dataManager.fetchTituloEstrategiasByTipo(tipo: selectedTitle){ result2 in
                       self.tituloEstrategia = []
                       self.tituloEstrategiainicial = []
                       for titulo in result2 {
                                       self.tituloEstrategia.append(titulo)
                                       let newIndexPath = IndexPath(item: self.tituloEstrategia.count - 1, section: 0)
                                    self.tituloEstrategiainicial.append(titulo)
                                       
                                       
                                       self.collectionView.insertItems(
                                           at: [newIndexPath])

                                   }
                       
                   }
                   
               
                  
               }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tituloEstrategia.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TipoEstrategiaCollectionViewCell
        
        cell.titulo.text = tituloEstrategia[indexPath.row]
        cell.parentViewController = self
        
        print(cell)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "byEstrategiaSegue" {
            if let destinationVC = segue.destination as? ByEstrategiaViewController {
                if let selectedData = sender as? String {
                    // Pass the selected data to the destination view controller
                    destinationVC.tituloEstrategia = selectedData
                    destinationVC.tipoEstrategia = tipoSelecionado
                    destinationVC.crianca = crianca
                }
            }
        }
    }
    //MARK: Search Bar config
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tituloEstrategia = []
        
        if(searchText == ""){
            tituloEstrategia = tituloEstrategiainicial
        }
        else{
            for estrategia in tituloEstrategiainicial {
                
                if estrategia.lowercased().contains(searchText.lowercased()){
                    tituloEstrategia.append(estrategia)
                }
            }
        }
        self.collectionView.reloadData()
    }
}                            
