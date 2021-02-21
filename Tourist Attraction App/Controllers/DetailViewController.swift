//
//  DetailViewController.swift
//  TouristApp
//
//  Created by Pinal Patel on 2020-11-28.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, UIScrollViewDelegate {
   
   
    @IBOutlet weak var cosmosView: CosmosView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var txtDescription: UILabel!
    @IBOutlet weak var txtPlaceAddress: UILabel!
    @IBOutlet weak var txtPlaceName: UILabel!
    @IBOutlet weak var txtWebsite: UILabel!
    @IBOutlet weak var txtPhone: UILabel!
    @IBOutlet weak var imgCall: UIImageView!
    @IBOutlet weak var imgPrice: UIImageView!
    @IBOutlet weak var imgHours: UIImageView!
    
    var ratingList:[UserRating] = []
    var selectedPlace:TouristListData?
    var id = ""
    var images = [UIImage]()
    var ratingArray:[UserRating] = []
    var defaults:UserDefaults!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.defaults = UserDefaults.standard
        id =  self.defaults.string(forKey: "userId")!
        
        guard let currentPlace = selectedPlace else {
            print("Place Data is null")
            return
        }
        
         view.addSubview(scrollView)
        txtDescription.lineBreakMode = .byWordWrapping
        txtDescription.numberOfLines = 0
         txtPlaceName.text = currentPlace.placeName
         txtPlaceAddress.text = currentPlace.address
         txtDescription.text = currentPlace.description
         txtWebsite.text = currentPlace.website
        txtPhone.text = currentPlace.phoneNo
        if currentPlace.phoneNo == ""{
            txtPhone.text = "N/A"
        }
        
         
         retrieveFromJsonFile()
         setupImages()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTappedPrice(tapGestureRecognizer:)))
        
              // add it to the image view;
        imgPrice.addGestureRecognizer(tapGesture)
              // make sure imageView can be interacted with by user
        imgPrice.isUserInteractionEnabled = true
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(imageTappedHours(tapGestureRecognizer:)))
        
        imgHours.addGestureRecognizer(tapGesture2)
        imgHours.isUserInteractionEnabled = true
        txtWebsite.isUserInteractionEnabled = true

        let gesture = UITapGestureRecognizer(target: self, action:#selector(openWebview(tapGestureRecognizer:)))
        txtWebsite.addGestureRecognizer(gesture)
        
        cosmosView.didFinishTouchingCosmos = { rating in
            self.ratingList = []
            let userRating = UserRating(userId: self.id, placeId: self.selectedPlace!.id, placeRating: Float(rating))
           
            self.ratingList.append(userRating)
            
            if self.ratingArray.count > 0 {
                for i in 0..<self.ratingArray.count{
                    let userRatingData = self.ratingArray[i]
                    if userRatingData.userId != userRating.userId || userRatingData.placeId != userRating.placeId{
                        let placeRating = userRatingData.placeRating
                        let userRating = UserRating(userId: self.id, placeId: userRatingData.placeId, placeRating: placeRating)
                        self.ratingList.append(userRating)
                    }
                }
                self.setRatingDataToJson(ratinglist: self.ratingList, filename: "ratings.json")
            }
            
            self.setRatingDataToJson(ratinglist: self.ratingList, filename: "ratings.json")
        }
        cosmosView.didTouchCosmos = { rating in
           
        }
        setRatingBar()
    }
    
    @objc func openWebview(tapGestureRecognizer: UITapGestureRecognizer){
    performSegue(withIdentifier: "webviewsegue", sender: nil)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "webviewsegue"
        {
            let vc = segue.destination as! WebViewController
            vc.urlData = selectedPlace!.website
    }
}
    
    func setRatingDataToJson(ratinglist:[UserRating], filename:String){
        let saveSuccess = self.saveData(userRatings: ratinglist, fileToSaveTo: filename)
        if (saveSuccess == true) {
            print("Saved!")
        }
        else {
            print("Failed!")
        }
    }
    
    func retrieveFromJsonFile() {
        guard let documentsDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = documentsDirectoryUrl.appendingPathComponent("ratings.json")
        do {
            let contents = try String(contentsOfFile: fileUrl.path)
            print(contents)
              
            let jsonData = contents.data(using: .utf8)!
            self.ratingArray = try! JSONDecoder().decode([UserRating].self, from:jsonData)
        } catch {
            print(error)
        }
    }
    
    func saveData(userRatings:[UserRating], fileToSaveTo:String) -> Bool {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(userRatings)
            
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                let finalPath = paths[0]
                let filename = finalPath.appendingPathComponent(fileToSaveTo)
               // print("Path to output file: \(filename)")
                
                try jsonString.write(to: filename, atomically:true, encoding: String.Encoding.utf8)
                return true
            }
            else {
                print("Error when converting data to a string")
                return false
            }
            
        }
        catch {
            print("Error converting or saving to JSON")
            print(error.localizedDescription)
            return false
        }
    }
    
    func setRatingBar(){
        if ratingArray.count > 0{
            for i in 0..<ratingArray.count{
                if selectedPlace!.id == ratingArray[i].placeId {
                    if ratingArray[i].placeRating > 0 && id == ratingArray[i].userId{
                        let f:Float = ratingArray[i].placeRating
                        cosmosView.rating = Double(f)
//                        print("Rating new \(cosmosView.rating)")
                    }
                }
            }
            
        }
    }
    
    
    @objc  func imageTappedHours(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let alert = UIAlertController(title: "Opening Hours of ", message: txtPlaceName.text, preferredStyle: .alert)
        for i in 0..<selectedPlace!.hours.count{
            let h = selectedPlace!.hours[i]
            let hourTime = h.day + " : "  + h.time
            alert.addTextField { (textField: UITextField) in
                 textField.text = hourTime
                textField.textColor = UIColor.darkGray
                textField.font = UIFont.systemFont(ofSize: 16)
                textField.tintColor = .clear
             }
        }
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        self.present(alert, animated: false, completion: nil)
    }
    
    @objc  func imageTappedPrice(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let alert = UIAlertController(title: "Ticket of ", message: txtPlaceName.text, preferredStyle: .alert)
        for i in 0..<selectedPlace!.pricing.count{
            let p = selectedPlace!.pricing[i]
            let tickets =  p.type + " - "  + p.price
            alert.addTextField { (textField: UITextField) in
                 textField.text = tickets
                textField.textColor = UIColor.darkGray
                textField.font = UIFont.systemFont(ofSize: 16)
                textField.tintColor = .clear
             }
            }
        
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        self.present(alert, animated: false, completion: nil)
    }
    func setupImages(){
        for i in 0..<(selectedPlace!.photo.count){
            self.images.append(UIImage(named: (selectedPlace!.photo[i]))!)
        }
        for i in 0..<self.images.count {

            let imageView = UIImageView()
            imageView.image = images[i]
            let xPosition = UIScreen.main.bounds.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
            imageView.contentMode = .scaleToFill
            scrollView.contentSize.width = self.scrollView.frame.width * CGFloat(i + 1)
            scrollView.showsHorizontalScrollIndicator = true
            scrollView.flashScrollIndicators()
            scrollView.addSubview(imageView)
            scrollView.delegate = self

        }

    }

}
