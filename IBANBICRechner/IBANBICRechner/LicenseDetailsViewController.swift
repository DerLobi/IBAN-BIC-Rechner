//
//  LicenseDetailsViewController.swift
//  IBANBICRechner
//
//  Created by Christian Lobach on 24/05/15.
//  Copyright (c) 2015 Christian Lobach. All rights reserved.
//

import UIKit

class LicenseDetailsViewController: UIViewController {

    var license: License?
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = license?.name
        textView.text = license?.licenseText
    }

    
}
