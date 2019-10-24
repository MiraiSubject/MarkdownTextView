//
//  RegularExpressionHighlighter.swift
//  MarkdownTextView
//
//  Created by Indragie on 4/29/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

import UIKit

/**
*  Highlighter that uses a regular expression to match character
*  sequences to highlight.
*/
open class RegularExpressionHighlighter: HighlighterType {
    fileprivate let regularExpression: NSRegularExpression
    fileprivate let attributes: TextAttributes
    
    /**
    Creates a new instance of the receiver.
    
    :param: regularExpression The regular expression to use for
    matching text to highlight.
    :param: attributes        The attributes applied to matching
    text ranges.
    
    :returns: An initialized instance of the receiver.
    */
    public init(regularExpression: NSRegularExpression, attributes: TextAttributes) {
        self.regularExpression = regularExpression
        self.attributes = attributes
    }
    
    // MARK: HighlighterType
    
    open func highlightAttributedString(_ attributedString: NSMutableAttributedString) {
        enumerateMatches(regularExpression, string: attributedString.string) {
            attributedString.addAttributes(convertToNSAttributedStringKeyDictionary(self.attributes), range: $0.range)
        }
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToNSAttributedStringKeyDictionary(_ input: [String: Any]) -> [NSAttributedString.Key: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
