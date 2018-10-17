//
//  MealPresenterImpl.swift
//  FoodApp
//
//  Created by Valentin Šarić on 15/10/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import UIKit

class MealPresenterImpl: MealPresenter{
    
    let view: MealViewControllerDelegate;
    
    func updateMeal(name: String, photo: UIImage, rating: Int, index: Int) {
        repository.data[index] = Meal(name: name, photo: photo, rating: rating)
    }
    
    func getMeal(index: Int) -> Meal?{
        if let meal = repository.data[index]{
            return meal
        }
        else {return nil}
    }
    
    func addMeal(name: String, photo: UIImage, rating: Int) {
        let meal = Meal(name: name,photo: photo,rating: rating)
        repository.data.append(meal)
    }
    
    init(view: MealViewController) {
        self.view = view
    }
}
