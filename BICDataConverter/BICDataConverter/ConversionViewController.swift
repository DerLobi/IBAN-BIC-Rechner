//
//  ViewController.swift
//  BICDataConverter
//
//  Created by Christian Lobach on 22/05/15.
//  Copyright (c) 2015 Christian Lobach. All rights reserved.
//

import Cocoa
import IBANBICCore

class ConversionViewController: NSViewController {
    
    dynamic var inputPath: String = ""
    dynamic var outputPath: String = ""
    
    @IBOutlet weak var activityIndicator: NSProgressIndicator!
    @IBOutlet weak var convertButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
    @IBAction func convertClicked(sender: AnyObject) {
        
        var error: NSError? = nil
        activityIndicator.startAnimation(sender)
        convertButton.enabled = false
        
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_UTILITY.value), 0)) { [weak self] in
            let success = InputFileConverter.convert(inputFile: self!.inputPath, outputFile: self!.outputPath, error: &error)

        
            dispatch_async(dispatch_get_main_queue()) {
                
                self!.activityIndicator.stopAnimation(sender)
                self!.convertButton.enabled = true
                if !success, let error = error {
                    let alert = NSAlert(error: error)
                    alert.runModal()
                }
            }
            
            
        }
        
        
        
        
        
    }
    
}

