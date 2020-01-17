//
//  IndicatorCellBuilder.swift
//  MyInterpreter
//
//  Created by HoangCuong on 1/14/20.
//  Copyright © 2020 Tom. All rights reserved.
//

import UIKit

class IndicatorCellBuilder: MessageLogCellBuilder {
    var cellComponent: CellComponent = IndicatorComponent()
    
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
        guard let cellComponent = cellComponent as? IndicatorComponent else {
            return
        }
        cellComponent.spinner = UIActivityIndicatorView()
        cellComponent.addSubview(cellComponent.spinner!)
    }
    
    func addBubleView() {
        guard let cellComponent = cellComponent as? IndicatorComponent else {
          return
        }
        cellComponent.messageBubbleView = UIView()
        cellComponent.messageBubbleView!.layer.cornerRadius = 15
        cellComponent.messageBubbleView!.layer.masksToBounds = true
        cellComponent.addSubview(cellComponent.messageBubbleView!)
        cellComponent.oponentAvatar?.bottomAnchor.constraint(equalTo: cellComponent.messageBubbleView!.bottomAnchor).isActive = true
    }
    
    func buildRightCell(viewSize: CGSize) {
        guard let cellComponent = cellComponent as? IndicatorComponent else {
            return
        }
        cellComponent.messageBubbleView!.translatesAutoresizingMaskIntoConstraints = false
        cellComponent.messageBubbleView!.heightAnchor.constraint(equalToConstant: 100).isActive = true
        cellComponent.messageBubbleView!.bottomAnchor.constraint(equalTo: cellComponent.bottomAnchor).isActive = true
        cellComponent.messageBubbleView!.leftAnchor.constraint(equalTo: cellComponent.leftAnchor).isActive = true
        cellComponent.messageBubbleView!.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        cellComponent.spinner!.translatesAutoresizingMaskIntoConstraints = false
        cellComponent.spinner!.topAnchor.constraint(equalTo: cellComponent.messageBubbleView!.topAnchor).isActive = true
        cellComponent.spinner!.bottomAnchor.constraint(equalTo: cellComponent.messageBubbleView!.bottomAnchor).isActive = true
        cellComponent.spinner!.leftAnchor.constraint(equalTo: cellComponent.messageBubbleView!.leftAnchor).isActive = true
        cellComponent.spinner!.rightAnchor.constraint(equalTo: cellComponent.messageBubbleView!.rightAnchor).isActive = true
        cellComponent.spinner!.startAnimating()
        
        cellComponent.messageBubbleView!.backgroundColor = .black
     }
     
    func buildLeftCell(viewWidth: CGFloat) {
        guard let cellComponent = cellComponent as? IndicatorComponent else {
            return
        }
        cellComponent.spinner!.isHidden = false
        cellComponent.spinner!.translatesAutoresizingMaskIntoConstraints = false
        cellComponent.spinner!.topAnchor.constraint(equalTo: cellComponent.topAnchor).isActive = true
        cellComponent.spinner!.bottomAnchor.constraint(equalTo: cellComponent.bottomAnchor).isActive = true
        cellComponent.spinner!.leftAnchor.constraint(equalTo: cellComponent.leftAnchor, constant: 10).isActive = true
        cellComponent.spinner!.rightAnchor.constraint(equalTo: cellComponent.rightAnchor).isActive = true
        cellComponent.spinner!.startAnimating()
        
        cellComponent.messageBubbleView!.backgroundColor = .lightGray
     }
    
    
}
