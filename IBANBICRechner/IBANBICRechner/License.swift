//
//  License.swift
//  IBANBICRechner
//
//  Created by Christian Lobach on 23/05/15.
//  Copyright (c) 2015 Christian Lobach. All rights reserved.
//

import UIKit

struct License {
    var name: String
    var licenseText: String
    
    init(name: String, licenseText: String) {
        self.name = name
        self.licenseText = licenseText
    }
}
