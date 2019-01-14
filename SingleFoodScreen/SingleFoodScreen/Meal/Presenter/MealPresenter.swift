//
//  MealPresenter.swift
//  FoodApp
//
//  Created by Valentin Šarić on 15/10/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import UIKit
import Shared

protocol MealPresenter{
    func addMeal(name: String, photo: UIImage, rating: Int)
    func getMeal(index: Int) -> Meal?
    func updateMeal(name: String, photo: UIImage, rating: Int, index: Int)
}
