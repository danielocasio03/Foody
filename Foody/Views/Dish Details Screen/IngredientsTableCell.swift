//
//  IngredientsTableCell.swift
//  Foody
//
//  Created by Daniel Efrain Ocasio on 9/8/24.
//

import Foundation
import UIKit

class IngredientsTableCell: UITableViewCell {
	
	//MARK: - Declarations
	
	//This is the leaf bullet point that apears at the left side of each cell
	lazy var bulletPoint: UIImageView = {
		
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.image = UIImage(systemName: "leaf.fill")
		image.contentMode = .scaleAspectFit
		image.tintColor = DesignManager.shared.deepPurple
		return image
	}()
	
	// Title label for Ingredient and measurement
	lazy var ingredientLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = DesignManager.shared.tagFont?.withSize(15)
		label.textColor = DesignManager.shared.deepPurple
		label.lineBreakMode = .byWordWrapping
		label.numberOfLines = 1
		return label
	}()
	
	
	//MARK: - Init
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: reuseIdentifier)
		setupView()
	}
	
	
	
	//MARK: - Cell Setup
	
	//General View setup
	func setupView() {
		//changes to the actual cells appearance
		backgroundColor = DesignManager.shared.appBackgroundColor
		self.selectionStyle = .none
		//bulletPoint
		self.contentView.addSubview(bulletPoint)
		// ingredient label
		self.contentView.addSubview(ingredientLabel)
		
		NSLayoutConstraint.activate([
			//bulletPoint
			bulletPoint.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 40),
			bulletPoint.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
			bulletPoint.widthAnchor.constraint(equalToConstant: 20),
			//Ingredient Label
			ingredientLabel.leadingAnchor.constraint(equalTo: bulletPoint.trailingAnchor, constant: 15),
			ingredientLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
			ingredientLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
			
			
		])
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}



