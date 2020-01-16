//
//  AudioComponent.swift
//  MyInterpreter
//
//  Created by HoangCuong on 1/15/20.
//  Copyright © 2020 Tom. All rights reserved.
//

import UIKit
import AVKit

class AudioComponent: CellComponent {
    var audioPlayer: AVAudioPlayer?
    
    override func reset() {
        super.reset()
        audioPlayer = nil
    }
}
