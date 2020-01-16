//
//  IndicatorCellBuilder.swift
//  MyInterpreter
//
//  Created by HoangCuong on 1/14/20.
//  Copyright © 2020 Tom. All rights reserved.
//

import UIKit

class IndicatorCellBuilder: MessageLogCellBuilder {
    var cellComponent: CellComponent = IndicatiorComponent()
    
    func addGradientEffect(color1: CGColor, color2: CGColor) { }
    
    func addOpponentReadMarker() { }
    
    func addAvatarImage() {
        cellComponent.oponentAvatar = UIImageView()
        cellComponent.oponentAvatar!.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cellComponent.addSubview(cellComponent.oponentAvatar!)
        cellComponent.oponentAvatar!.translatesAutoresizingMaskIntoConstraints = false

        cellComponent.oponentAvatar!.leftAnchor.constraint(equalTo: cellComponent.leftAnchor, constant: 8).isActive = true
        cellComponent.oponentAvatar!.widthAnchor.constraint(equalToConstant: 30).isActive = true
        cellComponent.oponentAvatar!.heightAnchor.constraint(equalToConstant: 30).isActive = true
        cellComponent.oponentAvatar!.bottomAnchor.constraint(equalTo: cellComponent.bottomAnchor).isActive = true
    }
    
    func addIndicatorView() {
        guard let cellComponent = cellComponent as? IndicatiorComponent else {
            return
        }
        cellComponent.spinner = UIActivityIndicatorView()
        cellComponent.addSubview(cellComponent.spinner!)
    }
    
    
    
    func buildRightCell(viewSize: CGSize) {
        guard let cellComponent = cellComponent as? IndicatiorComponent else {
            return
        }
        cellComponent.spinner!.isHidden = false
        cellComponent.spinner!.translatesAutoresizingMaskIntoConstraints = false
        cellComponent.spinner!.topAnchor.constraint(equalTo: cellComponent.topAnchor).isActive = true
        cellComponent.spinner!.bottomAnchor.constraint(equalTo: cellComponent.bottomAnchor).isActive = true
        cellComponent.spinner!.leftAnchor.constraint(equalTo: cellComponent.leftAnchor).isActive = true
        cellComponent.spinner!.rightAnchor.constraint(equalTo: cellComponent.rightAnchor).isActive = true
        cellComponent.spinner!.startAnimating()
     }
     
    func buildLeftCell(viewWidth: CGFloat) {
        guard let cellComponent = cellComponent as? IndicatiorComponent else {
            return
        }
        cellComponent.spinner!.isHidden = false
        cellComponent.spinner!.translatesAutoresizingMaskIntoConstraints = false
        cellComponent.spinner!.topAnchor.constraint(equalTo: cellComponent.topAnchor).isActive = true
        cellComponent.spinner!.bottomAnchor.constraint(equalTo: cellComponent.bottomAnchor).isActive = true
        cellComponent.spinner!.leftAnchor.constraint(equalTo: cellComponent.leftAnchor, constant: 10).isActive = true
        cellComponent.spinner!.rightAnchor.constraint(equalTo: cellComponent.rightAnchor).isActive = true
        cellComponent.spinner!.startAnimating()
     }
    
    
}
