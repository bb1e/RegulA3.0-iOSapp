//
//  MaisViewController.swift
//  ProjetoRegula3.0
//
//  Created by projeto on 31/05/2023.
//

import UIKit
import FirebaseAuth

class MaisViewController: UIViewController {

    @IBOutlet weak var signout: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func adicionarCrianca(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main",bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "createchildpage")
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc,animated: true)
    }
    
    @IBAction func signout(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        let storyboard = UIStoryboard(name: "Main",bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "loginpage")
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
    override func viewWillAppear(_ animated: Bool){
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        let storyboard = UIStoryboard(name: "Main",bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "loginpage")
        vc.modalPresentationStyle = .overFullScreen
        
        present(vc,animated: true)
    }

}
