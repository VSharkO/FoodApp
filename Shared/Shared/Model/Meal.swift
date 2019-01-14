//
//  MealModel.swift
//  FoodApp
//
//  Created by Valentin Šarić on 16/10/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import UIKit
import os.log

//MARK: Archiving Pathspublic

public struct PropertyKey{
    static let name = "name"
    static let photo = "photo"
    static let rating = "rating"
}

public class Meal : NSObject, NSCoding{
    public static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    public static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    public var name: String
    public var photo: UIImage?
    public var rating: Int
    
    public init?(name: String, photo: UIImage?, rating: Int) {
        
        if name.isEmpty || rating < -1  {
            return nil
        }
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    
    //MARK: NSCoding
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }
    
    required public convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        // Must call designated initializer.
        self.init(name: name, photo: photo, rating: rating)
        
    }
    
}
