//
//  IBANConverter.swift
//  IBANBICCore
//
//  Created by Christian Lobach on 23/05/15.
//  Copyright (c) 2015 Christian Lobach. All rights reserved.
//

import Foundation

public class IBANConverter: NSObject {

    public class func calculateIBAN(#BLZ: String, account: String) -> String {
        
        var paddingAmount = (18 - count(account) - count(BLZ))
        var padding = ""
        for _ in 1...paddingAmount {
            padding += "0"
        }
        
        let calculationBase = (BLZ + padding + account + "131400")

        
        let firstGroup = calculationBase.substringToIndex(advance(calculationBase.startIndex, 9))
        let firstModuloResult = firstGroup.toInt()! % 97
        let numbersToTakeInStep2 = firstModuloResult > 9 ? 7 : 8
        
        let secondRange = Range<String.Index>(start: advance(calculationBase.startIndex, 9), end: advance(calculationBase.startIndex, 9 + numbersToTakeInStep2))
        let secondGroup = String(firstModuloResult) + calculationBase.substringWithRange(secondRange)
        let secondModuloResult = secondGroup.toInt()! % 97
        let numbersToTakeInStep3 = secondModuloResult > 9 ? 7 : 8
        
        let thirdRange = Range<String.Index>(start: advance(calculationBase.startIndex, 9 +  numbersToTakeInStep2 ), end: advance(calculationBase.startIndex, 9 + numbersToTakeInStep2 + numbersToTakeInStep3))
        let thirdGroup = String(secondModuloResult) + calculationBase.substringWithRange(thirdRange)
        let thirdModuloResult = thirdGroup.toInt()! % 97
        
        var finalModulo = thirdModuloResult
        
        // TODO: check if 4th step is necessary
        let fourthRange = Range<String.Index>(start: advance(calculationBase.startIndex, 9 + numbersToTakeInStep2 + numbersToTakeInStep3 ), end: calculationBase.endIndex)
        let fourthSubstring = calculationBase.substringWithRange(fourthRange)
        
        if (count(fourthSubstring) > 0) {
            let fourthGroup = String(thirdModuloResult) + fourthSubstring
            let fourthModuloResult = fourthGroup.toInt()! % 97
            finalModulo = fourthModuloResult
        }        

        var checksum = String(98 - finalModulo)
        if count(checksum) == 1 {
            checksum = "0" + checksum
        }
        
        let IBAN = "DE" + String(checksum) + BLZ + padding + account
        return IBAN
    }
    
    
}
