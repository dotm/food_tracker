//
//  Meal.swift
//  FoodTracker
//
//  Created by Yoshua Elmaryono on 08/07/18.
//  Copyright © 2018 Yoshua Elmaryono. All rights reserved.
//

import UIKit
import os.log

class Meal: NSObject, NSCoding {
    //MARK: Properties
    var name: String
    var photo: UIImage?
    var rating: Int
    var maximumRating = 5
    //MARK: Types
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    //MARK: Initializers
    init?(name: String, photo: UIImage?, rating: Int){
        guard name.isEmpty == false else { return nil }
        guard rating >= 0 else { return nil }
        guard rating <= maximumRating else { return nil }
        
        self.name = name
        self.photo = photo
        self.rating = rating
        
        super.init()
    }
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        guard let rating = aDecoder.decodeObject(forKey: PropertyKey.rating) as? Int else {
            os_log("Unable to decode the rating for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        self.init(name: name, photo: photo, rating: rating)
    }
}
