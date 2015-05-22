//
//  InputFileConverter.swift
//  IBANBICCore
//
//  Created by Christian Lobach on 22/05/15.
//  Copyright (c) 2015 Christian Lobach. All rights reserved.
//

import Foundation

public enum InputFileConverterErrorCode: Int {
    case InputFilePathInvalid = 0
    case OutputFilePathInvalid = 1
}

public let InputFileConverterErrorDomain = "InputFileConverterErrorDomain"

public class InputFileConverter: NSObject {
    
    public class func convert(#inputFile: String, outputFile: String, error: NSErrorPointer) -> Bool {
        let inputURL = NSURL(fileURLWithPath: inputFile)
        let outputURL = NSURL(fileURLWithPath: outputFile)
        
        // TODO: handle invalid URLs, nonexistant paths
        
        var localError: NSError? = nil
        
        if let inputURL = inputURL {
          
            if let outputURL = outputURL {
                
            } else {
                localError = NSError(domain: InputFileConverterErrorDomain, code: InputFileConverterErrorCode.OutputFilePathInvalid.rawValue, userInfo: [NSLocalizedDescriptionKey: "The  specified path for the output file is not valid"
                    ])
            }            
        } else {
            localError = NSError(domain: InputFileConverterErrorDomain, code: InputFileConverterErrorCode.InputFilePathInvalid.rawValue, userInfo: [NSLocalizedDescriptionKey: "The  specified path for the input file is not valid"
                ])
        }
        
        if let localError = localError {
            error.memory = localError
            return false
        }
        
        
        let data = NSData(contentsOfURL: inputURL!, options: nil, error: &localError)!

        if let localError = localError {
            error.memory = localError
            return false
        }
        
        let dataString = NSString(data: data, encoding: NSWindowsCP1252StringEncoding)
        
        var lines = dataString?.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet()) as! [String]
        
        lines = lines.filter({ line in
            return (count(line) > 0)
        })
        

        var entries = lines.map({ BICEntry(string: $0) }).filter({ entry in
            return (entry.isDeletion == false && entry.BIC != nil)
        })
        
        entries.sort { entry1, entry2 in
            return entry1.BLZ < entry1.BLZ
        }
        
        let csvEntries = entries.map({ $0.toCSV() })
        
        let entriesString =  join("\n", csvEntries)
        

        entriesString.writeToURL(outputURL!, atomically: true, encoding: NSUTF8StringEncoding, error: &localError)
        
        if let localError = localError {
            error.memory = localError
            return false
        }
        
        return true
    }
    
}
