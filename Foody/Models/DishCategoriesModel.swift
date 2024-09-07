//
//  CategoriesModel.swift
//  Foody
//
//  Created by Daniel Efrain Ocasio on 9/6/24.
//

import Foundation

//This Struct Models out the Categories JSON data structure
struct DishCategoriesModel: Decodable {
	
	let categories: [DishCategory]
	
}

struct DishCategory: Decodable {
	
	let idCategory: String
	
	let strCategory: String
	
	let strCategoryThumb: String
	
	let strCategoryDescription : String
	
}
