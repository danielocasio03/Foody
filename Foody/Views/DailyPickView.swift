//
//  DailyPickView.swift
//  Foody
//
//  Created by Daniel Efrain Ocasio on 9/4/24.
//

import Foundation
import UIKit

class DailyPickView: UIView {
	
	//MARK: - Declarations

	//Label that holds the title for the DailyPick Section
	lazy var dailyPickTitle: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = DesignManager.shared.sectionHeadingFont
		label.textColor = DesignManager.shared.deepPurple
		label.text = "Your Daily Pick"
		
		return label
	}()
	
	//containerView UIView to hold the content for the DailyPickView
	lazy var containerView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = DesignManager.shared.componentPurple
		view.layer.cornerRadius = 10
		view.clipsToBounds = true
		
		return view
	}()
	
	//This is a UIView which acts as a shadow layer for the containerview. It is needed because the containerView's clips to bounds properties hinder shadows from showing
	lazy var containerShadowLayer: UIView = {
		
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = DesignManager.shared.appBackgroundColor
		view.layer.cornerRadius = 10
		view.clipsToBounds = false
		// Shadow settings
		view.layer.shadowColor = UIColor.black.cgColor
		view.layer.shadowOpacity = 0.3 
		view.layer.shadowOffset = CGSize(width: -3, height: 3)
		view.layer.shadowRadius = 5
		
		return view
	}()
	
	//The ImageView for the image of the dish to be displayed
	lazy var dishImage: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.clipsToBounds = true
		image.contentMode = .scaleAspectFill
	
		return image
	}()
	
	//This is the Label that displays the name of the dish's name
	lazy var dishNameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = DesignManager.shared.offWhite
		label.font = DesignManager.shared.largeDishNameFont
		label.lineBreakMode = .byWordWrapping
		label.numberOfLines = 3
		
		return label
	}()
	
	lazy var categoryTag = TagLabel()
	lazy var locationTag = TagLabel()
	
	
	
	//MARK: - Override init
	
	init() {
		//initializer assignments
		super.init(frame: .zero)
		
		setupView()
		setupContainerView()
		
	}
	
	
	//MARK: - Setup Methods
	
	//Setup of the view
	func setupView() {
		//General View setup
		self.translatesAutoresizingMaskIntoConstraints = false
		self.backgroundColor = .clear
		//Daily Pick Title
		addSubview(dailyPickTitle)
		
		NSLayoutConstraint.activate([
			//Daily Pick Title
			dailyPickTitle.topAnchor.constraint(equalTo: self.topAnchor),
			dailyPickTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
		])
	}
	
	
	//Setup of the containerView
	func setupContainerView() {
		//Adding the container shadow layer first
		self.addSubview(containerShadowLayer)
		//Adding containerView to view
		self.addSubview(containerView)
		//Adding Dish image
		containerView.addSubview(dishImage)
		//Dish Name Label
		containerView.addSubview(dishNameLabel)
		//CategoryTag
		containerView.addSubview(categoryTag)
		//LocationTag
		containerView.addSubview(locationTag)
		
		NSLayoutConstraint.activate([
			//Container View
			containerView.topAnchor.constraint(equalTo: dailyPickTitle.bottomAnchor,constant: 17),
			containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
			containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
			containerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
			//Container Shadow Layer
			containerShadowLayer.topAnchor.constraint(equalTo: containerView.topAnchor),
			containerShadowLayer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
			containerShadowLayer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
			containerShadowLayer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
			//Dish Image
			dishImage.topAnchor.constraint(equalTo: containerView.topAnchor),
			dishImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
			dishImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
			dishImage.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.40),
			//Dish Name Label
			dishNameLabel.leadingAnchor.constraint(equalTo: dishImage.trailingAnchor, constant: 20),
			dishNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
			dishNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15),
			//CategoryTag
			categoryTag.topAnchor.constraint(equalTo: dishNameLabel.bottomAnchor, constant: 20),
			categoryTag.leadingAnchor.constraint(equalTo: dishNameLabel.leadingAnchor),
			categoryTag.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -20),
			//Location Tag
			locationTag.topAnchor.constraint(equalTo: categoryTag.bottomAnchor, constant: 30),
			locationTag.leadingAnchor.constraint(equalTo: categoryTag.leadingAnchor),
			locationTag.trailingAnchor.constraint(equalTo: categoryTag.trailingAnchor),
			locationTag.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -10)
		])
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

