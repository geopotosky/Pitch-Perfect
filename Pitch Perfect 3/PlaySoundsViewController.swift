//
//  PlaySoundsViewController.swift
//  Pitch Perfect 3
//
//  Created by George Potosky on 3/27/15.
//  Copyright (c) 2015 GeoWorld. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    
    // Class Global variables
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    var audioPlayerNode = AVAudioPlayerNode()       //<- Make Pitch player Global to fix overlap issue
    var audioReverbPlayer = AVAudioPlayerNode()     //<- Make Reverb player Global
    
    
    // FUNCTION: Override View Load
    // Load variables
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine.attachNode(audioPlayerNode)    //<- Move the new audio node here to fix audio overlap issue
        audioEngine.attachNode(audioReverbPlayer)  //<- Attach audioReverbPlayer in this function
        
        
    }
    
    
    // FUNCTION: Override memory warning
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    // FUNCTION: Button Action - Stop all audio players
    
    @IBAction func stopAudio(sender: UIButton) {
        
        //stop ALL audio players when stop button is tapped
        audioPlayer.stop()
        audioPlayerNode.stop()
        audioReverbPlayer.stop()
    }
    
    
    // FUNCTION: Button Action - Play audio slooooowly
    
    @IBAction func playSlowAudio(sender: UIButton) {
        
        //stop both audio players
        audioPlayer.stop()
        audioPlayerNode.stop()
        audioReverbPlayer.stop()
        
        audioPlayer.currentTime = 0.0          //<- Play audio from the beginning
        audioPlayer.rate = 0.5                 //<- Change the audio speed (1.0 is normal)
        audioPlayer.play()                     //<- Play audio with speed change
    }
    
    
    // FUNCTION: Button Action - Play audio fast
    
    @IBAction func playFastAudio(sender: UIButton) {
        
        //stop both audio players        
        audioPlayer.stop()
        audioPlayerNode.stop()
        audioReverbPlayer.stop()
        
        audioPlayer.currentTime = 0.0          //<- Play audio from the beginning
        audioPlayer.rate = 2.0                 //<- Change the audio speed (1.0 is normal)
        audioPlayer.play()                     //<- Play audio with speed change
    }
    
    
    // FUNCTION: Button Action to call function to play audio with "chipmunk" pitch change
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        
        audioPlayerNode.stop()                 //<- Stop the pitch audio
        playAudioWithVariablePitch(1000)       //<- Set audio pitch (0 is normal)
    }
    
    
    // FUNCTION: Button Action to call function to play audio with "Darth Vader" pitch effect
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        
        audioPlayerNode.stop()                 //<- Stop the pitch audio
        playAudioWithVariablePitch(-1000)      //<- Set audio pitch (0 is normal)
    }
    
    
    // FUNCTION: Button Action to call function to play audio with "Ghostly" reverb effect
    
    @IBAction func playGhostAudio(sender: UIButton) {
        
        audioReverbPlayer.stop()               //<- Stop the reverb audio
        playAudioWithReverb(70.0)              //<- Set audio reverb to 70
    }
    
    
    // FUNCTION: Play Audio with Pitch Changes
    
    func playAudioWithVariablePitch(pitch: Float){
        
        // Stop and reset the audioEngine before changing the pitch
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        // Set audio based on pitch setting
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()                 //<- Play audio with pitch change
    }
    
    
    // FUNCTION: Play Audio with Reverb Effect (ghostly sound)
    
    func playAudioWithReverb(reverb: Float){
        
        // Stop and reset the audioEngine before changing the delay
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        // set reverb mix rate
        var changeReverbEffect = AVAudioUnitReverb()
        changeReverbEffect.wetDryMix = reverb
        audioEngine.attachNode(changeReverbEffect)
        
        audioEngine.connect(audioReverbPlayer, to: changeReverbEffect, format: nil)
        audioEngine.connect(changeReverbEffect, to: audioEngine.outputNode, format: nil)
        audioReverbPlayer.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioReverbPlayer.play()                 //<- Play audio with delay change
    }
    
    
}
