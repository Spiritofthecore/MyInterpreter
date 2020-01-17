//
//  ImageCellBuilder.swift
//  MyInterpreter
//
//  Created by HoangCuong on 1/12/20.
//  Copyright © 2020 Tom. All rights reserved.
//

import UIKit

class ImageCellBuilder: MessageLogCellBuilder {
    func addGradientEffect(color1: CGColor, color2: CGColor) {
        return
    }
    
    func calculateFrame(image: UIImage, viewSize: CGSize) -> (CGFloat, CGSize) {
        let ratio = image.size.width / image.size.height
        let maxWidth = viewSize.width / 3 * 2
        let maxHeight = viewSize.height / 3
        return (ratio, CGSize(width: maxWidth, height: maxHeight))
    }
    
    var cellComponent: CellComponent = ImageComponent()

    func addOpponentReadMarker() {
        
    }
    
    func buildRightCell(image: UIImage, viewSize: CGSize) {
        guard let cellComponent = cellComponent as? ImageComponent else {
            return
        }
        let (ratio, maxSize) = calculateFrame(image: image, viewSize: viewSize)
        if ratio > 1.0 {
            cellComponent.imageMessageView!.frame = CGRect(x: viewSize.width - maxSize.width - 16, y: 0, width: maxSize.width, height: maxSize.width / ratio)
        } else {
            cellComponent.imageMessageView!.frame = CGRect(x: viewSize.width - maxSize.height * ratio - 16, y: 0, width: maxSize.height * ratio, height: maxSize.height)
        }
    }
    
    func buildLeftCell(image: UIImage, viewSize: CGSize) {
        guard let cellComponent = cellComponent as? ImageComponent else {
            return
        }
        let (ratio, maxSize) = calculateFrame(image: image, viewSize: viewSize)
        if ratio > 1.0 {
            cellComponent.imageMessageView!.frame = CGRect(x: 48, y: 0, width: maxSize.width, height: maxSize.width / ratio)
        } else {
            cellComponent.imageMessageView!.frame = CGRect(x: 48, y: 0, width: maxSize.height * ratio, height: maxSize.height)
        }
    }
    
    func addImageView(image: UIImage) {
        guard let cellComponent = cellComponent as? ImageComponent else {
            return
        }
        cellComponent.imageMessageView = UIImageView(image: image)
        cellComponent.addSubview(cellComponent.imageMessageView!)
        cellComponent.imageMessageView!.contentMode = .scaleAspectFit
        cellComponent.imageMessageView!.clipsToBounds = true
        cellComponent.imageMessageView!.layer.cornerRadius = 15
        cellComponent.oponentAvatar?.bottomAnchor.constraint(equalTo: cellComponent.imageMessageView!.bottomAnchor).isActive = true
    }
}
