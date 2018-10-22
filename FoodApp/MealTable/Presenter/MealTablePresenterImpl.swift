//
//  MealTablePresenterImpl.swift
//  FoodApp
//
//  Created by Valentin Šarić on 16/10/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation
import os.log
class MealTablePresenterImpl: MealTablePresenter {
    weak var view: TableViewControllerDelegate?
    
    func removeMeal(index: Int) {
        repository.data.remove(at: index)
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(repository.data, toFile: Meal.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    
    func getDataFromRepository(index: Int) -> Meal? {
        return getDataFromRepository()?[index]
    }
    
    init(view: TableViewController) {
        self.view = view as TableViewControllerDelegate
    }
    
    func getDataFromRepository() -> [Meal]? {
        if let data = NSKeyedUnarchiver.unarchiveObject(withFile: Meal.ArchiveURL.path) as? [Meal]{
           repository.data = data
        }
        if let mealArray = repository.data as? [Meal]{
            return mealArray
        }
        else{
            return nil
        }
    }
    
}
