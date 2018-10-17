//
//  ViewController.swift
//  FoodApp
//
//  Created by Valentin Šarić on 14/10/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import UIKit

class MealViewController: UIViewController,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MealViewControllerDelegate {
    
    var presenter: MealPresenter?
    var tapGestureRecognizer: UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        presenter = MealPresenterImpl(view: self) as MealPresenter
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageOnClick))
        setupNavigationBar()
        setup()
    }

    // MARK: Views
    
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
    
    var ratingControll: RatingControll = {
        let ratingControll = RatingControll()
        return ratingControll
    }()
    
    
    private func setup(){
        setupViews()
        setupConstraints()
        setupObservers()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func setupViews(){
        self.view.addSubview(rootView)
        self.view.addSubview(stackView)
        stackView.addArrangedSubview(editText)
        stackView.addArrangedSubview(mealPhoto)
        stackView.addArrangedSubview(ratingControll)
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
    
    //MARK: Functions
    @objc func imageOnClick(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        mealPhoto.image = selectedImage
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func setupNavigationBar(){
        navigationItem.title = "Add Meal"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(moveToMealScreen))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addMeal))
    }
    
    @objc func moveToMealScreen(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func addMeal(){
        if let mealRating = ratingControll.rating,let text = editText.text{
            if text != ""{
                if let newMeal = Meal(name: text, photo: mealPhoto.image, rating: mealRating){
                    presenter?.addMeal(meal: newMeal)
                    navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
}




