//
//  SecondViewController.swift
//  iBreak
//
//  Created by Kevin Peng on 2016-10-07.
//  Copyright © 2016 Rainboots. All rights reserved.
//

import UIKit
import AVFoundation

class SecondViewController: UIViewController, AVAudioPlayerDelegate {
  
  @IBOutlet weak var timeLabel: UILabel!
  var iterations = 1
  var stages = 0
  var seconds = 0
  var fractions = 0
  var timer = Timer()
  var timerOn = false
  var timeLabelString = ""
  var stageLabelString = ""
  var player: AVAudioPlayer?
  var isPlaying = false

  override func viewDidLoad() {
    super.viewDidLoad()
    UIApplication.shared.isIdleTimerDisabled = true
    timeLabel.text = "Ready!"
    // Do any additional setup after loading the view, typically from a nib.
    let url = Bundle.main.url(forResource: "glassSound", withExtension: "mp3")!
    do {
      player = try AVAudioPlayer(contentsOf: url)
      guard let player = player else { return }
      player.delegate = self
      player.prepareToPlay()
    } catch let error as NSError {
      print(error.description)
    }
    
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if !timerOn {
      timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(time), userInfo: nil, repeats: true)
      timerOn = true
    } else if timerOn {
      timer.invalidate()
      timerOn = false
    }
  }
  
  @IBOutlet weak var stage: UILabel!
  // changed!
  func time() {
    fractions += 1
    if fractions == 100 {
      seconds += 1
      fractions = 0
    }
    if iterations == 10 {
      player?.play()
      player?.play()
      player?.play()
    }
    switch (seconds, stages) {
    case (8, 0):
      stages += 1
      seconds = 0
      player?.play()
    case (32, 1):
      stages += 1
      seconds = 0
      player?.play()
    case (16, 2):
      stages = 0
      seconds = 0
      iterations += 1
      player?.play()
    default:
      break
    }
    
    let fractionsString = fractions > 9 ? "\(fractions)" : "0\(fractions)"
    let secondsString = seconds > 9 ? "\(seconds)" : " 0\(seconds)"
    let iterationString = "\(iterations)"
    
    switch stages {
    case 0:
      stageLabelString = "Inhale for \(8 - seconds) seconds..."
    case 1:
      stageLabelString = "Hold for \(32 - seconds) seconds..."
    case 2:
      stageLabelString = "Exhale for \(16 - seconds) seconds..."
    default:
      break
    }
    
    stage.text = stageLabelString
    timeLabelString = "\(iterationString):\(secondsString):\(fractionsString)"
    timeLabel.text = timeLabelString
  }

}

