//
//  MessageLogCellBuilder.swift
//  MyInterpreter
//
//  Created by HoangCuong on 1/12/20.
//  Copyright © 2020 Tom. All rights reserved.
//

import UIKit

protocol MessageLogCellBuilder {
    var cellComponent: CellComponent { get set }
    func addGradientEffect(color1: CGColor, color2: CGColor)
    func addOpponentReadMarker()
}

extension MessageLogCellBuilder {
    mutating func reset() {
        cellComponent.reset()
    }
    
    func addAvatarImage(image: UIImage) {
        cellComponent.oponentAvatar = UIImageView(image: image)
        cellComponent.oponentAvatar!.backgroundColor = .clear
        cellComponent.oponentAvatar!.layer.cornerRadius = 15
        cellComponent.oponentAvatar!.layer.masksToBounds = true
        cellComponent.addSubview(cellComponent.oponentAvatar!)
        cellComponent.oponentAvatar!.translatesAutoresizingMaskIntoConstraints = false
        
        cellComponent.oponentAvatar!.leftAnchor.constraint(equalTo: cellComponent.leftAnchor, constant: 8).isActive = true
        cellComponent.oponentAvatar!.widthAnchor.constraint(equalToConstant: 30).isActive = true
        cellComponent.oponentAvatar!.heightAnchor.constraint(equalToConstant: 30).isActive = true
        let constraint = cellComponent.oponentAvatar!.bottomAnchor.constraint(equalTo: cellComponent.bottomAnchor)
        constraint.isActive = true
        constraint.priority = UILayoutPriority(rawValue: 250)
    }
    // Text Cell implements
    func addBubleView() { }
    func addMessageTextView() { }
    
    // Image Cell Implement
    func addImageView() { }
    
    // Indicator Cell Implements
    
    
    // Video Cell Implements
    
    // Audio Cell Implements
}
