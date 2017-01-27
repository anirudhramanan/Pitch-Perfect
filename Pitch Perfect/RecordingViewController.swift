//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Anirudh Ramanan on 24/01/17.
//  Copyright © 2017 Anirudh Ramanan. All rights reserved.
//

import UIKit
import AVFoundation

class RecordingViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var stopRecordButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    
    var audioRecorder : AVAudioRecorder!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.stopRecordButton.isEnabled = false
    }
    
    @IBAction func record(_ sender: Any) {
        updateUI(recording: true)
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: AVAudioSessionCategoryOptions.defaultToSpeaker)
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        updateUI(recording: false)
        audioRecorder.stop()
        
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: recorder.url)
        } else{
            showAlertView(title: "Warning!", message: "Unable to Record")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"{
            let playSoundViewController = segue.destination as! PlaySoundsViewController
            let audioUrl = sender as! URL
            playSoundViewController.recordedAudioURL = audioUrl
        }
    }
    
    func showAlertView(title:String, message:String){
        let alertController = UIAlertController(title:title, message:message, preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "OK", style : .cancel)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func updateUI(recording:Bool){
        recordingLabel.text = recording ? "Recording in Progress" : "Tap to Record"
        self.stopRecordButton.isEnabled = recording
        self.recordButton.isEnabled = !recording
    }
}
