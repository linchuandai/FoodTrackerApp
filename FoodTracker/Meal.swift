//
//  Meal.swift
//  FoodTracker
//
//  Created by Leon Dai on 2017-07-24.
//  Copyright © 2017 Leon Dai. All rights reserved.
//

import UIKit
import os.log

class Meal: NSObject, NSCoding {
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    
    //MARK: Types
    
    struct PropertyKey {
        
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    
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
    
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // Name is required; if it cannot be decdoded, the initializer should fail
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            
            return nil
        }
        
        // Use conditional cast because photo is optionaly property
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        // Must call designated initializer
        self.init(name: name, photo: photo, rating: rating)
    }
}
