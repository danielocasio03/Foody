//
//  DesignManager.swift
//  Foody
//
//  Created by Daniel Efrain Ocasio on 9/4/24.
//

import Foundation
import UIKit

class DesignManager {
	
	//MARK: - Declarations
	
	// Singleton instance
	public static let shared = DesignManager()
	
	// Defines greeting property and its logic below which based off the time of day will say, Good Morning, Good Afternoon or Good Evening
	public var greeting: String
	
	// Private initializer to prevent the creation of multiple instances; contains the logic for getting time of day and setting the apprpriate greeting
	private init() {
		let now = Date()
		let calendar = Calendar.current
		let hour = calendar.component(.hour, from: now)
		
		if hour > 6 && hour < 12 {
			// Morning Scheme (6am - 11:59am)
			greeting = "Good Morning!"
		} else if hour >= 12 && hour < 18 {
			// Afternoon Scheme (12pm - 5:59pm)
			greeting = "Good Afternoon!"
		} else {
			// Evening Scheme (6pm - 6am)
			greeting = "Good Evening!"
		}
	}
	
	
	//MARK: - App Colors & Font
	
	//COLORS
	//This is the color used for the apps background throughout all the screens
	let appBackgroundColor = UIColor(red: 203/255, green: 193/255, blue: 191/255, alpha: 1.0)
	
	//This is the color in headings, titles etc.
	let deepPurple = UIColor(red: 43/255, green: 37/255, blue: 57/255, alpha: 1.0)
	
	//This is the background color for the apps components/tappable squares
	let componentPurple = UIColor(red: 73/255, green: 61/255, blue: 74/255, alpha: 1.0)
	
	//Off white font, seen in largeDishName's
	let offWhite = UIColor(red: 238/255, green: 233/255, blue: 231/255, alpha: 1.0)
	
	//Accented text color seen in tag's
	let accentTextColor = UIColor(red: 195/255, green: 190/255, blue: 188/255, alpha: 1.0)
	
	
	//FONTS
	//The font used for the apps titles for screens
	let titleFont = UIFont(name: "Futura-Bold", size: 26)
	
	//The font used for the apps section headings
	let sectionHeadingFont = UIFont(name: "Futura-Medium", size: 20)
	
	//The font used across the app to display the dish names
	let largeDishNameFont = UIFont(name: "Futura-Medium", size: 19)
	
	//The font used for tag's
	let tagFont = UIFont(name: "Futura-Medium", size: 10)
	
	

}
