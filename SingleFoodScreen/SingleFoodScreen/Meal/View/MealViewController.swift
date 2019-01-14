//
//  ViewController.swift
//  FoodApp
//
//  Created by Valentin Šarić on 14/10/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import UIKit

public class MealViewController: UIViewController,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MealViewControllerDelegate{
    
    var presenter: MealPresenter?
    public var tapGestureRecognizer: UITapGestureRecognizer?
    public var indexOfClickedMeal : Int? = nil
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        presenter = MealPresenterImpl(view: self)
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageOnClick))
        setup()
    }
    
    public init(index: Int?) {
        super.init(nibName: nil, bundle: nil)
        indexOfClickedMeal = index
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Views
    
//    let ratingControll: RatingControl = {
//        let ratingControll = RatingControll()
//        return ratingControll
//    }()
    
    let rootView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    var editText: UITextField = {
        let mealName = UITextField()
        mealName.returnKeyType = .done
        mealName.borderStyle = .roundedRect
        mealName.placeholder = "Enter meal name"
        return mealName
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let mealPhoto: UIImageView = {
        let mealPhoto = UIImageView()
        let image = UIImage(named: "defaultImage")
        mealPhoto.image = image
        mealPhoto.isUserInteractionEnabled = true
        return mealPhoto
    }()
   
    
    //MARK: Setup
    private func setup(){
        setupViews()
        setupMealInfo(index: indexOfClickedMeal)
        setupConstraints()
        setupObservers()
        setupNavigationBar()
    }
    
    private func setupViews(){
        self.view.addSubview(rootView)
        self.view.addSubview(stackView)
        stackView.addArrangedSubview(editText)
        stackView.addArrangedSubview(mealPhoto)
//        stackView.addArrangedSubview(ratingControll)
    }
    
    private func setupConstraints(){
        setRootViewConstraints()
        setStackViewConstraints()
        setImageViewConstraints()
        setStackViewConstraints()
    }
    
    //MARK: Observers
    func setupObservers(){
        if let gestureRecognizer = tapGestureRecognizer{
           mealPhoto.addGestureRecognizer(gestureRecognizer)
        }
    }
    
    //MARK: Constraints
    
    func setRootViewConstraints(){
        rootView.translatesAutoresizingMaskIntoConstraints = false
        rootView.bottomAnchor.constraint(equalTo:
            self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        rootView.topAnchor.constraint(equalTo:
            self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        rootView.leadingAnchor.constraint(equalTo:
            self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        rootView.trailingAnchor.constraint(equalTo:
            self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    func setStackViewConstraints(){
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80),
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 22),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -22),
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])
    }
    
    func setImageViewConstraints(){
        mealPhoto.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mealPhoto.widthAnchor.constraint(equalTo: mealPhoto.heightAnchor)
            ])
    }
    
    //MARK: UIImagePickerControllerDelegate
    private func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
//            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
//    }
    
        mealPhoto.image = UIImage()
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Functions
    
    func setupNavigationBar(){
        navigationItem.title = "Add Meal"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(moveToMealScreen))
    }
    
    func setupMealInfo(index: Int?){
//        if index != nil then setup fields with old values set right button which call addMeal method, else set right button which call updateMeal
        if let indexOfMeal = index{
            if let meal = presenter?.getMeal(index: indexOfMeal){
                editText.text = meal.name
                mealPhoto.image = meal.photo
//                ratingControll.rating = meal.rating
//                ratingControll.setupButton(rating: meal.rating)
            }
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(updateMeal))
        }else{
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addMeal))
        }
    }
    
    //MARK: OnClick Functions
    
    @objc func imageOnClick(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func moveToMealScreen(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func addMeal(){
        if let/* mealRating = ratingControll.rating,let */text = editText.text,let image = mealPhoto.image{
            if text != ""{
                    presenter?.addMeal(name: text, photo: image, rating: 2)
                    navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @objc func updateMeal(){
        if let /* mealRating = ratingControll.rating,let */ text = editText.text, let image = mealPhoto.image,let indexOfMeal = indexOfClickedMeal{
            if text != ""{
                    presenter?.updateMeal(name: text, photo: image, rating: 2, index: indexOfMeal)
                    navigationController?.popViewController(animated: true)
            }
        }
    }
    
}




