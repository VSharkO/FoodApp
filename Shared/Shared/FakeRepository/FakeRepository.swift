//
//  FakeRepository.swift
//  FoodApp
//
//  Created by Valentin Šarić on 16/10/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation

public struct repository{
    public static let sharedInstance = repository()
    public init(){}
    public static var data = [Meal(name: "Prvo jelo", photo: #imageLiteral(resourceName: "defaultImage"), rating: 0),Meal(name: "Drugo jelo", photo: #imageLiteral(resourceName: "defaultImage"), rating: 1)]
}
