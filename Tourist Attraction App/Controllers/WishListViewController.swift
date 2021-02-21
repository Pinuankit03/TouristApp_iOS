//
//  WishListViewController.swift
//  TouristApp
//
//  Created by Pinal Patel on 2020-11-28.
//

import UIKit

class WishListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var wishlist : [TouristListData] = []
    var defaults:UserDefaults!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.rowHeight = 120
        
        do {
            let storedObjItem = self.defaults.object(forKey: "wishlistitems")
            if storedObjItem != nil {
                wishlist = try JSONDecoder().decode([TouristListData].self, from: storedObjItem as! Data)
                print(" items: \(wishlist.count)")
            }
            }catch let err {
                print(err)
            }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.defaults = UserDefaults.standard
        print("viewDidLoad call")
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "WishTableCell") as? WishListTableViewCell
        
        if cell == nil {
            cell = WishListTableViewCell(style: .default, reuseIdentifier: "WishTableCell")
        }
        cell?.placeimage.image = UIImage(named: self.wishlist[indexPath.row].photo[0])
        cell?.txtPlaceName.text = self.wishlist[indexPath.row].placeName
        cell?.txtPlaceAddress.text = self.wishlist[indexPath.row].address
        
        return cell!
    }
 
}
