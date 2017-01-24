//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Anirudh Ramanan on 24/01/17.
//  Copyright © 2017 Anirudh Ramanan. All rights reserved.
//

import UIKit

class RecordingViewController: UIViewController {

    @IBOutlet weak var stopRecordButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.stopRecordButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func record(_ sender: Any) {
        self.stopRecordButton.isEnabled = true
        self.recordButton.isEnabled = false
        self.view.backgroundColor = UIColor(red: 122/255, green: 129/255, blue: 255/255, alpha: 1)
    }

    @IBAction func stopRecording(_ sender: Any) {
        self.recordButton.isEnabled = true
        self.stopRecordButton.isEnabled = false
        self.view.backgroundColor = UIColor.white
    }
}

