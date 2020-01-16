//
//  BaseCell.swift
//  MyInterpreter
//
//  Created by HoangCuong on 1/11/20.
//  Copyright © 2020 Tom. All rights reserved.
//

import UIKit
import AVKit

class BaseCell: UITableViewCell {
    var cellComponents = CellComponent()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() { }
}
