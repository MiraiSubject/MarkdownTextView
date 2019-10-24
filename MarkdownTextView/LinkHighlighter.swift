//
//  LinkHighlighter.swift
//  MarkdownTextView
//
//  Created by Indragie on 4/29/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

import UIKit

/**
*  Highlights URLs.
*/
public final class LinkHighlighter: HighlighterType {
    fileprivate var detector: NSDataDetector!
    
    public init() throws {
        detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
    }
    
    // MARK: HighlighterType
    
    public func highlightAttributedString(_ attributedString: NSMutableAttributedString) {
        enumerateMatches(detector, string: attributedString.string) {
            if let URL = $0.url {
                let linkAttributes = [
                    convertFromNSAttributedStringKey(NSAttributedString.Key.link): URL
                ]
                attributedString.addAttributes(convertToNSAttributedStringKeyDictionary(linkAttributes), range: $0.range)
            }
        }
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToNSAttributedStringKeyDictionary(_ input: [String: Any]) -> [NSAttributedString.Key: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
