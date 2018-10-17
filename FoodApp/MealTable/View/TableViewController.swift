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
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CustomCell, let meal = presenter?.getDataFromRepository(index: indexPath.row){
            cell.setupSubviews(model: meal)
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
        let editButton = editButtonItem
        navigationItem.rightBarButtonItem = nextButton
        navigationItem.leftBarButtonItem = editButton
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            presenter?.removeMeal(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moveToMealScreenWithIndex(clickedMeal: indexPath.row)
    }
    
    @objc func moveToMealScreen(){
        navigationController?.pushViewController(MealViewController(index: nil), animated: true)
        //       show(MealViewController(index: nil), sender: nil)
    }
    
    @objc func moveToMealScreenWithIndex(clickedMeal: Int){
        navigationController?.pushViewController(MealViewController(index: clickedMeal), animated: true)
    }
}
