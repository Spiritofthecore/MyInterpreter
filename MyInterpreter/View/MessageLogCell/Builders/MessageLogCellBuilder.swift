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
    mutating func getProduct() -> CellComponent {
        let product = self.cellComponent
        self.reset()
        return product
    }
    mutating func reset() {
        cellComponent = CellComponent()
    }
    
    func addAvatarImage(image: UIImage) {
        cellComponent.oponentAvatar = UIImageView(image: image)
        cellComponent.oponentAvatar!.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cellComponent.addSubview(cellComponent.oponentAvatar!)
        cellComponent.oponentAvatar!.translatesAutoresizingMaskIntoConstraints = false
        
        cellComponent.oponentAvatar!.leftAnchor.constraint(equalTo: cellComponent.leftAnchor, constant: 8).isActive = true
        cellComponent.oponentAvatar!.widthAnchor.constraint(equalToConstant: 30).isActive = true
        cellComponent.oponentAvatar!.heightAnchor.constraint(equalToConstant: 30).isActive = true
        cellComponent.oponentAvatar!.bottomAnchor.constraint(equalTo: cellComponent.bottomAnchor).isActive = true
    }
    // Text Cell implements
    func addBubleView() { }
    func addMessageTextView() { }
    
    // Image Cell Implement
    func addImageView() { }
    
    // Video Cell Implements
    
    // Audio Cell Implements
}
