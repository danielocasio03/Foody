//
//  dishTableCell.swift
//  Foody
//
//  Created by Daniel Efrain Ocasio on 9/7/24.
//

import Foundation
import UIKit

class DishTableCell: UITableViewCell {
	
	//MARK: - Declarations
	
	// CONTAINER - This will be the container that makes it to where the cell has a rounded appearance and spacing between each bubble
	lazy var container: UIView = {
		let container = UIView()
		container.translatesAutoresizingMaskIntoConstraints = false
		container.backgroundColor = DesignManager.shared.componentPurple
		container.layer.cornerRadius = 10
		container.clipsToBounds = true

		
		return container
	}()
	
	//This is a UIView which acts as a shadow layer for the container. It is needed because the containerView's clips to bounds properties hinder shadows from showing
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
	
	// Image View for dish
	let dishImage: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.clipsToBounds = true
		image.contentMode = .scaleAspectFill

		return image
	}()
	
	// Title label for dish name
	let dishNameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = DesignManager.shared.largeDishNameFont
		label.textColor = DesignManager.shared.offWhite
		return label
	}()
	

	//MARK: - Init
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: reuseIdentifier)
		
		//changes to the actual cells appearance
		backgroundColor = DesignManager.shared.appBackgroundColor
		
		setupView()
	}
	
	
	
	//MARK: - Cell Setup
	
	//General View setup
	func setupView() {
		self.selectionStyle = .none
		//Adding the container shadow layer first
		addSubview(containerShadowLayer)
		//Add container and its subviews
		addSubview(container)
		//dishImage
		container.addSubview(dishImage)
		//dishnameLabel
		container.addSubview(dishNameLabel)
		
		NSLayoutConstraint.activate([
			//Container
			container.centerXAnchor.constraint(equalTo: centerXAnchor),
			container.centerYAnchor.constraint(equalTo: centerYAnchor),
			container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.80),
			container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85),
			
			//Container Shadow Layer
			containerShadowLayer.topAnchor.constraint(equalTo: container.topAnchor),
			containerShadowLayer.bottomAnchor.constraint(equalTo: container.bottomAnchor),
			containerShadowLayer.leadingAnchor.constraint(equalTo: container.leadingAnchor),
			containerShadowLayer.trailingAnchor.constraint(equalTo: container.trailingAnchor),
			
			//Dish Image
			dishImage.topAnchor.constraint(equalTo: container.topAnchor),
			dishImage.bottomAnchor.constraint(equalTo: container.bottomAnchor),
			dishImage.leadingAnchor.constraint(equalTo: container.leadingAnchor),
			dishImage.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.40),
			
			//Dish Name Label
			dishNameLabel.leadingAnchor.constraint(equalTo: dishImage.trailingAnchor, constant: 20),
			dishNameLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
			dishNameLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 15),
			
			
		])
	}
	
	
	// A method to configure the cell with data
	func configure(dishImage: UIImage?, dishTitle: String) {
		self.dishImage.image = dishImage
		dishNameLabel.text = dishTitle
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
