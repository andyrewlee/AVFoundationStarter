//
//  ViewController.swift
//  AVFoundationStarter
//
//  Created by Jae Hoon Lee on 5/4/15.
//  Copyright (c) 2015 Jae Hoon Lee. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    func newVideoCaptureSession() -> AVCaptureSession? {
        
        let videoCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        var error: NSError?
        
        let videoInput: AVCaptureDeviceInput? = AVCaptureDeviceInput(device: videoCamera, error: &error)
        
        if videoInput == nil {
            println("Fail to create input device")
            return nil
        } else {
            let captureSession = AVCaptureSession()
            captureSession.addInput(videoInput)
            
            return captureSession
        }
    }
    
    func addPreviewLayerForSession(session: AVCaptureSession) {
        let rootLayer = self.view.layer
        
        let layer = AVCaptureVideoPreviewLayer(session: session)
        layer.frame = rootLayer.bounds
        
        rootLayer.addSublayer(layer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captureSession = newVideoCaptureSession()
        addPreviewLayerForSession(captureSession)
        
        captureSession.startRunning()
    }
    
}

