//
//  tagView.swift
//  Foody
//
//  Created by Daniel Efrain Ocasio on 9/5/24.
//

import Foundation
import UIKit

class TagLabel: UIView  {
	
	//MARK: - Declarations
	
	//This is the label which holds the tag title
	lazy var labelName: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = DesignManager.shared.accentTextColor
		label.font = DesignManager.shared.tagFont
		
		return label
	}()
	
	//This is the UIImageView which holds the symbol for the tag
	lazy var tagSymbol: UIImageView = {
		
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.tintColor = DesignManager.shared.deepPurple
		image.contentMode = .scaleAspectFit
		
		return image
	}()
	
	//MARK: - Override Init
	
	init() {
		super.init(frame: .zero)
		
		setupView()
	}
	
	//MARK: - Setup Methods
	
	//General setup of the view
	func setupView() {
		//self setup
		self.translatesAutoresizingMaskIntoConstraints = false
		self.backgroundColor = .clear
		//Adding in subviews
		addSubview(tagSymbol)
		addSubview(labelName)
		
		NSLayoutConstraint.activate([
			//Tag Symbol
			tagSymbol.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			tagSymbol.centerYAnchor.constraint(equalTo: self.centerYAnchor),
			tagSymbol.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
			//Label Name
			labelName.leadingAnchor.constraint(equalTo: tagSymbol.trailingAnchor, constant: 10),
			labelName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
			
		])
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
