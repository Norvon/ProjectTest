//
//  RecordViewController.swift
//  Recordings-MVC
//
//  Created by nor on 2020/8/4.
//  Copyright © 2020 Norvon. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController {

    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var stopoButton: UIButton!
    
    var audioRecorder: Recorder?
    var folder: Folder? = nil
    var recording = Recording(name: "", uuid: UUID())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timeLabel.text = timeString(0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        audioRecorder = folder?.store?.fileURL(for: recording).flatMap {
            url in
            Recorder(url: url) {[weak self] (time) in
                if let t = time {
                    self?.timeLabel.text = timeString(t)
                } else {
                    self?.dismiss(animated: true)
                }
            }
        }
        if audioRecorder == nil {
            dismiss(animated: true)
        }
    }
    
    @IBAction func stop(_ sender: Any) {
        audioRecorder?.stop()
        modalTextAlert(title: .saveRecording, accept: .save, placeholder: .nameForRecording) { (string) in
            if let title = string {
                self.recording.setName(title)
                self.folder?.add(self.recording)
            } else {
                self.recording.deleted()
            }
            self.dismiss(animated: true)
        }
    }
}

fileprivate extension String {
    static let saveRecording = NSLocalizedString("保存录音", comment: "录音保存对话框标题")
    static let save = NSLocalizedString("保存", comment: "确认用于录音保存对话框的按钮文本")
    static let nameForRecording = NSLocalizedString("录音名称", comment: "录音名称文本字段的占位符")
}
