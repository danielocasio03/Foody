//
//  DataFetchManager.swift
//  Foody
//
//  Created by Daniel Efrain Ocasio on 9/6/24.
//

import Foundation
import UIKit

class DataFetchManager{
	
	// MARK: - Fetch Error Handling
	
	enum FetchError: Error {
		case invalidURL
		case responseError(statusCode: Int)
		case decodingError(description: String)
		case imageLoadingError(description: String)
		
		// Custom error messages
		var localizedDescription: String {
			switch self {
			case .invalidURL:
				return "The URL provided is invalid."
			case .responseError(let statusCode):
				return "The server responded with an error. Status code: \(statusCode)"
			case .decodingError(let description):
				return "Decoding failed with error: \(description)"
			case .imageLoadingError(let description):
				return "Image loading failed with error: \(description)"
			}
		}
	}
	
	
	//MARK: - API Fetch Methods
	
	// This is the Async method to fetch categories with error handling; using the above enum
	func fetchCategories() async throws -> [DishCategory] {
		guard let url = URL(string: "https://themealdb.com/api/json/v1/1/categories.php") else {
			throw FetchError.invalidURL
		}
		
		//Try to fetch the data
		do {
			let (data, response) = try await URLSession.shared.data(from: url)
			
			//Check for response status code for success or failure. Handling error in the event of failure
			guard (response as? HTTPURLResponse)?.statusCode == 200 else {
				let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
				throw FetchError.responseError(statusCode: statusCode)
			}
			
			//Decide data from DishCategoriesModel
			let categoriesResponse = try JSONDecoder().decode(DishCategoriesModel.self, from: data)
			//return the array of fetched categories
			return categoriesResponse.categories
		} catch {
			//error handling in case of decoding failure
			throw FetchError.decodingError(description: error.localizedDescription)
		}
	}
	
	
	func fetchDish() async throws -> DishModel {
		
		guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/random.php") else {
			throw FetchError.invalidURL
		}
		
		//Try to fetch the data
		do {
			let (data, response) = try await URLSession.shared.data(from: url)
			
			//Check for response status code for success or failure. Handling error in the event of failure
			guard (response as? HTTPURLResponse)?.statusCode == 200 else {
				let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
				throw FetchError.responseError(statusCode: statusCode)
			}
			
			//Decide data from DishCategoriesModel
			let dishResponse = try JSONDecoder().decode(DishResponse.self, from: data)
			guard let dish = dishResponse.meals.first else {
				throw FetchError.decodingError(description: "No dishes found in the response.")
			}
			//return the array of fetched categories
			return dish
		} catch {
			//error handling in case of decoding failure
			throw FetchError.decodingError(description: error.localizedDescription)
		}
		
		
	}
	
	
	//MARK: - Utility Methods
	
	// Function to load an image from a URL and set it into a UIImageView
	static func loadImage(from urlString: String, into imageView: UIImageView) {
		//Checks URL
		guard let url = URL(string: urlString) else { return }
		
		// We perform the image loading on a background thread to avoid clogging up the main thread, which could lead to UI bottle necks
		DispatchQueue.global().async {
			
			// If data fetching is successful, update the UIImageView on the main thread -  else print error
			if let data = try? Data(contentsOf: url) {
				DispatchQueue.main.async {
					imageView.image = UIImage(data: data)
				}
			} else {
				print("Failed to load image data from URL: \(urlString)")
			}
		}
	}
	
}



