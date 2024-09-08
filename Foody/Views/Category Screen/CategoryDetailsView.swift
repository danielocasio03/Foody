//
//  CategoryDetailsView.swift
//  Foody
//
//  Created by Daniel Efrain Ocasio on 9/6/24.
//

import Foundation
import UIKit

class CategoryDetailsView: UIStackView {
	
	//MARK: - Declarations
	
	// Back button to dismiss the view controller
	lazy var backButton: UIButton = {
		let button = UIButton(type: .system)
		let backImage = UIImage(systemName: "chevron.left")
		button.setImage(backImage, for: .normal)
		button.tintColor = DesignManager.shared.offWhite
		button.contentHorizontalAlignment = .leading
		return button
	}()
	
	//label holding the title for the category
	lazy var categoryTitle: UILabel = {
		let label = UILabel()
		label.font = DesignManager.shared.titleFont
		label.textColor = DesignManager.shared.offWhite.withAlphaComponent(0.75)
		return label
	}()
	
	//Label for holding the details/description of the category
	lazy var categoryDetail: UILabel = {
		let label = UILabel()
		label.font = DesignManager.shared.tagFont?.withSize(14)
		label.textColor = DesignManager.shared.offWhite.withAlphaComponent(0.75)
		label.lineBreakMode = .byWordWrapping
		label.numberOfLines = 4
		return label
	}()
	
	
	//MARK: - Init and Lifecycle
	
	//Override Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupStackView()
		setupSubviews()
		
	}
	
	//Implemented to fix the labels height and word wrapping
	override func layoutSubviews() {
		super.layoutSubviews()
		// Ensuring the label knows its width so it can calculate its height
		categoryDetail.preferredMaxLayoutWidth = self.frame.width - self.layoutMargins.left - self.layoutMargins.right
	}
	
	
	//MARK: -  View Setup Methods
	
	//General setup of the stack view
	func setupStackView() {
		//General View setup
		self.axis = .vertical
		self.distribution = .equalSpacing
		self.isLayoutMarginsRelativeArrangement = true
		self.layoutMargins = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
		self.spacing = 15
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
		//Category Title
		self.addArrangedSubview(categoryTitle)
		//Category Detail
		self.addArrangedSubview(categoryDetail)
	}
	
	//MARK: - Helper Methods
	
	// Method to calculate the required height for the view
	func calculateHeight(for width: CGFloat) -> CGFloat {
		// Calculate title label height
		let titleHeight = categoryTitle.sizeThatFits(CGSize(width: width - layoutMargins.left - layoutMargins.right, height: CGFloat.greatestFiniteMagnitude)).height
		
		// Calculate detail label height
		let detailHeight = categoryDetail.sizeThatFits(CGSize(width: width - layoutMargins.left - layoutMargins.right, height: CGFloat.greatestFiniteMagnitude)).height
		
		// Return total height + padding and spacing + constant for extra room
		return titleHeight + detailHeight + layoutMargins.top + layoutMargins.bottom + spacing + 100
	}

	
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
	
