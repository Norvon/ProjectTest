//
//  Recorder.swift
//  Recordings-MVC
//
//  Created by nor on 2020/8/4.
//  Copyright © 2020 Norvon. All rights reserved.
//

import Foundation
import AVFoundation

final class Recorder: NSObject, AVAudioRecorderDelegate {
    private var audioRecorder: AVAudioRecorder?
    private var timer: Timer?
    private var update: (TimeInterval?) -> ()
    let url: URL
    
    init?(url: URL, update: @escaping (TimeInterval?) -> ()) {
        self.update = update
        self.url = url
        
        super.init()
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord)
            try AVAudioSession.sharedInstance().setActive(true)
            AVAudioSession.sharedInstance().requestRecordPermission() { allowed in
                if allowed { // 是否有权限
                    self.start(url)
                } else {
                    self.update(nil)
                }
            }
        } catch {
            return nil
        }
    }
    
    private func start(_ url: URL) {
        let settings: [String: Any] = [
            AVFormatIDKey: kAudioFormatMPEG4AAC,
            AVSampleRateKey: 44100.0 as Float,
            AVNumberOfChannelsKey: 1
        ]
        if let recorder = try? AVAudioRecorder(url: url, settings: settings) {
            recorder.delegate = self
            audioRecorder = recorder
            recorder.record()
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                self.update(self.audioRecorder?.currentTime)
            }
        } else {
            update(nil)
        }
    }
    
    func stop() {
        audioRecorder?.stop()
        timer?.invalidate()
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            stop()
        } else {
            update(nil)
        }
    }
}

