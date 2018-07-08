//
//  Meal.swift
//  FoodTracker
//
//  Created by Yoshua Elmaryono on 08/07/18.
//  Copyright © 2018 Yoshua Elmaryono. All rights reserved.
//

import UIKit

class Meal {
    //MARK: Properties
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Initializers
    init?(name: String, photo: UIImage?, rating: Int){
        guard name.isEmpty == false else { return nil }
        guard rating >= 0 else { return nil }
        
        self.name = name
        self.photo = photo
        self.rating = rating
    }
}
