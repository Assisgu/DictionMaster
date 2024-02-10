//
//  AudioManager.swift
//  DictionMaster
//
//  Created by Gustavo Assis on 07/02/24.
//

import Foundation
import AVFoundation

class AudioManager{
    var player: AVPlayer?
    
    func playSoundFromURL(url: URL){
      let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        player?.play()
    }
    
}
