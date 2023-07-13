//
//  ResetPasswordViewController.swift
//  ProjetoRegula3.0
//
//  Created by projeto on 31/05/2023.
//

import UIKit
import FirebaseAuth
class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func resetPassword(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: email.text!) { [weak self] err in
            guard let strongSelf = self else {return}
            if let err = err {
                print(err.localizedDescription)
            return
        
            }
            self!.tapToLogin()
        }
        
    }
    
    @IBAction func goToLogin(_ sender: Any) {
        tapToLogin()
    }
    
    func tapToLogin(){
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

}
