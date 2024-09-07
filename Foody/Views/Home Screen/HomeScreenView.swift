//
//  HomeView.swift
//  Foody
//
//  Created by Daniel Efrain Ocasio on 9/4/24.
//

import Foundation
import UIKit

class HomeScreenView: UIView {
	
	//MARK: - Declarations
	
	//Adds in the Scrollview for all of the content on the homescreen
	let scrollView = CustomScrollView()
	//Adding in the daily pick view
	let dailyPickView = DailyPickView()
	//Adding in the categoriesView
	let categoriesView = CategoriesView()
	
	//Label for the greeting; will display "Good Morning" "Good Afternoon" "Good Evening" based off time of day
	lazy var greetingLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = DesignManager.shared.greeting
		label.font = DesignManager.shared.titleFont
		label.textColor = DesignManager.shared.deepPurple
		return label
	}()
	
	
	//MARK: - Init and Lifecycle
	
	//Override Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		integrateVerticalScrollview()
		setupView()
		setupDailyPickView()
		setupCategoriesView()
		
	}
	
	
	//MARK: -  View Setup Methods
	
	//Adds the scrollview and configures its constraints so that it scrolls Vertically
	func integrateVerticalScrollview() {
		
		self.addSubview(scrollView)
		
		NSLayoutConstraint.activate([
			//ScrollView
			scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
			scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			//ScrollView's content view
			scrollView.contentView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.9),
			scrollView.contentView.widthAnchor.constraint(equalTo: self.widthAnchor),
		])
	}
	
	//General setup of the view (self)
	func setupView() {
		//General View setup
		self.translatesAutoresizingMaskIntoConstraints = false
		self.backgroundColor = DesignManager.shared.appBackgroundColor
		//Greeting Label setup
		scrollView.contentView.addSubview(greetingLabel)
		
		NSLayoutConstraint.activate([
			//Greeting Label
			greetingLabel.leadingAnchor.constraint(equalTo: scrollView.contentView.leadingAnchor, constant: 20),
			greetingLabel.topAnchor.constraint(equalTo: scrollView.contentView.topAnchor, constant: 30),
		])
	}
	
	//Add and setup of the DailyPickView
	func setupDailyPickView() {
		//Adding the dailyPickView to the scrollView's contentView
		scrollView.contentView.addSubview(dailyPickView)
		
		NSLayoutConstraint.activate([
			//Daily Pick View
			dailyPickView.centerXAnchor.constraint(equalTo: scrollView.contentView.centerXAnchor),
			dailyPickView.leadingAnchor.constraint(equalTo: scrollView.contentView.leadingAnchor),
			dailyPickView.trailingAnchor.constraint(equalTo: scrollView.contentView.trailingAnchor),
			dailyPickView.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 50),
			dailyPickView.heightAnchor.constraint(equalTo: scrollView.contentView.heightAnchor, multiplier: 0.13),
			
		])
		
	}
	
	//Add and setup of the CategoriesView
	func setupCategoriesView() {
		//Adding the categoriesView to the scrollView's contentView
		scrollView.contentView.addSubview(categoriesView)
		
		NSLayoutConstraint.activate([
			//Categories View
			categoriesView.centerXAnchor.constraint(equalTo: scrollView.contentView.centerXAnchor),
			categoriesView.leadingAnchor.constraint(equalTo: scrollView.contentView.leadingAnchor),
			categoriesView.trailingAnchor.constraint(equalTo: scrollView.contentView.trailingAnchor),
			categoriesView.topAnchor.constraint(equalTo: dailyPickView.bottomAnchor, constant: 50),
			categoriesView.bottomAnchor.constraint(equalTo: scrollView.contentView.bottomAnchor),
			
		])
	}
	

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
