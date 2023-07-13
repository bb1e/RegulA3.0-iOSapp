//
//  RegisterViewController.swift
//  ProjetoRegula3.0
//
//  Created by projeto on 19/05/2023.
//

import UIKit
import FirebaseAuth
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var cpassword: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad() {
        spinner.hidesWhenStopped = true
        spinner.stopAnimating()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerbtn(_ sender: Any) {
        spinner.startAnimating()
        
        if email.text?.isEmpty == true {
            print("Preencher email")
            spinner.stopAnimating()
            return
        }
        if username.text?.isEmpty == true{
            print("Preencher username")
            spinner.stopAnimating()
            return
        }
        if password.text?.isEmpty == true{
            print("Preencher password")
            spinner.stopAnimating()
            return
        }
        if cpassword.text?.isEmpty == true {
            print("Preencher confirmação de password")
            spinner.stopAnimating()
            return
        }
        
        if cpassword.text! != password.text! {
            print("As passwords não são iguais")
            spinner.stopAnimating()
            return
        }
        
        signUp()
        
    }

    @IBAction func loginBtn(_ sender: Any) {
        tapToLogin()
    }
    
    func tapToLogin(){
        let storyboard = UIStoryboard(name: "Main",bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "loginpage")
        vc.modalPresentationStyle = .overFullScreen
        present(vc,animated: true)
    }
    
    
    func signUp(){
        Auth.auth().createUser(withEmail: email.text!, password: password.text!){ (authResult, err) in
            guard let user = authResult?.user, err == nil else{
                print(err?.localizedDescription)
                self.spinner.stopAnimating()
                return
            }
            
            
            
            
            
            
            Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text!){[weak self] authResult,err in
                guard let strongSelf = self else {return}
                if let err = err {
                    self!.spinner.stopAnimating()
                    print(err.localizedDescription)
                }
                if Auth.auth().currentUser != nil {
                    let db = Firestore.firestore()
                    let uid = Auth.auth().currentUser!.uid
                    let newSession = db.collection("sessions_test").document(uid)
                    let created_at = Int(String(format:"%.0f",round(Date().timeIntervalSince1970 * 1000)))
                    let sessionDoc: [String: Any] = [
                        "created_at": created_at ?? -1,
                        "email": self!.email.text!,
                        "id": uid,
                        "idCuidador": "",
                        "nome": self!.username.text!,
                        "storageImageRef": "",
                        "thisSession": NSNull()
                    ]
                    newSession.setData(sessionDoc){[weak self] err in
                        guard let strongSelf = self else {return}
                        if let err = err {
                            self!.spinner.stopAnimating()
                            print(err.localizedDescription)
                            return
                        }
                        
                    }
                    
                    let usersRef = Database.database().reference().child("Users").child(uid)
                    let userData: [String: Any] = [
                        "name": self!.username.text!,
                        "userState": [
                            "date": created_at,
                            "state": "online",
                            "time": created_at
                        ]
                    ]
                    usersRef.setValue(userData)
                    
                        
                        let storyboard = UIStoryboard(name: "Main",bundle: nil)
                        let vc = storyboard.instantiateViewController(identifier: "mainpage")
                        vc.modalPresentationStyle = .overFullScreen
                        
                        self!.present(vc,animated: true)
                    }
                }
        }
    }
}
