//
//  VideoComponent.swift
//  MyInterpreter
//
//  Created by HoangCuong on 1/15/20.
//  Copyright © 2020 Tom. All rights reserved.
//

import UIKit
import AVKit

class VideoComponent: CellComponent {
    var videoPlayer: AVPlayer?
    
    override func reset() {
        super.reset()
        videoPlayer?.pause()
        videoPlayer?.seek(to: .zero)
        videoPlayer = nil
    }
}
