//
//  UpComingEventView.swift
//  EventFinderForFamilies
//
//  Created by C4Q on 5/29/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class UpComingEventView: UIView {

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UpComingEventTableViewCell.self, forCellReuseIdentifier: "EventCell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUpViews(){
        
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.snp.edges)
        }
    }
}
