//
//  ViewController.swift
//  Foody
//
//  Created by Daniel Efrain Ocasio on 9/4/24.
//

import UIKit

class HomeScreenVC: UIViewController {
	
	//MARK: - Declarations
	
	let homeView = HomeScreenView()
	
	//Declare and init an empty array of type DishCategory
	var fetchedCategories: [DishCategory] = []
		
	
	//MARK: - Lifecycle functions
	
	override func viewDidLoad() {
		super.viewDidLoad()
		fetchCategories()
		fetchdailyDish()
		setupview()
		setupCollectionView()
	}
	
	
	//MARK: - Setup Methods
	
	//General view setup
	func setupview() {
		//Adding in homeView
		view.addSubview(homeView)
		
		NSLayoutConstraint.activate([
			//Home View
			homeView.topAnchor.constraint(equalTo: view.topAnchor),
			homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
		])
	}
	
	//Function to load the dailyPick with data
	func loadDailyPick(dailyDish: DishModel) {
		
		DispatchQueue.main.async { [weak self] in
			guard let self = self else {return}
			DataFetchManager.loadImage(from: dailyDish.strMealThumb, into: homeView.dailyPickView.dishImage)
			homeView.dailyPickView.dishNameLabel.text = dailyDish.strMeal
			
			homeView.dailyPickView.categoryTag.labelName.text = dailyDish.strCategory
			homeView.dailyPickView.categoryTag.tagSymbol.image = UIImage(systemName: "tag.fill")
			homeView.dailyPickView.locationTag.labelName.text = dailyDish.strArea
			homeView.dailyPickView.locationTag.tagSymbol.image = UIImage(systemName: "map.circle")

		}
	}
	
	
	
	
	//MARK: - Helper Methods
	
	//Function in charge of fetching for the categories
	func fetchCategories() {
		Task {
			do{
				let fetchedCategories = try await DataFetchManager().fetchCategories()
				//storing fetched data in local variable
				self.fetchedCategories = fetchedCategories
				print("Categories fetch returned and stored successfully")
				//reload the collectionview with the fetched data
				homeView.categoriesView.categoriesCollectionView.reloadData()
			} catch {
				print("Categories fetch returned with error: \(error)")
			}
		}
	}
	
	//Function in charge of fetching for a random dish
	func fetchdailyDish() {
		
		Task {
			do{
				let fetchedDailyDish = try await DataFetchManager().fetchRandomDish()
				//storing fetched data in local variable
				loadDailyPick(dailyDish: fetchedDailyDish)
				print("Random dish fetch returned and stored successfully")
			} catch {
				print("Random Dish fetch returned with error: \(error)")
			}

		}
	}
	
}

//MARK: - EXT: UICollectionView

extension HomeScreenVC: UICollectionViewDelegate, UICollectionViewDataSource {
	
	//general setup of the collectionview
	func setupCollectionView() {
		homeView.categoriesView.categoriesCollectionView.dataSource = self
		homeView.categoriesView.categoriesCollectionView.delegate = self
		homeView.categoriesView.categoriesCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "customCell")
	}
	
	//number of items in each section
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 2
	}
	
	//number of sections
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 7
	}
	
	//cellForItemAt - responsible for populating each collection view cell with data
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		// Dequeue reusable cell for the collection view
		let cell = homeView.categoriesView.categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! CategoryCell
		
		// Use the helper method to get the corresponding DishCategory for the current indexPath
		if let category = getCategory(for: indexPath) {
			// Assign the category name to the cell's label
			cell.categoryTitle.text = category.strCategory
			// Load the category image asynchronously into the cell's image view
			DataFetchManager.loadImage(from: category.strCategoryThumb, into: cell.categoryImage)
		} else {
			// If no category is found (data not yet loaded), show a loading state
			cell.categoryTitle.text = "Loading..."
			cell.categoryImage.image = nil  // Clear the image until data is available
		}
		
		return cell
	}
	
	//didSelectItemAt
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		// Use the helper method to get the selected category based on the current indexPath
		guard let selectedCategory = getCategory(for: indexPath) else {
			print("Category not available")  // Handle the case where no category is available
			return
		}
		
		// Perform asynchronous task to fetch dishes for the selected category
		Task {
			do {
				// Fetch dishes for the selected category
				let fetchedDishes = try await DataFetchManager().fetchDishesForCategory(for: selectedCategory.strCategory)
				// Initialize the CategoryScreenVC and pass the selected category and its dishes
				let categoryScreen = CategoryScreenVC()
				categoryScreen.selectedCategory = selectedCategory
				categoryScreen.dishesForCategory = fetchedDishes
				// Push  the category screen
				navigationController?.pushViewController(categoryScreen, animated: true)
				
				print("Dishes for Category fetch returned and stored successfully \(print(fetchedDishes))")
			} catch {
				print("Dishes For category fetch returned with error: \(error)")  // Handle fetch errors
			}
		}
		
	}
	
	
}

//MARK: - Extension: get category method
extension HomeScreenVC {
	
	//Method designed to get a caegory for a given indexPath.
	//Used to simplify the logic in getting the needed category for a given collectionviewItem, or selected item
	func getCategory(for indexPath: IndexPath) -> DishCategory? {
		let categoryIndex = indexPath.section * 2 + indexPath.item
		return categoryIndex < fetchedCategories.count ? fetchedCategories[categoryIndex] : nil
	}
}

