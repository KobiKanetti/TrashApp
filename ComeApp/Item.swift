//
//  Item.swift
//  ComeApp
//
//  Created by kobi on 06/09/2017.
//  Copyright © 2017 Kobi Kanetti. All rights reserved.
//

import Firebase

class Item{
    
    let uid : String
    let address : String?
    let description : String?
    let condition : String?
    let date : Date?
    let imageUrl : URL?
    
    init(key : String, value : [String:Any]) {
        self.uid = key
        self.address = value["address"] as? String
        self.description = value["description"] as? String
        self.condition = value["condition"] as? String
        
        if let timestamp = value["date"] as? TimeInterval{
            self.date = Date(timeIntervalSince1970: timestamp)
        } else {
            self.date = nil
        }
        
        if let urlStr = value["image_url"] as? String{
            self.imageUrl = URL(string: urlStr)
        } else {
            self.imageUrl = nil
        }
    }
    
    
}
