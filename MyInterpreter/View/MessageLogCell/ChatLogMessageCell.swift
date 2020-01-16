//
//  ChatLogMessageCell.swift
//  MyInterpreter
//
//  Created by Macbook on 6/16/19.
//  Copyright © 2019 Tom. All rights reserved.
//

import UIKit

class ChatLogMessageCell: BaseCell {
    
    override func prepareForReuse() {
        self.cellComponents.reset()
    }
    
    override func setupViews() {
        super.setupViews()
        self.backgroundColor = .clear
    }
    
    func adjustLayout() {
        self.addSubview(cellComponents)
        cellComponents.translatesAutoresizingMaskIntoConstraints = false
        cellComponents.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        cellComponents.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        cellComponents.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        cellComponents.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
}
