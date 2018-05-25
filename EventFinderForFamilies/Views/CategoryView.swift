//
//  EventView.swift
//  EventFinderForFamilies
//
//  Created by C4Q on 5/23/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class CategoryView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.yellow //
        cv.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "EventsCell")
        cv.setContentCompressionResistancePriority(UILayoutPriority(249), for: .vertical)
        return cv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit(){
        self.backgroundColor = .green
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.snp.edges)
    }
  }
}
