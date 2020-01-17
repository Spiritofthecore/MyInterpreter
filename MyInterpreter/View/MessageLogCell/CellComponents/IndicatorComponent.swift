//
//  IndicatorComponent.swift
//  MyInterpreter
//
//  Created by HoangCuong on 1/15/20.
//  Copyright © 2020 Tom. All rights reserved.
//

import UIKit

class IndicatorComponent: CellComponent {
    var spinner: UIActivityIndicatorView?
    var messageBubbleView: UIView?
    
    override func reset() {
        super.reset()
        spinner?.removeFromSuperview()
        spinner = nil
        messageBubbleView?.removeFromSuperview()
        messageBubbleView = nil
    }
}
