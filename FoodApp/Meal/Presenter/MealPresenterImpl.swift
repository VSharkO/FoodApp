//
//  MealPresenterImpl.swift
//  FoodApp
//
//  Created by Valentin Šarić on 15/10/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import UIKit
import os.log
class MealPresenterImpl: MealPresenter{
    
    let view: MealViewControllerDelegate;
    
    func updateMeal(name: String, photo: UIImage, rating: Int, index: Int) {
        repository.data[index] = Meal(name: name, photo: photo, rating: rating)
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(repository.data, toFile: Meal.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
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
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(repository.data, toFile: Meal.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    
    init(view: MealViewController) {
        self.view = view
    }
}
