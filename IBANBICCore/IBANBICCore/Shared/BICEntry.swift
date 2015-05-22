//
//  BICEntry.swift
//  bicdata2sqlite
//
//  Created by Christian Lobach on 20/05/15.
//  Copyright (c) 2015 Christian Lobach. All rights reserved.
//

import Foundation

public struct BICEntry {

    public let BLZ: String
    public let name: String
    public let city: String
    public let shortName: String
    public let BIC: String?
    
    public let isDeletion: Bool
    
    public init(string: String) {
        BLZ = parseField(string, startIndex: 0, endIndex: 8)
        name = parseField(string, startIndex: 9, endIndex: 67)
        city = parseField(string, startIndex: 72, endIndex: 107)
        shortName = parseField(string, startIndex: 107, endIndex: 134)
        let parsedBIC = parseField(string, startIndex: 139, endIndex: 150)
        if count(parsedBIC) > 0 {
            BIC = parsedBIC
        } else {
            BIC = nil
        }
        
        isDeletion = parseField(string, startIndex: 159, endIndex: 160) == "1"

    }
    
}

private func parseField(input: String, #startIndex: Int, #endIndex: Int) -> String {
    let start = advance(input.startIndex, startIndex)
    let end = advance(input.startIndex, endIndex)    
    
    return input.substringWithRange(Range(start: start, end: end)).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
}

//MARK: CSV conversion
extension BICEntry {
    public static let csvHeaders = ["BLZ", "name", "city", "shortName", "BIC"]
    
    public init (fields: [String: String]) {
        BLZ = fields["BLZ"]!
        name = fields["name"]!
        city = fields["city"]!
        shortName = fields["shortName"]!
        BIC = fields["BIC"]!
        isDeletion = false
    }
    
    public func toCSV() -> String {
        return "\(BLZ);\(name);\(city);\(shortName);\(BIC!)"
    }
}