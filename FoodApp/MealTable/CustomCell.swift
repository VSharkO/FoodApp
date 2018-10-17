//
//  CustomCell.swift
//  FoodApp
//
//  Created by Valentin Šarić on 16/10/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell{
    var mealName: String? {
        didSet{
           setupSubviews()
        }
    }
    var mealPhoto: UIImage?{
        didSet{
            setupSubviews()
        }
    }
    var mealRating: Int?{
        didSet{
            setupSubviews()
        }
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
    
    //    EDIT: budući da ne dobivamo podatke za čelije prilikom inicijalizacije tableViewa, ovdije je potrebno handle-ati ubacivanje podataka u costum čeliju
    //    ovo služi otprilike kao adapter u androidu i poziva se u didSet(kada su vrijednosti inicijalizirane)
    func setupSubviews(){
        if let name = mealName{
            mealNameView.text = name
        }
        if let photo = mealPhoto{
            mealPhotoView.image = photo
        }
        if let rating = mealRating{
            mealRatingView.setupButton(rating: rating)
        }
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
