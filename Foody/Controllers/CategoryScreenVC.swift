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
	
	//Declaration of the tableview where all the dishes for the screens categories will be housed
	lazy var dishesTable: UITableView = {
		
		let table = UITableView()
		table.translatesAutoresizingMaskIntoConstraints = false
		table.dataSource = self
		table.delegate = self
		table.register(DishTableCell.self, forCellReuseIdentifier: "CustomCell")
		
		table.backgroundColor = .blue
		
		table.tableHeaderView = CategoryDetailsView()
		table.contentInsetAdjustmentBehavior = .never
		return table
	}()
	
	
	//MARK: - Lifecycle functions
	
	override func viewDidLoad() {
		
		setupView()
		
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
	
	
}



//MARK: - EXT: TableView Delegate and DataSource

extension CategoryScreenVC: UITableViewDelegate, UITableViewDataSource {
	
	//Number of rows
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}
	
	
	//Cell for row
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = dishesTable.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! DishTableCell
		cell.configure(dishImage: UIImage(named: "test"), dishTitle: "Test Food")
		
		return cell
		
	}
	
	
}
