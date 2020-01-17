//
//  BuildMessageLogCellDirector.swift
//  MyInterpreter
//
//  Created by HoangCuong on 1/12/20.
//  Copyright © 2020 Tom. All rights reserved.
//

import UIKit

class Director {
    private var builder: MessageLogCellBuilder?
    
    func getProduct() -> CellComponent {
        if let product = self.builder?.cellComponent {
            return product
        }
        return CellComponent()
    }

    func update(builder: MessageLogCellBuilder) {
        self.builder = builder
    }

    func buildLeftImageCell(image: UIImage, viewSize: CGSize, avatarImage: UIImage) {
        guard let builder = self.builder as? ImageCellBuilder else {
            return
        }
        builder.addAvatarImage(image: avatarImage)
        builder.addImageView(image: image)
        builder.buildLeftCell(image: image, viewSize: viewSize)
    }

    func buildRightImageCell(image: UIImage, viewSize: CGSize) {
        guard let builder = self.builder as? ImageCellBuilder else {
            return
        }
        builder.addImageView(image: image)
        builder.buildRightCell(image: image, viewSize: viewSize)
    }
    
    func buildLeftTextCell(text: String, viewWidth: CGFloat, avatarImage: UIImage) {
        guard let builder = self.builder as? TextCellBuilder else {
            return
        }
        builder.addAvatarImage(image: avatarImage)
        builder.addBubleView()
        builder.addTextView()
        builder.buildLeftCell(text: text, viewWidth: viewWidth)
    }
    
    func buildRightTextCell(text: String, viewWidth: CGFloat) {
        guard let builder = self.builder as? TextCellBuilder else {
            return
        }
        builder.addBubleView()
        builder.addTextView()
        builder.buildRightCell(text: text, viewWidth: viewWidth)
    }
    
    func buildRightLoadingCell(viewSize: CGSize) {
        guard let builder = self.builder as? IndicatorCellBuilder else {
            return
        }
        builder.addBubleView()
        builder.addIndicatorView()
        builder.buildRightCell(viewSize: viewSize)
    }
    
    func buildLeftLoadingCell(viewWidth: CGFloat, avatarImage: UIImage) {
        guard let builder = self.builder as? IndicatorCellBuilder else {
            return
        }
        builder.addAvatarImage(image: avatarImage)
        builder.addBubleView()
        builder.addIndicatorView()
        builder.buildLeftCell(viewWidth: viewWidth)
    }
}
