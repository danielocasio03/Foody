//
//  dishTableCell.swift
//  Foody
//
//  Created by Daniel Efrain Ocasio on 9/7/24.
//

import Foundation
import UIKit

class DishTableCell: UITableViewCell {
	
	// CONTAINER - This will be the container that makes it to where the cell has a rounded appearance and spacing between each bubble
	lazy var container: UIView = {
		let container = UIView()
		container.translatesAutoresizingMaskIntoConstraints = false
		container.backgroundColor = DesignManager.shared.componentPurple
		container.layer.cornerRadius = 10
		// Shadow settings
		container.layer.shadowColor = UIColor.black.cgColor
		container.layer.shadowOpacity = 0.3
		container.layer.shadowOffset = CGSize(width: -3, height: 3)
		container.layer.shadowRadius = 5
		container.layer.cornerRadius = 10
		
		return container
	}()
	
	// Image View for dish
	let dishImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		imageView.layer.cornerRadius = 10
		imageView.clipsToBounds = true
		return imageView
	}()
	
	// Title label for dish name
	let dishTitleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = DesignManager.shared.largeDishNameFont
		label.textColor = DesignManager.shared.offWhite
		return label
	}()

	
	
	static let identifiter =  "CustomCel"
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: reuseIdentifier)
		
		//changes to the actual cells appearance
		backgroundColor = DesignManager.shared.appBackgroundColor
		
		setupView()
	}
	
	
	
	//MARK: - Cell Setup
	
	//General View setup
	func setupView() {
		//Add container and its subviews
		addSubview(container)
		container.addSubview(dishImageView)
		container.addSubview(dishTitleLabel)
		
		NSLayoutConstraint.activate([
			container.centerXAnchor.constraint(equalTo: centerXAnchor),
			container.centerYAnchor.constraint(equalTo: centerYAnchor),
			container.heightAnchor.constraint(equalTo: self.heightAnchor, constant: 0.70),
			container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.70),
			
			// Dish image constraints
			dishImageView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
			dishImageView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
			dishImageView.widthAnchor.constraint(equalToConstant: 80),
			dishImageView.heightAnchor.constraint(equalToConstant: 80),
			
			// Dish title label constraints
			dishTitleLabel.leadingAnchor.constraint(equalTo: dishImageView.trailingAnchor, constant: 15),
			dishTitleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
			dishTitleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 15),
			
		])
	}
	
	
	// A method to configure the cell with data
	func configure(dishImage: UIImage?, dishTitle: String) {
		dishImageView.image = dishImage
		dishTitleLabel.text = dishTitle
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
