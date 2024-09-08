//
//  DishesForCategoryModel.swift
//  Foody
//
//  Created by Daniel Efrain Ocasio on 9/7/24.
//

import Foundation

struct DishesForCategoryResponse: Decodable {
	
	let meals: [DishesForCategoryModel]
	
}

struct DishesForCategoryModel: Decodable {
	
	let strMeal: String
	
	let strMealThumb: String
	
	let idMeal: String
	
}
