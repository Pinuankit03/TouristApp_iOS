//
//  TouristListData.swift
//  TouristApp
//
//  Created by Pinal Patel on 2020-11-28.
//

import Foundation

struct TouristListData:Codable{
    
    var id:String
    var placeName:String
    var description:String
    var website:String
    var phoneNo:String
    var status:Int
    var address:String
    var pricing:[Tickets]
    var photo:[String]
    var hours:[PlaceHoursData]
    

    
}
