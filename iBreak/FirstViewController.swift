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


class FirstViewController: UIViewController, AVAudioPlayerDelegate {
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if isPlaying {
      player?.pause()
      isPlaying = false
    } else {
      player?.play()
      isPlaying = true
    }
  }
  
  
  @IBOutlet weak var congratulationsMessage: UILabel!
  
  

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    congratulationsMessage.isHidden = true
    let url = Bundle.main.url(forResource: "eye_exercise", withExtension: "mp3")!
    do {
      player = try AVAudioPlayer(contentsOf: url)
      guard let player = player else { return }
      player.delegate = self
      player.prepareToPlay()
    } catch let error as NSError {
      print(error.description)
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    congratulationsMessage.isHidden = false
  }

}

