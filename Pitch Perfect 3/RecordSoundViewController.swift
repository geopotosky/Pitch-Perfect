//
//  RecordSoundViewController.swift
//  Pitch Perfect 3
//
//  Created by George Potosky on 3/27/15.
//  Copyright (c) 2015 GeoWorld. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {

    // Class global Outlet variables
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var tapToRecord: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var tapToPause: UILabel!
    @IBOutlet weak var recordingPaused: UILabel!
    
    // Class global variable
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    var pauseFlag: Int!
    
    // variable "pauseFlag" will be used as a flag by the PAUSE functionality exclusively
    // 0 = initialized recording
    // 1 = pause recording after initialization
    // 2 = continue recording but do not re-initialize (aka: start a new recording
    
    
    // FUNCTION: Called when view is loaded into memory (override set)
    override func viewDidLoad() {
    super.viewDidLoad()
    }

    
    // FUNCTION: Called when app receives memory warning (override set)
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    }

    
    // FUNCTION: Make visible the microphone and label
    //           Hide the stop button
    
    override func viewWillAppear(animated: Bool) {
    
    // Label viewing settings
    stopButton.hidden = true
    recordButton.enabled = true
    recordButton.enabled = true
    tapToRecord.hidden = false
    tapToPause.hidden = true
    recordingPaused.hidden = true
    recordingInProgress.hidden = true
    
    pauseFlag = 0                               //<- Set flag to init recording value
    }

    
    // FUNCTION: Button Action - Record Audio
    
    @IBAction func recordAudio(sender: UIButton) {
    
    if pauseFlag == 0 {                         //<- If mic is tapped for the first time in a new scene, initialize and start recording
    
    pauseFlag = 1                               //<- Set flag to move to pause method
    
    // Label viewing settings
    recordingInProgress.hidden = false
    recordingPaused.hidden = true
    stopButton.hidden = false
    recordButton.enabled = true
    tapToRecord.hidden = true
    tapToPause.hidden = false
    
    // Setup the audio file
    let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
    let currentDateTime = NSDate()
    let formatter = NSDateFormatter()
    formatter.dateFormat = "ddMMyyyy-HHmmss"
    let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
    let pathArray = [dirPath, recordingName]
    let filePath = NSURL.fileURLWithPathComponents(pathArray)
    
    var session = AVAudioSession.sharedInstance()
    session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
    
    audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
    audioRecorder.delegate = self
    audioRecorder.meteringEnabled = true;
    audioRecorder.prepareToRecord()
    audioRecorder.record()                     //<- start recorder after setting up recorder file
} else if pauseFlag == 1 {
    pauseFlag = 2                          //<- Set flag to move to record without initialization method (2)
    tapToRecord.hidden = false
    tapToPause.hidden = true
    recordingInProgress.hidden = true
    recordingPaused.hidden = false
    audioRecorder.pause()                  //<- Pause recorder
} else {
    pauseFlag = 1                          //<- Set flag to move to pause method (1)
    
    // Label viewing settings
    tapToRecord.hidden = true
    tapToPause.hidden = false
    recordingInProgress.hidden = false
    recordingPaused.hidden = true
    
    //<- start recorder after a pause
    audioRecorder.record()
        
    }
}

    
    // FUNCTON: Check to see if the audio is finished recording
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
    if (flag){
    
    recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent)      //<- Call the initialized variables with values
    self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
} else {
    
    // Label viewing settings
    recordButton.enabled = true
    stopButton.hidden = true
    tapToRecord.hidden = false
    
    }
}

    
    // FUNCTION: Prepare a recorded audio to be segued and open "Play Audio" screen
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == "stopRecording") {
    let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
    let data = sender as! RecordedAudio
    playSoundsVC.receivedAudio = data
    }
}
    
    
    // FUNCTION: Button Action - Stop the Recording with a button
    
    @IBAction func stopRecording(sender: UIButton) {
    
    recordingInProgress.hidden = true                        //<- Hide the current label
    audioRecorder.stop()                                     //<- Stop the recording
    
    // Change the speaker (make it LOUDER)
    var audioSession = AVAudioSession.sharedInstance()
    audioSession.setActive(false, error: nil)
    audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, withOptions: AVAudioSessionCategoryOptions.DefaultToSpeaker, error: nil)
    }




}

