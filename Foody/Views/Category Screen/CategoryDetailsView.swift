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
	
	//label holding the title for the category
	lazy var categoryTitle: UILabel = {
		let label = UILabel()
		label.text = "Dessert"
		label.font = DesignManager.shared.titleFont
		label.textColor = DesignManager.shared.offWhite.withAlphaComponent(0.75)
		return label
	}()
	
	//Label for holding the details/description of the category
	lazy var categoryDetail: UILabel = {
		let label = UILabel()
		label.text = "Vegetarianism is the practice of abstaining from the consumption of meat (red meat, poultry, seafood, and the flesh of any other animal), and may also include abstention from by-products of animal slaughter. Vegetarianism may be adopted for various reasons. Many people object to eating meat out of respect for sentient life. Such ethical motivations have been codified under various religious beliefs, as well as animal rights advocacy. Other motivations for vegetarianism are health-related, political, environmental, cultural, aesthetic, economic, or personal preference. There are variations of the diet as well: an ovo-lacto vegetarian diet includes both eggs and dairy products, an ovo-vegetarian diet includes eggs but not dairy products, and a lacto-vegetarian diet includes dairy products but not eggs. A vegan diet excludes all animal products, including eggs and dairy. Some vegans also avoid other animal products such as beeswax, leather or silk clothing, and goose-fat"
		label.font = DesignManager.shared.tagFont?.withSize(14)
		label.textColor = DesignManager.shared.offWhite.withAlphaComponent(0.75)
		label.lineBreakMode = .byWordWrapping
		label.numberOfLines = 7
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
	
	//General setup of the stack view (self)
	func setupStackView() {
		//General View setup
		self.translatesAutoresizingMaskIntoConstraints = false
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
		
		//Category Title
		self.addArrangedSubview(categoryTitle)
		//Category Detail
		self.addArrangedSubview(categoryDetail)


	}
	
	
	
	
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
	
