//
//  MapTableViewCell.swift
//  EventFinderForFamilies
//
//  Created by C4Q on 6/1/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import MapKit
import SnapKit
class MapTableViewCell: UITableViewCell {

        lazy var mapV: MKMapView = {
            let mv = MKMapView()
            mv.clipsToBounds = true
            return mv
        }()
        
        lazy var directionsButton: UIButton = {
            let button = UIButton()
            button.setTitle("Get Directions", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor(displayP3Red: 247 / 255, green: 104 / 255, blue: 69 / 255, alpha: 1)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
            return button
        }()
        
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: "MapCell")
            setUpView()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        func setUpView() {
            setupDirectonsButton()
            setUpMap()
            
        }
        
        func setUpMap() {
            addSubview(mapV)
            mapV.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(safeAreaLayoutGuide.snp.top)
                make.bottom.equalTo(directionsButton.snp.top).offset(-10)
                make.left.equalTo(safeAreaLayoutGuide).offset(5)
                make.right.equalTo(safeAreaLayoutGuide).offset(-5)
                make.centerX.equalTo(self.snp.centerX)
            }
        }
        
        func setupDirectonsButton() {
            addSubview(directionsButton)
            directionsButton.snp.makeConstraints { (make) in
                make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
                make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
                make.width.equalTo(safeAreaLayoutGuide.snp.width)
    
            }
        }
        
        
}
