//
//  Utils.swift
//  ComeApp
//
//  Created by kobi on 06/09/2017.
//  Copyright © 2017 Kobi Kanetti. All rights reserved.
//

import Foundation

extension Date{
    var dateString : String{
        get{
            let formatter = DateFormatter()
            //formatter.dateFormat = "dd-MM-yyyy   HH:mm"
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            formatter.doesRelativeDateFormatting = true
            formatter.calendar = Calendar(identifier: .gregorian)
            
            return formatter.string(from: self)
        }
    }
}
