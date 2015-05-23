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
    var bankName: Variable<String>
    var city: Variable<String>
    
    
    private var BICEntries: [BICEntry]?
    
    override init() {
        BLZ = Variable<String>()
        accountNumber = Variable<String>()

        IBAN = Variable<String>("")
        BIC = Variable<String>("")

        bankName = Variable<String>("")
        city = Variable<String>("")

        super.init()
        
        var currentEntry = BLZ >- map { [weak self] blz -> BICEntry? in
            if let BICEntries = self?.BICEntries {
                var entries = BICEntries.filter({
                    $0.BLZ == blz
                })
                
                let entry = entries.first
                return entry
            }
            
            return nil
        }

        currentEntry
            >- map { $0?.BIC ?? "" }
            >- subscribeNext({ [weak self] bic in
            self!.BIC << bic
        })

        currentEntry
            >- map { $0?.shortName ?? "" }
            >- subscribeNext({ [weak self] name in
                self!.bankName << name
                })

        currentEntry
            >- map { $0?.city ?? "" }
            >- subscribeNext({ [weak self] city in
                self!.city << city
                })
        
        //TODO: calculate IBAN
        
        var subscription = combineLatest(BLZ >- filter({ count($0) == 8 }),
                                         accountNumber >- filter({ count($0) > 1 }),
            {
                return IBANConverter.calculateIBAN(BLZ: $0, account: $1) })
            >- map({ $0 })// If I leave this out, it crashes in `CombineLatestObserver`, no idea why
            >- subscribeNext({ [weak self] iban in
                self!.IBAN << iban
            })
        
        loadBICs()
        
    }
    
    func loadBICs() {
        let url = NSBundle.mainBundle().URLForResource("data", withExtension: "csv")
        if let url = url {
            let delimiter = NSCharacterSet(charactersInString: ";")
            var error: NSErrorPointer = nil
            if let csv = CSV(contentsOfURL: url, delimiter: delimiter, error: error) {

                BICEntries = csv.rows.map({ row in
                    return BICEntry(fields: row)
                })
                
            }
        }
    }
    
    
}

