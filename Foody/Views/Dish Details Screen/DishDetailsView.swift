//
//  DishDetailsView.swift
//  Foody
//
//  Created by Daniel Efrain Ocasio on 9/8/24.
//

import Foundation
import UIKit

class DishDetailsView: UIStackView {
	
	//MARK: - Declarations
	
	// Back button to dismiss the view controller
	lazy var backButton: UIButton = {
		let button = UIButton(type: .system)
		button.translatesAutoresizingMaskIntoConstraints = false
		let backImage = UIImage(systemName: "chevron.left")
		button.setImage(backImage, for: .normal)
		button.tintColor = DesignManager.shared.offWhite
		button.contentHorizontalAlignment = .leading
		return button
	}()
	
	//label holding the title for the Dish
	lazy var dishTitle: UILabel = {
		let label = UILabel()
		label.font = DesignManager.shared.titleFont
		label.textColor = DesignManager.shared.offWhite.withAlphaComponent(0.75)
		label.lineBreakMode = .byWordWrapping
		label.numberOfLines = 4
		return label
	}()
	
	//ImagView holding the image for the dish
	lazy var dishImage: UIImageView = {
		let image = UIImageView()
		image.contentMode = .scaleAspectFit
		image.heightAnchor.constraint(equalToConstant: 150).isActive = true
		image.widthAnchor.constraint(equalToConstant: 150).isActive = true
		image.layer.cornerRadius = 10
		image.clipsToBounds = true
		return image
	}()
	
	// Horizontal StackView to contain dishTitle and dishImage
	lazy var horizontalStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [dishTitle, dishImage])
		stackView.axis = .horizontal
		stackView.alignment = .center
		stackView.spacing = 16 // Spacing between the title and the image
		stackView.distribution = .fill
		return stackView
	}()
	
	//Category and Location tags
	lazy var categoryTag = TagLabel()
	lazy var locationTag = TagLabel()
	
	
	//MARK: - Init and Lifecycle
	
	//Override Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupStackView()
		setupSubviews()
		
	}

	
	//MARK: -  View Setup Methods
	
	//General setup of the stack view
	func setupStackView() {
		//General View setup
		self.axis = .vertical
		self.distribution = .equalSpacing
		self.isLayoutMarginsRelativeArrangement = true
		self.layoutMargins = UIEdgeInsets(top: 25, left: 25, bottom: 40, right: 25)
		self.spacing = 20
		self.backgroundColor = DesignManager.shared.componentPurple
		// Shadow settings
		self.layer.shadowColor = UIColor.black.cgColor
		self.layer.shadowOpacity = 0.3
		self.layer.shadowOffset = CGSize(width: -3, height: 3)
		self.layer.shadowRadius = 5
		self.layer.cornerRadius = 10
	}
	
	//Setup of the stackViews ArrangedSubviews
	func setupSubviews() {
		// Add Back Button
		self.addArrangedSubview(backButton)
		// Add the horizontal stackView containing the dishTitle and dishImage
		self.addArrangedSubview(horizontalStackView)
		//Tags
		self.addArrangedSubview(categoryTag)
		categoryTag.tagSymbol.image = UIImage(systemName: "tag.fill")
		self.addArrangedSubview(locationTag)
		locationTag.tagSymbol.image = UIImage(systemName: "map.circle")
		

	}
	
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
