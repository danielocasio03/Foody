//
//  CategoriesView.swift
//  Foody
//
//  Created by Daniel Efrain Ocasio on 9/6/24.
//

import Foundation
import UIKit

class CategoriesView: UIView {
	
	//MARK: - Declarations
	
	lazy var categoriesTitle: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = DesignManager.shared.sectionHeadingFont
		label.textColor = DesignManager.shared.deepPurple
		label.text = "Categories"
		
		return label
	}()
	
	//Collection view for the different categories of dishes
	lazy var categoriesCollectionView: UICollectionView = {
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CategoriesView.collectionLayoutSetup())
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.backgroundColor = .clear
		collectionView.isScrollEnabled = false
		return collectionView
	}()
	
	
	//MARK: - Overrides
	
	//Override Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		translatesAutoresizingMaskIntoConstraints = false
		setupView()
		
	}
	
	//MARK: - View Setup Functions
	
	func setupView() {
		//Categories Title Label
		self.addSubview(categoriesTitle)
		//Categories Collection View
		self.addSubview(categoriesCollectionView)
		
		NSLayoutConstraint.activate([
			//Categories Title Label
			categoriesTitle.topAnchor.constraint(equalTo: self.topAnchor),
			categoriesTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
			//Categories Collection View
			categoriesCollectionView.topAnchor.constraint(equalTo: categoriesTitle.bottomAnchor, constant: 10),
			categoriesCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
			categoriesCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
			categoriesCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
		])
		
	}
	
	//Bible collection view layout setup
	static func collectionLayoutSetup() -> UICollectionViewLayout {
		
		//Item
		let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)))
		item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 10, bottom: 12, trailing: 10)
		
		//Group
		let group = NSCollectionLayoutGroup.horizontal(
			layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.14)),
			subitems: [item]
		)
		
		//Sections
		let section = NSCollectionLayoutSection(group: group)
		
		return UICollectionViewCompositionalLayout(section: section)
		
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
}
