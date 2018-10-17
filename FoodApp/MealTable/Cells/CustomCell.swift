//
//  CustomCell.swift
//  FoodApp
//
//  Created by Valentin Šarić on 16/10/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell{
    
    //    EDIT: budući da ne dobivamo podatke za čelije prilikom inicijalizacije tableViewa, ovdije je potrebno handle-ati ubacivanje podataka u costum čeliju
    //    ovo služi otprilike kao adapter u androidu i poziva se u controlleru
    func setupSubviews(model: Meal){
        mealNameView.text = model.name
        if let photo = model.photo{
            mealPhotoView.image = photo
        }
        mealRatingView.setupButton(rating: model.rating)
    }

    var mealNameView : UILabel = {
        var textLabel = UILabel()
        textLabel.font = UIFont.systemFont(ofSize: 20)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    var mealPhotoView : UIImageView = {
        var mealPhoto = UIImageView()
        mealPhoto.translatesAutoresizingMaskIntoConstraints = false
        return mealPhoto
    }()
    
    var mealRatingView : RatingControll = {
        var mealRating = RatingControll()
        mealRating.translatesAutoresizingMaskIntoConstraints = false
        mealRating.isUserInteractionEnabled = false
        return mealRating
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(mealNameView)
        contentView.addSubview(mealPhotoView)
        contentView.addSubview(mealRatingView)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            mealPhotoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            mealPhotoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            mealPhotoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -8),
            mealPhotoView.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 1/3),
            mealPhotoView.heightAnchor.constraint(equalTo: mealPhotoView.widthAnchor)])
        
        NSLayoutConstraint.activate([
            mealNameView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 8),
            mealNameView.leadingAnchor.constraint(equalTo: mealPhotoView.trailingAnchor,constant: 8),
            mealNameView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -8)])
        
        NSLayoutConstraint.activate([
            mealRatingView.topAnchor.constraint(lessThanOrEqualTo: mealNameView.bottomAnchor, constant: 8),
            mealRatingView.leadingAnchor.constraint(equalTo: mealPhotoView.trailingAnchor,constant: 8),
            mealRatingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -16),
            mealRatingView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
}
