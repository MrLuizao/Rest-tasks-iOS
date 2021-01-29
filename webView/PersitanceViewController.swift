//
//  PersitanceViewController.swift
//  webView
//
//  Created by LKY on 19/01/21.
//

import UIKit

class PersitanceViewController: UIViewController {
    
    private let kMyKey = "MY_KEY"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func getBtnAction(_ sender: Any) {
        if let value = UserDefaults.standard.string(forKey: kMyKey){
            showAlert(message: value)
        }else{
            showAlert(message: "NO DATA FOR THIS KEY")
        }
       
    }
    
    @IBAction func putBtnAction(_ sender: Any) {
        UserDefaults.standard.set("LkY Co. ROCKS!! ", forKey: kMyKey)
        UserDefaults.standard.synchronize();
        showAlert(message: "PUT VALUE CORRECTLY")
    }
    
    @IBAction func deleteBtnAction(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: kMyKey)
        UserDefaults.standard.synchronize();
        showAlert(message: "DELETE VALUE CORRECTLY")
    }
    
    private func showAlert(message: String){
        
        let alert = UIAlertController(title: "DEFAULTS", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
}
