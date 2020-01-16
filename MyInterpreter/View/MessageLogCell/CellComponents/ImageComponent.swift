//
//  ImageComponent.swift
//  MyInterpreter
//
//  Created by HoangCuong on 1/15/20.
//  Copyright © 2020 Tom. All rights reserved.
//

import UIKit

class ImageComponent: CellComponent {
    var imageMessageView: UIImageView?
    
    override func reset() {
        super.reset()
        imageMessageView = nil
    }
}
