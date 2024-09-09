//
//  DishesForCategoryModel.swift
//  Foody
//
//  Created by Daniel Efrain Ocasio on 9/7/24.
//

import Foundation


//This is the model for the data that returns all dishes for a given category
struct DishesForCategoryResponse: Decodable {
	
	let meals: [DishesForCategoryModel]
	
}

struct DishesForCategoryModel: Decodable {
	
	let strMeal: String
	
	let strMealThumb: String
	
	let idMeal: String
	
}
