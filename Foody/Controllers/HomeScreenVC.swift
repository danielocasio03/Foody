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
		//Dequeuing the cell for the categorycollectionview using the CategoryCell
		let cell = homeView.categoriesView.categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! CategoryCell
		
		// Since each section has 2 items, multiplying the section by 2 and adding the item gives the correct index in a 1D array format (to match how our fetchedCategories array is structured)
		let categoryIndex = indexPath.section * 2 + indexPath.item
		
		// Below checks if the index is within bounds of the fetchedCategories array before proceeding to avoid any crashes
		if categoryIndex < fetchedCategories.count {
			let category = fetchedCategories[categoryIndex]
			// Assign Category data to cell
			cell.categoryTitle.text = category.strCategory
			//Calls the loadImage Utility function to load the image directly into the cells category image
			DataFetchManager.loadImage(from: category.strCategoryThumb, into: cell.categoryImage)
		} else {
			// Handle cases where categories do not yet exist
			cell.categoryTitle.text = "Loading..."
		}
		
		return cell
	}
	
	//didSelectItemAt
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		//Getting the selected category based off index
		guard let selectedCategory = (indexPath.section * 2 + indexPath.item) < fetchedCategories.count ? fetchedCategories[indexPath.section * 2 + indexPath.item] : nil else {
			print("Category not available")
			return
		}
		
		//Fetching for the dishes from the selected category and pushing the categoryVC with the fetched data
		Task {
			do{
				
				let fetchedDishes = try await DataFetchManager().fetchDishesForCategory(for: selectedCategory.strCategory)
				//Initializing category screen passing in the category and fetched dishes
				let categoryScreen = CategoryScreenVC()
				categoryScreen.selectedCategory = selectedCategory
				categoryScreen.dishesForCategory = fetchedDishes
				navigationController?.pushViewController(categoryScreen, animated: true)
				
				print("Dishes for Category fetch returned and stored successfully \(print(fetchedDishes))")
			} catch {
				print("Dishes For category fetch returned with error: \(error)")
			}
		}
		
	}
	
	
}

