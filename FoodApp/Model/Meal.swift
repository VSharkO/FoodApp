//
//  MealModel.swift
//  FoodApp
//
//  Created by Valentin Šarić on 16/10/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import UIKit

class Meal{
    var name: String
    var photo: UIImage?
    var rating: Int
    
    init?(name: String, photo: UIImage?, rating: Int) {
        
        if name.isEmpty || rating < -1  {
            return nil
        }
        self.name = name
        self.photo = photo
        self.rating = rating
    }
}
