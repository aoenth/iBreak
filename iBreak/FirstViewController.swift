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
var songNumber: Int!


class FirstViewController: UIViewController, AVAudioPlayerDelegate {
    @IBOutlet weak var beginBtn: UIButton!
    @IBAction func beginPressed(_ sender: Any) {
        playSong()
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
    
    func playSong() {
        songNumber = Int(arc4random_uniform(3) + 1)
        if isPlaying {
            player?.pause()
            isPlaying = false
        } else {
            let url = Bundle.main.url(forResource: "眼保健操\(songNumber)", withExtension: "mp3")!
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
        beginBtn.setTitle(isPlaying ? "正在播放眼保健操\(songNumber)" : "已停止", for: UIControlState.normal)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        congratulationsMessage.text = "视力被保护!"
    }
    
}

