//
//  DishInstructionsView.swift
//  Foody
//
//  Created by Daniel Efrain Ocasio on 9/8/24.
//

import Foundation
import UIKit

class DishInstructionsView: UIStackView {
	
	//MARK: - Declarations
	
	//label holding the section title
	lazy var sectionTitle: UILabel = {
		let label = UILabel()
		label.font = DesignManager.shared.titleFont
		label.textColor = DesignManager.shared.deepPurple
		label.text = "Let's get started!"
		return label
	}()
	
	//Label for holding the instructions
	lazy var instructions: UILabel = {
		let label = UILabel()
		label.font = DesignManager.shared.tagFont?.withSize(15)
		label.textColor = DesignManager.shared.deepPurple
		label.lineBreakMode = .byWordWrapping
		label.numberOfLines = 0
		return label
	}()
	
	
	//MARK: - Init
	
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
		self.layoutMargins = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
		self.spacing = 5
		self.backgroundColor = DesignManager.shared.appBackgroundColor
	}
	
	//Setup of the stackViews ArrangedSubviews
	func setupSubviews() {
		//sectionTitle
		self.addArrangedSubview(sectionTitle)
		//Instructions
		self.addArrangedSubview(instructions)
	}
	
	//MARK: - Height Calculation
	
	// Dynamically calculates the height of the view based on the content of the labels
	func calculateHeight(for width: CGFloat) -> CGFloat {
		// Set the width of the stack view to the given width
		self.frame.size.width = width
		
		// Use systemLayoutSizeFitting to get the correct height
		let targetSize = CGSize(width: width, height: UIView.layoutFittingCompressedSize.height)
		let calculatedSize = self.systemLayoutSizeFitting(targetSize,
														  withHorizontalFittingPriority: .required,
														  verticalFittingPriority: .fittingSizeLevel)
		// Return the calculated height + 100 for padding
		return calculatedSize.height + 100
	}
	
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
