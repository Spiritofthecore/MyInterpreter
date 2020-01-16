//
//  IndicatorComponent.swift
//  MyInterpreter
//
//  Created by HoangCuong on 1/15/20.
//  Copyright © 2020 Tom. All rights reserved.
//

import UIKit

class IndicatiorComponent: CellComponent {
    var spinner: UIActivityIndicatorView?
    
    override func reset() {
        super.reset()
        spinner = nil
    }
}
