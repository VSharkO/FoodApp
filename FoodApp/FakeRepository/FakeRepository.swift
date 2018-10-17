//
//  FakeRepository.swift
//  FoodApp
//
//  Created by Valentin Šarić on 16/10/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation

public struct repository{
    static let sharedInstance = repository()
    private init(){}
    static var data = [Meal(name: "Prvo jelo", photo: #imageLiteral(resourceName: "defaultImage"), rating: 3),Meal(name: "Drugo jelo", photo: #imageLiteral(resourceName: "defaultImage"), rating: 5)]
}
