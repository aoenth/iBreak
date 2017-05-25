//
//  FirstViewController.swift
//  iBreak
//
//  Created by Kevin Peng on 2016-10-07.
//  Copyright © 2016 Rainboots. All rights reserved.
//

import UIKit
import AVFoundation

var player: AVAudioPlayer?
var isPlaying = false
var songNumber = ""


class FirstViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBAction func song1(_ sender: Any) {
        playSong(song: 1)
    }
    
    @IBAction func song2(_ sender: Any) {
        playSong(song: 2)
    }
    @IBAction func song3(_ sender: Any) {
        playSong(song: 3)
    }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if isPlaying {
//            player?.pause()
//            isPlaying = false
//        } else {
//            player?.play()
//            isPlaying = true
//        }
//    }
    
    
    @IBOutlet weak var congratulationsMessage: UILabel!
    
    func playSong(song: Int) {
        songNumber = "\(song)"
        if isPlaying {
            player?.pause()
            isPlaying = false
        } else {
            let url = Bundle.main.url(forResource: "眼保健操\(song)", withExtension: "mp3")!
            do {
                player = try AVAudioPlayer(contentsOf: url)
                guard let player = player else { return }
                player.delegate = self
                player.prepareToPlay()
            } catch let error as NSError {
                print(error.description)
            }
            player?.play()
            isPlaying = true
        }
        updateLabel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = true

    }
    
    func updateLabel() {
        congratulationsMessage.text = isPlaying ? "正在播放眼保健操\(songNumber)" : "已停止"
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        congratulationsMessage.text = "视力被保护!"
    }
    
}

