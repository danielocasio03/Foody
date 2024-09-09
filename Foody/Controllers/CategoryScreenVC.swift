//
//  CategoryVC.swift
//  Foody
//
//  Created by Daniel Efrain Ocasio on 9/6/24.
//

import Foundation
import UIKit

class CategoryScreenVC: UIViewController {
	
	//MARK: - Declarations
	
	var selectedCategory: DishCategory?
	
	var dishesForCategory: [DishesForCategoryModel] = []
	
	lazy var categoryDetailsView: CategoryDetailsView = {
		let view = CategoryDetailsView()
		//Passing in the selected Category Data to the detail view
		view.categoryTitle.text = selectedCategory?.strCategory
		view.categoryDetail.text = selectedCategory?.strCategoryDescription
		return view
	}()
	
	//Declaration of the tableview where all the dishes for the screens categories will be housed
	lazy var dishesTable: UITableView = {
		let table = UITableView()
		table.translatesAutoresizingMaskIntoConstraints = false
		table.dataSource = self
		table.delegate = self
		table.register(DishTableCell.self, forCellReuseIdentifier: "CustomCell")
		table.contentInsetAdjustmentBehavior = .never
		table.backgroundColor = DesignManager.shared.appBackgroundColor
		table.separatorStyle = .none
		return table
	}()
	
	
	//MARK: - Lifecycle functions
	
	override func viewDidLoad() {
		
		setupView()
		setupTableViewHeader()
		
	}
	
	
	//MARK: - Setup Methods

	//General view setup
	func setupView() {
		//General View setup
		view.backgroundColor = DesignManager.shared.appBackgroundColor
		//Dishes table
		view.addSubview(dishesTable)
				
		NSLayoutConstraint.activate([
			//Dishes Table
			dishesTable.topAnchor.constraint(equalTo: view.topAnchor),
			dishesTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			dishesTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			dishesTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
		])
	}
	
	//When called, dismisses the viewController
	@objc func backTapped() {
		navigationController?.popViewController(animated: true)
	}
	
}



//MARK: - EXT: TableView Delegate and DataSource

extension CategoryScreenVC: UITableViewDelegate, UITableViewDataSource {
	
	//MARK: - Setup Functions
	
	//Function to setup the categoryDetailsView Header for the table
	func setupTableViewHeader() {
		//Adding target to back button, calling backTapped
		categoryDetailsView.backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
		// Calculate height for the headerview
		let calculatedHeight = categoryDetailsView.calculateHeight(for: view.frame.width)
		// Set the frame for the header view based on the calculated height
		categoryDetailsView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: calculatedHeight)
		// Set header as the tableHeaderView
		dishesTable.tableHeaderView = categoryDetailsView
	}
	
	
	//MARK: - Table Delegate Functions
	
	//Number of rows
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dishesForCategory.count
	}
	
	
	//Cell for row
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = dishesTable.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! DishTableCell
		
		//Getting the dish for the dequeued cell
		let dishForCell = dishesForCategory[indexPath.row]
		
		//Loading the image into the cell and setting the dish's name to the cells textLabel
		DataFetchManager.loadImage(from: dishForCell.strMealThumb, into: cell.dishImage)
		cell.dishNameLabel.text = dishForCell.strMeal
		
		return cell
	}
	
	
	//Did select row
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let dishDetailsVC = DishDetailsScreen()
		let selectedDish = dishesForCategory[indexPath.row]
		
		Task {
			do{
				let fetchedDish = try await DataFetchManager().fetchRandomDish(mealID: selectedDish.idMeal)
				dishDetailsVC.fetchedDishData = fetchedDish
				navigationController?.pushViewController(dishDetailsVC, animated: true)
				print("Dish fetch returned and stored successfully")
			} catch {
				print("Dish fetch returned with error: \(error)")
			}
			
		}
		
		
	}
	
	
	//Static setting of the cells height
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 140
	}
	
	
	//View for header
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let headerView = UIView()
		headerView.backgroundColor = DesignManager.shared.appBackgroundColor
		
		//Creating the label with the Section Title
		let headerLabel = UILabel()
		headerLabel.translatesAutoresizingMaskIntoConstraints = false
		headerLabel.font = DesignManager.shared.sectionHeadingFont
		headerLabel.textColor = DesignManager.shared.deepPurple
		headerLabel.text = "Dishes" 
		headerView.addSubview(headerLabel)
		
		// Set constraints for the label to align it properly inside the header view
		NSLayoutConstraint.activate([
			headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
			headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 30),
			headerLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16)
		])
		
		return headerView
	}
	
	
	//Height for Section header
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 50
	}
	
	
}
