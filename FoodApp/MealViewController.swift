//
//  ViewController.swift
//  FoodApp
//
//  Created by Valentin Šarić on 14/10/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import UIKit

class MealViewController: UIViewController {
    
    var mainView: MealView! {
        return self.view as! MealView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    override func loadView() {
        self.view = MealView(frame: UIScreen.main.bounds)
    }
}

class MealView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        setupViews()
        setupConstraints()
    }
    
    private func setupViews(){
        self.addSubview(rootView)
        self.addSubview(editText)
        self.addSubview(textLabel)
        self.addSubview(mealButton)
    }
    
    private func setupConstraints(){
        setRootViewConstraints()
        setEditTextConstraints()
        setTextLabelConstraints()
        setButtonConstraints()
    }
    
    // MARK: Views
    
    let rootView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        return view
    }()
    
    let editText: UITextField = {
        let mealName = UITextField(frame: .zero)
        mealName.returnKeyType = UIReturnKeyType.done
        mealName.borderStyle = UITextBorderStyle.roundedRect
        mealName.placeholder = "Enter meal name"
        return mealName
    }()
    
    let textLabel: UILabel = {
        let mealName = UILabel(frame: .zero)
        mealName.text = "Meal name"
        return mealName
    }()
    
    let mealButton: UIButton = {
        let mealButton = UIButton(frame: .zero)
        mealButton.setTitleColor(.blue, for: UIControlState.normal)
        mealButton.setTitleColor(.red, for: UIControlState.highlighted)
        mealButton.setTitle("Set Default Label text", for: UIControlState.normal)
        return mealButton
    }()
    
    //MARK: Constraints
    
    func setRootViewConstraints(){
        rootView.translatesAutoresizingMaskIntoConstraints = false;
        rootView.bottomAnchor.constraint(equalTo:
            self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        rootView.topAnchor.constraint(equalTo:
            self.safeAreaLayoutGuide.topAnchor).isActive = true
        rootView.leadingAnchor.constraint(equalTo:
            self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        rootView.trailingAnchor.constraint(equalTo:
            self.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    func setTextLabelConstraints(){
        textLabel.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 22),
            textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -22),
            textLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
    }
    
    func setEditTextConstraints(){
        editText.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint.activate([
            editText.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 8),
            editText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 22),
            editText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -22),
            editText.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
    }
    
    func setButtonConstraints(){
        mealButton.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint.activate([
            mealButton.topAnchor.constraint(equalTo: editText.bottomAnchor, constant: 8),
            mealButton.widthAnchor.constraint(equalToConstant: 200),
            mealButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
    }
    //TODO: stackView, na click unijeti ime u label i dodati image View
   
    
}

