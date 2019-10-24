//
//  MarkdownStrikethroughHighlighter.swift
//  MarkdownTextView
//
//  Created by Indragie on 4/29/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

import UIKit

/**
*  Highlights ~~strikethrough~~ in Markdown text (unofficial extension)
*/
public final class MarkdownStrikethroughHighlighter: HighlighterType {
    fileprivate static let StrikethroughRegex = regexFromPattern("(~~)(?=\\S)(.+?)(?<=\\S)\\1")
    fileprivate let attributes: TextAttributes?
    
    /**
    Creates a new instance of the receiver.
    
    :param: attributes Optional additional attributes to apply
    to strikethrough text.
    
    :returns: An initialized instance of the receiver.
    */
    public init(attributes: TextAttributes? = nil) {
        self.attributes = attributes
    }
    
    // MARK: HighlighterType
    
    public func highlightAttributedString(_ attributedString: NSMutableAttributedString) {
        enumerateMatches(type(of: self).StrikethroughRegex, string: attributedString.string) {
            var strikethroughAttributes: TextAttributes = [
                convertFromNSAttributedStringKey(NSAttributedString.Key.strikethroughStyle): NSUnderlineStyle.single.rawValue as AnyObject
            ]
            if let attributes = self.attributes {
                for (key, value) in attributes {
                    strikethroughAttributes[key] = value
                }
            }
            attributedString.addAttributes(convertToNSAttributedStringKeyDictionary(strikethroughAttributes), range: $0.range(at: 2))
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
