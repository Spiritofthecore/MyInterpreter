//
//  TextCellBuilder.swift
//  MyInterpreter
//
//  Created by HoangCuong on 1/12/20.
//  Copyright © 2020 Tom. All rights reserved.
//

import UIKit

class TextCellBuilder: MessageLogCellBuilder {
    
    var cellComponent: CellComponent = TextComponent()

    func estimateFrame(text: String, viewWidth: CGFloat) -> CGRect {
        let sizeToFit = CGSize(width: viewWidth * 2 / 3, height: CGFloat.greatestFiniteMagnitude)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: sizeToFit, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], context: nil)
    }

    func buildRightCell(text: String, viewWidth: CGFloat) {
        guard let cellComponent = cellComponent as? TextComponent else {
            return
        }
        cellComponent.messageText!.text = text
        let estimatedFrame = estimateFrame(text: text, viewWidth: viewWidth)
        cellComponent.messageText!.frame = CGRect(x: viewWidth - estimatedFrame.width - 16 - 16, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
        cellComponent.messageBubbleView!.frame = CGRect(x: viewWidth - estimatedFrame.width - 16 - 8 - 16, y: 0, width: estimatedFrame.width + 16 + 8, height: estimatedFrame.height + 20)
        cellComponent.messageText!.textColor = .white
        cellComponent.messageBubbleView!.backgroundColor = .black
    }
    
    func addGradientEffect(color1: CGColor, color2: CGColor) {
        
    }
    
    func addOpponentReadMarker() {
        
    }
    
    func buildLeftCell(text: String, viewWidth: CGFloat) {
        guard let cellComponent = cellComponent as? TextComponent else {
            return
        }
        cellComponent.messageText!.text = text
        let estimatedFrame = estimateFrame(text: text, viewWidth: viewWidth)
        cellComponent.messageText!.frame = CGRect(x: 48 + 8, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
        cellComponent.messageBubbleView!.frame = CGRect(x: 48 , y: 0, width: estimatedFrame.width + 16 + 8, height: estimatedFrame.height + 20)
        cellComponent.messageText!.textColor = .black
        cellComponent.messageBubbleView!.backgroundColor = .lightGray
    }
    
    func addTextView() {
        guard let cellComponent = cellComponent as? TextComponent else {
            return
        }
        cellComponent.messageBubbleView = UIView()
        cellComponent.messageBubbleView!.backgroundColor = UIColor(white: 0.95, alpha: 1)
        cellComponent.messageBubbleView!.layer.cornerRadius = 15
        cellComponent.messageBubbleView!.layer.masksToBounds = true
        cellComponent.messageText = UITextView()
        cellComponent.messageText!.font = .systemFont(ofSize: 16)
        cellComponent.messageText!.textAlignment = .left
        cellComponent.messageText!.backgroundColor = .clear
        cellComponent.addSubview(cellComponent.messageBubbleView!)
        cellComponent.addSubview(cellComponent.messageText!)
    }
}
