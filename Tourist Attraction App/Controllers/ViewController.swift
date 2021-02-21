//
//  ViewController.swift
//  Tourist Attraction App
//
//  Created by Pinal Patel on 2020-12-01.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var rememberLoginSwitch: UISwitch!
    var userData:[User] = []
    var defaults:UserDefaults!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.defaults = UserDefaults.standard
        
        if  self.defaults.bool(forKey: "isLogin") == true{
            let homevc = self.storyboard?.instantiateViewController(withIdentifier: "TabView") as! TabViewController
            self.navigationController?.pushViewController(homevc, animated: false)

        }
        
        
        addLeftImage(textField: txtUsername, img: UIImage(named: "ic_user")!)
        addLeftImage(textField: txtPassword, img: UIImage(named: "ic_password")!)
        
        // load the data
        let dataLoadedSuccessfully = self.loadData()
        if (dataLoadedSuccessfully == false) {
            print("Error loading data, exiting")
            return
        }
        
    }

    @IBAction func btnLoginPressed(_ sender: Any) {
        var username = ""
        var password = ""
        var isLogin = false
        if self.txtUsername.text == "" || self.txtPassword.text == "" {
                   let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
                   let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                   alertController.addAction(defaultAction)
                   self.present(alertController, animated: true, completion: nil)
               }
        for i in 0..<userData.count{
             username = userData[i].username
             password = userData[i].password
            if self.txtUsername.text == username && self.txtPassword.text == password {

                isLogin = true
                if rememberLoginSwitch.isOn
                {
                    self.defaults.set(true, forKey: "isLogin")
                }
               self.defaults.set(userData[i].id, forKey: "userId")
                txtUsername.text = ""
                txtPassword.text = ""
                rememberLoginSwitch.isOn = false
                let homevc = self.storyboard?.instantiateViewController(withIdentifier: "TabView") as! TabViewController
                self.navigationController?.pushViewController(homevc, animated: true)
            }
        }
        if(!isLogin){
        if username != txtUsername.text && password != txtPassword.text {
            print("not match")
            let alertController = UIAlertController(title: "Error", message: "Username or Password is incorrect.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        }
    }
    func addLeftImage(textField:UITextField, img:UIImage){
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 8, height: 8))
        imageView.image = img
        textField.leftView = imageView
        textField.leftViewMode = .always
        
    }
    
    
    func loadData() -> Bool {
        if let filepath = Bundle.main.path(forResource:"UserData", ofType:"json") {
            do {
                let contents = try String(contentsOfFile: filepath)
              //  print(contents)
                let jsonData = contents.data(using: .utf8)!
                self.userData =
                    try! JSONDecoder().decode([User].self, from:jsonData)
                return true
                
            } catch {
                print("Cannot load file")
                return false
            } // end do
        } else {
            print("File not found")
            return false
        } // end if
    }

}

