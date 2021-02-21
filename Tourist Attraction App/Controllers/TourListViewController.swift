//
//  TourListViewController.swift
//  TouristApp
//
//  Created by Pinal Patel on 2020-11-28.
//

import UIKit

class TourListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
   
    var tourList:[TouristListData] = []
    var wishlist : [TouristListData] = []
    var row = 0
    var defaults:UserDefaults!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.rowHeight = 180
        self.defaults = UserDefaults.standard
       
        let dataLoadedSuccessfully = self.loadData()
        if (dataLoadedSuccessfully == false) {
            print("Error loading data, exiting")
            return
        }
       getDataForWishList()
    }
    
    func getDataForWishList(){
        do {
            
            let storedObjItem = self.defaults.object(forKey: "wishlistitems")
            if storedObjItem != nil {
                wishlist = try JSONDecoder().decode([TouristListData].self, from: storedObjItem as! Data)
                print("Retrieved items: \(wishlist.count)")
                print("Retrieved items: \(wishlist)")
            }
            }catch let err {
                print(err)
            }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tourList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "TourTableCell") as? TourTableViewCell
        
        if cell == nil {
            cell = TourTableViewCell(style: .default, reuseIdentifier: "TourTableCell")
        }
       
        let _:UITapGestureRecognizer
        cell?.placeImage.image = UIImage(named: self.tourList[indexPath.row].photo[0])
        cell?.txtplaceName.text = self.tourList[indexPath.row].placeName
        cell?.txtPlaceLocation.text = self.tourList[indexPath.row].address
        
        cell?.imgWishlist.image = UIImage(named: "ic_fav")
        for i in 0..<wishlist.count{
            if tourList[indexPath.row].id == wishlist[i].id{
                cell?.imgWishlist.image = UIImage(named: "ic_favselect")
        }
        }
       
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TourListViewController.imageTapped(tapGestureRecognizer:)))
        
              // add it to the image view;
        cell?.imgWishlist.addGestureRecognizer(tapGesture)
              // make sure imageView can be interacted with by user
        cell?.imgWishlist.isUserInteractionEnabled = true
        cell?.imgWishlist.tag = indexPath.row
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        row = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "detailsegue", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsegue"
        {
            let selectedPlaceData = self.tourList[row]
            let vc = segue.destination as! DetailViewController
            vc.selectedPlace = selectedPlaceData
    }
}

      @objc  func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
        {
        var selectedPos = -1
        let imgView = tapGestureRecognizer.view as! UIImageView
        selectedPos = imgView.tag
        wishlist = []
        
        do {
            let storedObjItem = self.defaults.object(forKey: "wishlistitems")
            if storedObjItem != nil {
                
                let list = try JSONDecoder().decode([TouristListData].self, from: storedObjItem as! Data)
                if list.count > 0{
                wishlist.append(tourList[selectedPos])
                for i in 0..<list.count {
                    let t:TouristListData = list[i]
                    if t.id != tourList[selectedPos].id {
                        wishlist.append(t)
                    }
                    else if t.id == tourList[selectedPos].id {
                        if let index = wishlist.firstIndex(where: {$0.id == tourList[selectedPos].id}) {
                            wishlist.remove(at: index)
                        }
                    }
                }
                addWishlistToPref(arraylist: wishlist)
                    if imgView.image == UIImage(named: "ic_fav") {
                        print("ic_fav")
                        imgView.image = UIImage(named: "ic_favselect")
                    }
                    else{
                        print("ic_favselect")
                        imgView.image = UIImage(named: "ic_fav")
                    }
                }
            }else{
               
                wishlist.append(tourList[selectedPos])
                addWishlistToPref(arraylist: wishlist)
                if imgView.image == UIImage(named: "ic_fav") {
                    print("ic_fav")
                    imgView.image = UIImage(named: "ic_favselect")
                }
               
            }
            
            }catch let err {
                print("ERROR \(err)")
            }
}
   
    func addWishlistToPref(arraylist:[TouristListData]){
        if let encoded = try? JSONEncoder().encode(arraylist) {
            self.defaults.set(encoded, forKey: "wishlistitems")
        }
    }
    
    func loadData() -> Bool {
        
        if let filepath = Bundle.main.path(forResource:"TouristPlaceList", ofType:"json") {
            do {
                
                let contents = try String(contentsOfFile: filepath)
               // print(contents)
                let jsonData = contents.data(using: .utf8)!
                self.tourList = try! JSONDecoder().decode([TouristListData].self, from:jsonData)
                return true
                
            } catch {
                print("Cannot load file")
                return false
            }
        } else {
            print("File not found")
            return false
        }
    }

    
    
  


}
