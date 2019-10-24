//
//  MarkdownLinkHighlighter.swift
//  MarkdownTextView
//
//  Created by Indragie on 4/29/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

import UIKit

/**
*  Highlights Markdown links (not including link references)
*/
public final class MarkdownLinkHighlighter: HighlighterType {
    // From markdown.pl v1.0.1 <http://daringfireball.net/projects/markdown/>
    fileprivate static let LinkRegex = regexFromPattern("\\[([^\\[]+)\\]\\([ \t]*<?(.*?)>?[ \t]*((['\"])(.*?)\\4)?\\)")
    
    // MARK: HighlighterType
    
    public func highlightAttributedString(_ attributedString: NSMutableAttributedString) {
        let string = attributedString.string
        enumerateMatches(type(of: self).LinkRegex, string: string) {
            let URLString = (string as NSString).substring(with: $0.range(at: 2))
            let linkAttributes = [
                convertFromNSAttributedStringKey(NSAttributedString.Key.link): URLString
            ]
            attributedString.addAttributes(convertToNSAttributedStringKeyDictionary(linkAttributes), range: $0.range)
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
