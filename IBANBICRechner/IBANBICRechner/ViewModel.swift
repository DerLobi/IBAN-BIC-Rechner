//
//  ViewModel.swift
//  IBANBICRechner
//
//  Created by Christian Lobach on 22/05/15.
//  Copyright (c) 2015 Christian Lobach. All rights reserved.
//

import RxSwift
import RxCocoa
import SwiftCSV
import IBANBICCore

class ViewModel: NSObject {
    
    
    var BLZ: Variable<String>
    var accountNumber: Variable<String>
    
    var IBAN: Variable<String>
    var BIC: Variable<String>
    
    var BICEntries: [BICEntry]?
    
    override init() {
        BLZ = Variable<String>()
        accountNumber = Variable<String>()

        IBAN = Variable<String>("")
        BIC = Variable<String>("")

        super.init()
        
        BLZ >- map({ [weak self] blz in
            
            if let BICEntries = self?.BICEntries {
                //TODO: load bic from array of entries
                return ""
            } else {
                return "-"
            }
        }) >- subscribeNext({ [weak self] bic in
            self!.BIC << bic
        })
        
        var subscription = combineLatest(BLZ, accountNumber, {
            return IBANfrom(blz: $0, accountNumber: $1)
        }) >- map({ $0  // If I leave this out, it crashes in `CombineLatestObserver`, no idea why
        }) >- subscribeNext({ [weak self] iban in
            self!.IBAN << iban
            })
        
        
    }
    
    func loadBICs() {
        
    }
    
    
}

private func IBANfrom(#blz: String, #accountNumber: String) -> String {
    return "\(blz) \(accountNumber)"
}

