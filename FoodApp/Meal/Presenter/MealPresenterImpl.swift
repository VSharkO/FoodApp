//
//  MealPresenterImpl.swift
//  FoodApp
//
//  Created by Valentin Šarić on 15/10/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation

class MealPresenterImpl: MealPresenter{
    
    func addMeal(meal: Meal) {
        repository.data.append(meal)
    }
    
    let view: MealViewController;
    
    init(view: MealViewController) {
        self.view = view
    }
}
