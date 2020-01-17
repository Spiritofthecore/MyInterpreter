//
//  TextComponent.swift
//  MyInterpreter
//
//  Created by HoangCuong on 1/15/20.
//  Copyright © 2020 Tom. All rights reserved.
//

import UIKit

class TextComponent: CellComponent {
    var messageText: UITextView?
    var messageBubbleView: UIView?
    
    override func reset() {
        super.reset()
        messageText?.removeFromSuperview()
        messageText = nil
        messageBubbleView?.removeFromSuperview()
        messageBubbleView = nil
    }
}
