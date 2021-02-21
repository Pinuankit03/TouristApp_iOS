//
//  LogoutViewController.swift
//  TouristApp
//
//  Created by Pinal Patel on 2020-11-30.
//

import UIKit

class LogoutViewController: UIViewController {
    var defaults:UserDefaults!
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear call")
        let alertController = UIAlertController(title: "Logout", message: "Are You sure you want to Logout?", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Yes", style: .default, handler: {(UIAlertAction)
            in
            self.defaults.set(false, forKey: "isLogin")
                    self.navigationController?.popViewController(animated: true)
        })
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler:nil)
        alertController.addAction(defaultAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad call")
        self.defaults = UserDefaults.standard
    }
}
