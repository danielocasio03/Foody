//
//  CategoryScreenView.swift
//  Foody
//
//  Created by Daniel Efrain Ocasio on 9/6/24.
//

import Foundation
import UIKit

class CategoryScreenView: UIView {
	
	//MARK: - Declarations
	
	//MARK: - Init and Lifecycle
	
	//Override Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupView()
		
	}
	
	
	//MARK: -  View Setup Methods
	
	
	//General setup of the view
	func setupView() {
		//General View setup
		self.translatesAutoresizingMaskIntoConstraints = false
		self.backgroundColor = DesignManager.shared.appBackgroundColor
	}

	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
