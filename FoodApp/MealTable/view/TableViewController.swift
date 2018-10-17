//
//  TableViewController.swift
//  FoodApp
//
//  Created by Valentin Šarić on 16/10/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//
import UIKit

class TableViewController: UITableViewController, TableViewControllerDelegate {
    var presenter: MealTablePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MealTablePresenterImpl(view: self)
        registerCells()
        setupNavigationBar()
        }
    

    override func viewWillAppear(_ animated: Bool) {
        //        TODO: this will be called 2 times on app first lounch
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = presenter?.getDataFromRepository() else {
            return 0
        }
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "custom"
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CustomCell, let meal = presenter?.getDataFromRepository()?[indexPath.row]{
            cell.mealName = meal.name
            cell.mealPhoto = meal.photo
            cell.mealRating = meal.rating
        return cell
        }
        return UITableViewCell()
    }
    
    func registerCells(){
        self.tableView.register(CustomCell.self, forCellReuseIdentifier: "custom")
    }
    
    func setupNavigationBar(){
        navigationItem.title = "Your Meals"
        let nextButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(moveToMealScreen))
        navigationItem.rightBarButtonItem = nextButton
    }
    
    @objc func moveToMealScreen(){
        navigationController?.pushViewController(MealViewController(), animated: true)
        //       show(MealViewController(), sender: nil)
    }

}
