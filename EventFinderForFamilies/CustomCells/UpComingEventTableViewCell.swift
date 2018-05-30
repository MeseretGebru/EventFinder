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

    lazy var eventName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.backgroundColor = Stylesheet.Colors.LightBlue
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    lazy var eventAddress: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .right
        label.backgroundColor = Stylesheet.Colors.Mandarin
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    lazy var venue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .right
        label.backgroundColor = Stylesheet.Colors.LightGrey
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "EventCell")
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(eventName)
        eventName.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top).offset(4)
            make.centerX.equalTo(snp.centerX)
            
        addSubview(venue)
        venue.snp.makeConstraints({ (make) in
            make.top.equalTo(eventName.snp.bottom)
            make.trailing.equalTo(snp.trailing)
            })
        addSubview(eventAddress)
        eventAddress.snp.makeConstraints({ (make) in
            make.top.equalTo(venue.snp.bottom)
            make.trailing.equalTo(snp.trailing)
            })
        }
    }
    
}
