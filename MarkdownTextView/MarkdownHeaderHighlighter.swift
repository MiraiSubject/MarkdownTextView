//
//  MarkdownHeaderHighlighter.swift
//  MarkdownTextView
//
//  Created by Indragie on 4/29/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

import UIKit

/**
*  Highlights atx-style Markdown headers.
*/
public final class MarkdownHeaderHighlighter: HighlighterType {
    // From markdown.pl v1.0.1 <http://daringfireball.net/projects/markdown/>
    fileprivate static let HeaderRegex = regexFromPattern("^(\\#{1,6})[ \t]*(?:.+?)[ \t]*\\#*\n+")
    fileprivate let attributes: MarkdownAttributes.HeaderAttributes
    
    /**
    Creates a new instance of the receiver.
    
    :param: attributes Attributes to apply to Markdown headers.
    
    :returns: An initialized instance of the receiver.
    */
    public init(attributes: MarkdownAttributes.HeaderAttributes) {
        self.attributes = attributes
    }
    
    // MARK: HighlighterType
    
    public func highlightAttributedString(_ attributedString: NSMutableAttributedString) {
        enumerateMatches(type(of: self).HeaderRegex, string: attributedString.string) {
            let level = $0.range(at: 1).length
            if let attributes = self.attributes.attributesForHeaderLevel(level) {
                attributedString.addAttributes(convertToNSAttributedStringKeyDictionary(attributes), range: $0.range)
            }
        }
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToNSAttributedStringKeyDictionary(_ input: [String: Any]) -> [NSAttributedString.Key: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
