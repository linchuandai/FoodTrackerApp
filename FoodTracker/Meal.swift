//
//  Meal.swift
//  FoodTracker
//
//  Created by Leon Dai on 2017-07-24.
//  Copyright © 2017 Leon Dai. All rights reserved.
//

import UIKit

class Meal {
    
    //MARK: Properties
    
    var name: String
    
    var photo: UIImage?
    
    var rating: Int
    
    //MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Int) { // Failable initializer
        
        // Name must not be empty
        
        guard !name.isEmpty else {
            
            return nil
        }
        
        // Rating must be between 0 and 5
        
        guard (rating >= 0) && (rating <= 5) else {
            
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.rating = rating
    }
}
