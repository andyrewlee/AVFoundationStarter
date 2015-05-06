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
    
    // can receive data from input devices such as videoInput
    var captureSession: AVCaptureSession!
    
    // used to display a preview of the data that is coming in from captureSession's input device
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    func newVideoCaptureSession() -> AVCaptureSession? {
        
        // we need to pass in two arguments to create a videoInput
        // the first argument needs to be AVCaptureDevice!
        let videoCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        // the second argument needs to be NSErrorPointer
        var error: NSError?
        
        // now we pass in the two arguments to create a new instance of AVCaptureDeviceInput
        let videoInput: AVCaptureDeviceInput? = AVCaptureDeviceInput(device: videoCamera, error: &error)
        
        if videoInput == nil {
            println("Fail to create input device")
            return nil
        } else {
            // captureSession coordinates data from input devices to outputs
            let captureSession = AVCaptureSession()
            
            // we are going to ask for it to handle the data that comes in from the videoInput
            captureSession.addInput(videoInput)
            
            return captureSession
        }
    }
    
    func addPreviewLayerForSession(session: AVCaptureSession) {
        // all views are backed by a layer
        // we only use the layer for special circumstances like using it to create a preview layer
        let rootLayer = self.view.layer
        
        // create a preview layer that can display the video stream coming in from captureSession
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        
        // set its frame to be the same as rootLayer's frame to take up the whole screen
        previewLayer.frame = rootLayer.frame
        
        // add this previewLayer as a sub layer of rootLayer to display video stream
        rootLayer.addSublayer(previewLayer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captureSession = newVideoCaptureSession()
        
        // create a preview layer that will display the data that this captureSession gets
        addPreviewLayerForSession(captureSession)
        
        // start camera
        captureSession.startRunning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // after the view appears then start camera
        captureSession.startRunning()
    }
    
    override func viewDidDisappear(animated: Bool) {
        // stop camera then have the view disappear
        captureSession.stopRunning()
        super.viewDidDisappear(animated)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        // change the previewLayer's frame to match the frame of the new size after orientation change
        previewLayer.frame = CGRectMake(0, 0, size.width, size.height);
        
        // figure out the current orientation of the device
        let currentOrientation = UIDevice.currentDevice().orientation
        
        // create an instance of AVCaptureVideoOrientation
        let videoOrientation = AVCaptureVideoOrientation(rawValue: currentOrientation.rawValue)!
        
        // then tell the previewLayer how it should change itself
        self.previewLayer.connection.videoOrientation = videoOrientation
    }
}
