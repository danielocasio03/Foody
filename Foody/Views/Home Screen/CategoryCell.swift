//
//  CategoryCell.swift
//  Foody
//
//  Created by Daniel Efrain Ocasio on 9/6/24.
//

import Foundation
import UIKit

class CategoryCell: UICollectionViewCell {
	
	//MARK: - Declarations
	
	//Category image
	lazy var categoryImage: UIImageView = {
		let categoryImage = UIImageView()
		categoryImage.translatesAutoresizingMaskIntoConstraints = false
		categoryImage.contentMode = .scaleAspectFit
		categoryImage.clipsToBounds = true
		
		return categoryImage
	}()
	
	//Category Title label
	lazy var categoryTitle: UILabel = {
		
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = DesignManager.shared.largeDishNameFont
		label.textColor = DesignManager.shared.offWhite
		return label
	}()
	
	//MARK: - Override
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupCell()
		
	}
	
	//MARK: - Setup Functions
	
	func setupCell() {
		//Cell properties
		self.backgroundColor = DesignManager.shared.componentPurple
		self.layer.cornerRadius = 10
		// Shadow settings
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOpacity = 0.3
		layer.shadowOffset = CGSize(width: -3, height: 3)
		layer.shadowRadius = 5 
		//categoryImage
		self.addSubview(categoryImage)
		//category Title
		self.addSubview(categoryTitle)
		
		NSLayoutConstraint.activate([
			//categoryImage
			categoryImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			categoryImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
			categoryImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
			categoryImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 7),
			categoryImage.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 10),
			//categoryTitle
			categoryTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			categoryTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			categoryTitle.topAnchor.constraint(equalTo: categoryImage.bottomAnchor),
		])
		
	}
	
	
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
