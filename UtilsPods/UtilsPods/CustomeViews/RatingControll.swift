//
//  RatingControll.swift
//  FoodApp
//
//  Created by Valentin Šarić on 15/10/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import UIKit

public class RatingControll: UIView{
    
    public var stackView = UIStackView()
    public var ratingButtons = [UIButton]()
    public var rating: Int? = nil
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        setupStackViewConstraints()
        setupButton(rating: nil)
    }
    
    public required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupButton(rating: Int?){
        if let ratingValue = rating{
            for i in 0..<5{
            if i <= ratingValue {
                ratingButtons[i].isSelected = true
            }else{
                ratingButtons[i].isSelected = false
            }
        }
        }else{
            for _ in 0..<5{
                firstTimeButtonSetup()
            }
        }
    }
    
    public func firstTimeButtonSetup(){
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
        button.setImage(UIImage(named: "emptyStar"), for: .normal)
        button.setImage(UIImage(named: "filledStar"), for: .selected)
        button.setImage(UIImage(named: "highlightedStar"), for: .highlighted)
        button.addTarget(self, action: #selector(starClick(button:)), for: .touchUpInside)
        ratingButtons.append(button)
        stackView.addArrangedSubview(button)
    }
    
    public func setupStackViewConstraints(){
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor)
            
        ])
    }
    
    @objc public func starClick(button: UIButton){
        if let buttonIndex = ratingButtons.index(of: button){
            rating = buttonIndex
            setupButton(rating: buttonIndex)
        }
    }
    
    public func returnRating() -> Int?{
        if let currentRating = rating{
            return currentRating
        }else{
            return nil
        }
    }
}


