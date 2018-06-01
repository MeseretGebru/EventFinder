//
//  UpComingEventTableViewCell.swift
//  EventFinderForFamilies
//
//  Created by C4Q on 5/29/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class UpComingEventTableViewCell: UITableViewCell {

    lazy var eventImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Active")
        return image
    }()
    lazy var eventName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    lazy var venueName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(displayP3Red: 0.537, green: 0.537, blue: 0.537, alpha: 1)
        label.font.withSize(15)
        label.numberOfLines = 0
        return label
    }()
    
   
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "EventCell")
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
        
    private func setupViews() {
        let viewObjects = [eventImage, eventName, venueName] as! [UIView]
        viewObjects.forEach{addSubview($0)}
        
        eventImage.snp.makeConstraints { (image) in
            image.height.width.equalTo(90)
            image.top.leading.equalTo(5)
        }
        eventName.snp.makeConstraints { (label) in
            label.top.equalTo(5)
            label.leading.equalTo(self.eventImage.snp.trailing).offset(5)
            label.trailing.equalTo(self.contentView.snp.trailing).offset(-5)
        }
        venueName.snp.makeConstraints { (label) in
            label.top.equalTo(self.eventName.snp.bottom).offset(5)
            label.leading.equalTo(self.eventImage.snp.trailing).offset(5)
            label.trailing.equalTo(self.contentView.snp.trailing).offset(-5)
            label.bottom.equalTo(self.contentView.snp.bottom).offset(-5)
        }
        
    }
    
    //Cell configuration
    
    public func configureCell(event: Event) {
        self.eventName.text = event.name
        self.venueName.text = event.venue?.name
        self.eventImage.image = nil
        self.eventImage.kf.indicatorType = .activity
        if let photoLink = event.group?.photo?.photo_link {
            ImageService.manager.getImage(from: photoLink) { (imageOnline) in
                self.eventImage.image = imageOnline
            }
        } else {
            self.eventImage.image = #imageLiteral(resourceName: "Active")
        }
    }
}
