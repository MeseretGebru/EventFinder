//
//  EventsCollectionViewCell.swift
//  EventFinderForFamilies
//
//  Created by C4Q on 5/23/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    var spacing = 16 //Use this for even spacing
    
    lazy var eventImageView: UIImageView = {
        var pImageView = UIImageView()
        pImageView.image = #imageLiteral(resourceName: "Active") //place holder image
        //pImageView.isUserInteractionEnabled = true
        pImageView.contentMode = .scaleAspectFill
        pImageView.backgroundColor = .clear
        return pImageView
    }()
    
    lazy var eventNameLable: UILabel = {
        let label = UILabel()
        label.text = "Swimming"
        label.textAlignment = .center
        //label.backgroundColor = Stylesheet.Colors.LightBlue
        return label
    }()
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutIfNeeded()
        self.layer.borderColor = Stylesheet.Colors.Lapislazuli.cgColor
        self.layer.borderWidth = 3.0
        self.layer.cornerRadius = 10
        //self.favoriteImageView.layer.cornerRadius = favoriteImageView.frame.width / 2
        self.eventImageView.layer.masksToBounds = true
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        backgroundColor = UIColor.white
        self.layer.borderWidth = 2
        self.layer.borderColor = Stylesheet.Colors.LightBlue.cgColor
        setupViews()
    }
    
    private func setupViews() {
        setupFavoriteImageView()
    }
    
    private func setupFavoriteImageView() {
        contentView.addSubview(eventImageView)
        contentView.addSubview(eventNameLable)
        eventImageView.snp.makeConstraints { (make) -> Void in
           // make.edges.equalTo(contentView)
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            eventImageView.clipsToBounds = true
        }
        eventNameLable.snp.makeConstraints { (make) in
            make.top.equalTo(eventImageView.snp.bottom)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(self.snp.height).multipliedBy(0.15)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
}
