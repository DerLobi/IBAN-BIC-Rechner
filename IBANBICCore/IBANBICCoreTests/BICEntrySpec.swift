//
//  bicdata2sqliteTests.swift
//  bicdata2sqliteTests
//
//  Created by Christian Lobach on 21/05/15.
//  Copyright (c) 2015 Christian Lobach. All rights reserved.
//

import IBANBICCore
import XCTest
import Quick
import Nimble

class BICEntrySpec: QuickSpec {
    
    override func spec() {
        
        describe("BICEntry") {
         
            var fixtures: [AnyObject]!
            
            beforeSuite {
                let textFileURL = NSBundle(forClass: self.dynamicType).URLForResource("blz_input", withExtension: "txt")
                let fixturesString = NSString(contentsOfURL: textFileURL!, encoding: NSWindowsCP1252StringEncoding, error: nil)!
                fixtures = fixturesString.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
            }
            
            describe("-init(string:)") {
                
                it("parses a normal bank correctly") {
                    let input = fixtures[0] as! String
                    
                    let entry = BICEntry(string: input)
                    expect(entry.name).to(equal("Bundesbank"))
                    expect(entry.BLZ).to(equal("10000000"))
                    expect(entry.city).to(equal("Berlin"))
                    expect(entry.shortName).to(equal("BBk Berlin"))
                    expect(entry.BIC).to(equal("MARKDEF1100"))
                    expect(entry.isDeletion).to(beFalse())
                }

                it("parses a bank with umlauts correctly") {
                    let input = fixtures[1] as! String
                    
                    let entry = BICEntry(string: input)
                    expect(entry.name).to(equal("Sparkasse Düren"))
                    expect(entry.BLZ).to(equal("39550110"))
                    expect(entry.city).to(equal("Düren, Rheinl"))
                    expect(entry.shortName).to(equal("Sparkasse Düren"))
                    expect(entry.BIC).to(equal("SDUEDE33XXX"))
                    expect(entry.isDeletion).to(beFalse())
                }
        
                it("parses a deleted bank correctly") {
                    let input = fixtures[2] as! String
                    
                    let entry = BICEntry(string: input)
                    expect(entry.name).to(equal("Pax-Bank"))
                    expect(entry.BLZ).to(equal("10060198"))
                    expect(entry.city).to(equal("Berlin"))
                    expect(entry.shortName).to(equal("Pax-Bank Berlin"))
                    expect(entry.BIC).to(equal("GENODED1PA6"))
                    expect(entry.isDeletion).to(beTrue())
                }
                
                it("parses the correct lengths of all used fields") {
                    let input = fixtures[3] as! String
                    
                    let entry = BICEntry(string: input)
                    expect(entry.name).to(equal("NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN"))
                    expect(entry.BLZ).to(equal("88888888"))
                    expect(entry.city).to(equal("CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC"))
                    expect(entry.shortName).to(equal("SSSSSSSSSSSSSSSSSSSSSSSSSSS"))
                    expect(entry.BIC).to(equal("BICBICBIXXX"))
                    expect(entry.isDeletion).to(beTrue())
                }
            }
            
        }
        
    }
    
}
