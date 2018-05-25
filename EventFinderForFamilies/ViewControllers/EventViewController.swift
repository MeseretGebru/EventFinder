//
//  SearchViewController.swift
//  EventFinderForFamilies
//
//  Created by C4Q on 5/23/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class CategoryViewController: UIViewController {
    
    let categoryView = CategoryView()
    let cellSpacing: CGFloat = 5.0
    var categories = [Category](){
        didSet {
            categoryView.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryView.collectionView.dataSource = self
        categoryView.collectionView.delegate = self
        view.backgroundColor = .orange
        setupView()
        loadData()
    }

    func setupView(){
        view.addSubview(categoryView)
        categoryView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
    
    func loadData(){
        CategoryAPIClient.manager.getCategory(completionHandler: { (categoriesOnline) in
            self.categories = categoriesOnline
        }, errorHandler: {print($0)})
    }
    
}

extension CategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventsCell", for: indexPath) as! CategoryCollectionViewCell
        if indexPath.row % 2 == 0 {
            cell.eventNameLable.backgroundColor = Stylesheet.Colors.LightBlue
        } else {
            cell.eventNameLable.backgroundColor = Stylesheet.Colors.Mandarin
        }
        let cat = categories[indexPath.row]
        cell.eventNameLable.text = cat.name
        ImageService.manager.getImage(from: cat.photo.photo_link) { (imageOnline) in
            cell.eventImageView.image = imageOnline
        }
        cell.setNeedsLayout()
        return cell
    }
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numCells: CGFloat = 2
        let numSpaces: CGFloat = numCells + 1
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height / 3
        let cellWidth = (screenWidth - (cellSpacing * numSpaces)) / numCells
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: 0, right: cellSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let locationVC = LocationViewController()
    
    navigationController?.pushViewController(locationVC, animated: false)
    }
}
