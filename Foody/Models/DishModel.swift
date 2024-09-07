//
//  DishModel.swift
//  Foody
//
//  Created by Daniel Efrain Ocasio on 9/6/24.
//

import Foundation

struct DishResponse: Decodable {
	let meals: [DishModel]
}

struct DishModel: Decodable {
	
	let idMeal: String
	let strMeal: String
	let strDrinkAlternate: String?
	let strCategory: String
	let strArea: String
	let strInstructions: String
	let strMealThumb: String
	let strTags: String?
	let strYoutube: String?
	let strSource: String
	let strImageSource: String?
	let strCreativeCommonsConfirmed: String?
	let dateModified: String?
	
	// Ingredient properties 1-20
	let strIngredient1: String?
	let strIngredient2: String?
	let strIngredient3: String?
	let strIngredient4: String?
	let strIngredient5: String?
	let strIngredient6: String?
	let strIngredient7: String?
	let strIngredient8: String?
	let strIngredient9: String?
	let strIngredient10: String?
	let strIngredient11: String?
	let strIngredient12: String?
	let strIngredient13: String?
	let strIngredient14: String?
	let strIngredient15: String?
	let strIngredient16: String?
	let strIngredient17: String?
	let strIngredient18: String?
	let strIngredient19: String?
	let strIngredient20: String?
	
	// Measure properties 1-20
	let strMeasure1: String?
	let strMeasure2: String?
	let strMeasure3: String?
	let strMeasure4: String?
	let strMeasure5: String?
	let strMeasure6: String?
	let strMeasure7: String?
	let strMeasure8: String?
	let strMeasure9: String?
	let strMeasure10: String?
	let strMeasure11: String?
	let strMeasure12: String?
	let strMeasure13: String?
	let strMeasure14: String?
	let strMeasure15: String?
	let strMeasure16: String?
	let strMeasure17: String?
	let strMeasure18: String?
	let strMeasure19: String?
	let strMeasure20: String?
	
	// Ingredients and measures as arrays of optional strings
	var ingredients: [String] {
		return [
			strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5,
			strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10,
			strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15,
			strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
		].compactMap { $0 }
	}
	
	var measures: [String] {
		return [
			strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5,
			strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10,
			strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15,
			strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
		].compactMap { $0 }
	}
	
	
	
	
	// MARK: - Coding Keys
	enum CodingKeys: String, CodingKey {
		case idMeal
		case strMeal
		case strDrinkAlternate
		case strCategory
		case strArea
		case strInstructions
		case strMealThumb
		case strTags
		case strYoutube
		case strSource
		case strImageSource
		case strCreativeCommonsConfirmed
		case dateModified
		
		case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5
		case strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10
		case strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15
		case strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
		
		case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5
		case strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10
		case strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15
		case strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
	}
}
