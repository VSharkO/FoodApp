//
//  MealTablePresenterImpl.swift
//  FoodApp
//
//  Created by Valentin Šarić on 16/10/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation

class MealTablePresenterImpl: MealTablePresenter {
    var view: TableViewControllerDelegate
    
    func removeMeal(index: Int) {
        repository.data.remove(at: index)
    }
    
    func getDataFromRepository(index: Int) -> Meal? {
        return getDataFromRepository()?[index]
    }
    
    init(view: TableViewController) {
        self.view = view as TableViewControllerDelegate
    }
    
    func getDataFromRepository() -> [Meal]? {
        if let mealArray = repository.data as? [Meal]{
            return mealArray
        }
        else{
            return nil
        }
    }
    
}
