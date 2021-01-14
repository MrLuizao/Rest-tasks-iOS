//
//  ViewController.swift
//  webView
//
//  Created by LKY on 11/01/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = ""
        nameLabel.numberOfLines = 0
        emailLabel.text = ""
        emailLabel.numberOfLines = 0
        idLabel.text = ""
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
    }
    
    @IBAction func getResponseHttp(_ sender: Any) {
        activityIndicator.startAnimating()
        
        Networking.shared.getUser(id: 1457) { (user) in
            self.activityIndicator.stopAnimating()
            
            self.setup(user: user)
            
        } failure: { (error) in
            self.activityIndicator.stopAnimating()
            
            self.nameLabel.text = error.debugDescription
            
        }

    }
    
    @IBAction func addUserAction(_ sender: Any) {
        
        let newUser = NewUser(name: "luisonowsky", email: "luis_on@lky.mx", gender: "Male", status: "Active")
        
        
        activityIndicator.startAnimating()
        
        Networking.shared.addUser(user: newUser){ (user) in
            self.activityIndicator.stopAnimating()
            
            self.setup(user: user)
            
        } failure: { (error) in
            self.activityIndicator.stopAnimating()
            
            self.nameLabel.text = error.debugDescription
            
        }
        
    }
    
    
    @IBAction func updateUserAction(_ sender: Any) {
        let newUser = NewUser(name: "lky-updated", email: nil, gender: nil, status: nil)
        
        
        activityIndicator.startAnimating()
        
        Networking.shared.updateUser(id:1452, user: newUser){ (user) in
            self.activityIndicator.stopAnimating()
            
            self.setup(user: user)
            
        } failure: { (error) in
            self.activityIndicator.stopAnimating()
            
            self.nameLabel.text = error.debugDescription
            
        }
    }
    
    @IBAction func deleteUserAction(_ sender: Any) {
        activityIndicator.startAnimating()
        let idErased = 1457
        
        Networking.shared.deleteUser(id: idErased){
            
            self.activityIndicator.stopAnimating()
            self.nameLabel.text = "Usuario \(idErased) borrado correctamente!"
            self.emailLabel.text = ""
            self.idLabel.text = ""
            
        } failure: { (error) in
            self.activityIndicator.stopAnimating()
            
            self.nameLabel.text = error.debugDescription
            
        }
    }
    
    
    private func setup(user: User){
        self.nameLabel.text = user.name
        self.emailLabel.text = user.email
        self.idLabel.text = user.id?.description
        
    }
}

