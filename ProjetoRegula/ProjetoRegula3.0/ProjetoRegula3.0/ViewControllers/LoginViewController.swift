//
//  LoginViewController.swift/Users/projeto/Desktop/ProjetoRegula/ProjetoRegula3.0/ProjetoRegula3.0/Base.lproj/Main.storyboard
//  ProjetoRegula3.0
//
//  Created by projeto on 19/05/2023.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    
    var chatManager = ChatManager()

    
    override func viewDidLoad() {
        spinner.hidesWhenStopped = true
        spinner.stopAnimating()
        super.viewDidLoad()
        
        
        ///Caso a pessoa ja fez  o login entao ela entra na conta
        Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil{
                        let storyboard = UIStoryboard(name: "Main",bundle: nil)
                        let vc = storyboard.instantiateViewController(identifier: "mainpage")
                        vc.modalPresentationStyle = .overFullScreen
                        
                        self.present(vc,animated: true)
                    }
                }

        // Do any additional setup after loading the view.
    }
    

    ///Vai para a pagina de Register
    @IBAction func register(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main",bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "registerpage")
        vc.modalPresentationStyle = .overFullScreen
        present(vc,animated: true)
    }
    

    @IBAction func loginBtn(_ sender: Any) {
        spinner.startAnimating()
        validateFields()
    }
    

    func validateFields(){
        if(email.text?.isEmpty == true){
            print("Por favor preencher email")
            spinner.stopAnimating()
            return
        }
        if(password.text?.isEmpty == true){
                print("Por favor preencher password")
            spinner.stopAnimating()
            return
        }
        
        login()
    }
    
    @IBAction func goToReset(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main",bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "resetpasswordpage")
        vc.modalPresentationStyle = .overFullScreen
        present(vc,animated: true)
    }
    
    func login(){
        Auth.auth().signIn(withEmail: email.text!, password: password.text!){[weak self] authResult,err in
            guard let strongSelf = self else {return}
            if let err = err {
                self!.spinner.stopAnimating()
                print(err.localizedDescription)
            }
            self!.checkUserinfo()
        }
    }
    
    func checkUserinfo(){
        if Auth.auth().currentUser != nil {
            print(Auth.auth().currentUser?.uid)
            chatManager.getCurrentUser()
            let storyboard = UIStoryboard(name: "Main",bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "mainpage")
            vc.modalPresentationStyle = .overFullScreen
            
            present(vc,animated: true)
        }
    }
}
