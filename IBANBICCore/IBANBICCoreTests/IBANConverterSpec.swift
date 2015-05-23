//
//  IBANConverterSpec.swift
//  IBANBICCore
//
//  Created by Christian Lobach on 23/05/15.
//  Copyright (c) 2015 Christian Lobach. All rights reserved.
//

import IBANBICCore
import Nimble
import Quick
import XCTest

class IBANConverterSpec: QuickSpec {

    override func spec() {
        
        describe("IBANConverter") {
            
            describe("-IBAN(blz:account:)") {
                
                it("calculates the correct IBAN") {
                    let iban = IBANConverter.calculateIBAN(BLZ:"50010517", account: "648489890")
                    expect(iban).to(equal("DE12500105170648489890"))

                }
                
            }
            
        }
        
    }
}
