//
//  MealTablePresenter.swift
//  FoodApp
//
//  Created by Valentin Šarić on 16/10/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation

protocol MealTablePresenter{
    func getDataFromRepository() -> [Meal]?
}
