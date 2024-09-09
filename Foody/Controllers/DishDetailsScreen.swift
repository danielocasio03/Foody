//
//  DishDetailsScreen.swift
//  Foody
//
//  Created by Daniel Efrain Ocasio on 9/8/24.
//

import Foundation
import UIKit

class DishDetailsScreen: UIViewController {
	
	//MARK: - Declarations
	
	var fetchedDishData: DishModel?
	
	//Header view for the table
	lazy var dishDetailsView: DishDetailsView = {
		let view = DishDetailsView()
		//Updating view with fetched dish data
		view.dishTitle.text = fetchedDishData?.strMeal
		view.categoryTag.labelName.text = fetchedDishData?.strCategory
		view.locationTag.labelName.text = fetchedDishData?.strArea
		//Safely loading and Updating image
		if let safeThumb = fetchedDishData?.strMealThumb {
			DataFetchManager.loadImage(from: safeThumb, into: view.dishImage)
			return view
		} else {
			return view
		}
	}()
	
	//Footer view for the table
	lazy var dishInstructionsView: DishInstructionsView = {
		let view = DishInstructionsView()
		view.instructions.text = fetchedDishData?.strInstructions
		return view
	}()
	
	//Declaration of the tableview where the ingredients for the dish will reside
	lazy var ingredientsTable: UITableView = {
		let table = UITableView()
		table.translatesAutoresizingMaskIntoConstraints = false
		table.dataSource = self
		table.delegate = self
		table.register(IngredientsTableCell.self, forCellReuseIdentifier: "CustomCell")
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
		//Ingredients table
		view.addSubview(ingredientsTable)
		
		NSLayoutConstraint.activate([
			//Ingredients Table
			ingredientsTable.topAnchor.constraint(equalTo: view.topAnchor),
			ingredientsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			ingredientsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			ingredientsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
		])
	}
	
	//When called, dismisses the viewController
	@objc func backTapped() {
		navigationController?.popViewController(animated: true)
	}
	
}



//MARK: - EXT: TableView Delegate and DataSource

extension DishDetailsScreen: UITableViewDelegate, UITableViewDataSource {
	
	//MARK: - Setup Functions
	
	//Function to setup the dishDetailsView Header and dishInstructionsView Footer
	func setupTableViewHeader() {
		//HEADER
		// Adding target to back button, calling backTapped
		dishDetailsView.backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
		//Configuring Header size
		dishDetailsView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 375)
		//Adding the header to the table
		ingredientsTable.tableHeaderView = dishDetailsView
		
		// FOOTER
		// Calculating dynamic height for dishInstructionsView based on its content
		let footerHeight = dishInstructionsView.calculateHeight(for: view.frame.width)
		dishInstructionsView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: footerHeight)
		// Setting the calculated height as the table footer view
		ingredientsTable.tableFooterView = dishInstructionsView
		
	}
	
	
	//MARK: - Table Delegate Functions
	
	//Number of rows
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		//checking if there is a count in ingredients then returning it to the row count
		guard let ingredientsCount = fetchedDishData?.ingredients.count else {
			print("Error getting ingredient count")
			return 0
		}
		return ingredientsCount
	}
	
	
	//Cell for row
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = ingredientsTable.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! IngredientsTableCell
		
		
		// Safely unwrap optional values
		if let measures = fetchedDishData?.measures, let ingredients = fetchedDishData?.ingredients {
			let measureForCell = measures[indexPath.row]
			let ingredientForCell = ingredients[indexPath.row]
			//Setting measure and ingredient to cell text label
			cell.ingredientLabel.text = "\(measureForCell) \(ingredientForCell)"
		}
		
		return cell
		
	}
	
	//Row Height
	func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return 75
	}
	
	
	//View for section header
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let headerView = UIView()
		headerView.backgroundColor = DesignManager.shared.appBackgroundColor
		
		//Creating the label with the Section Title
		let headerLabel = UILabel()
		headerLabel.translatesAutoresizingMaskIntoConstraints = false
		headerLabel.font = DesignManager.shared.titleFont
		headerLabel.textColor = DesignManager.shared.deepPurple
		headerLabel.text = "What You'll need"
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
