//
//  MarkdownSuperscriptHighlighter.swift
//  MarkdownTextView
//
//  Created by Indragie on 4/29/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

import UIKit

/**
*  Highlights super^script in Markdown text (unofficial extension)
*/
public final class MarkdownSuperscriptHighlighter: HighlighterType {
    fileprivate static let SuperscriptRegex = regexFromPattern("(\\^+)(?:(?:[^\\^\\s\\(][^\\^\\s]*)|(?:\\([^\n\r\\)]+\\)))")
    fileprivate let fontSizeRatio: CGFloat
    
    /**
    Creates a new instance of the receiver.
    
    :param: fontSizeRatio Ratio to multiply the original font
    size by to calculate the superscript font size.
    
    :returns: An initialized instance of the receiver.
    */
    public init(fontSizeRatio: CGFloat = 0.7) {
        self.fontSizeRatio = fontSizeRatio
    }
    
    // MARK: HighlighterType
    
    public func highlightAttributedString(_ attributedString: NSMutableAttributedString) {
        var previousRange: NSRange?
        var level: Int = 0
        
        enumerateMatches(type(of: self).SuperscriptRegex, string: attributedString.string) {
            level += $0.range(at: 1).length
            let textRange = $0.range
            let attributes = convertFromNSAttributedStringKeyDictionary(attributedString.attributes(at: textRange.location, effectiveRange: nil)) 
            
            let isConsecutiveRange: Bool = {
                if let previousRange = previousRange, NSMaxRange(previousRange) == textRange.location {
                    return true
                }
                return false
            }()
            if isConsecutiveRange {
                level += 1
            }
            
            attributedString.addAttributes(convertToNSAttributedStringKeyDictionary(superscriptAttributes(attributes as TextAttributes, level: level, ratio: self.fontSizeRatio)), range: textRange)
            previousRange = textRange
            
            if !isConsecutiveRange {
                level = 0
            }
        }
    }
}

private func superscriptAttributes(_ attributes: TextAttributes, level: Int, ratio: CGFloat) -> TextAttributes {
    if let font = attributes[convertFromNSAttributedStringKey(NSAttributedString.Key.font)] as? UIFont {
        let adjustedFont = UIFont(descriptor: font.fontDescriptor, size: font.pointSize * ratio)
        return [
            kCTSuperscriptAttributeName as String: level as AnyObject,
            convertFromNSAttributedStringKey(NSAttributedString.Key.font): adjustedFont
        ]
    }
    return [:]
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKeyDictionary(_ input: [NSAttributedString.Key: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToNSAttributedStringKeyDictionary(_ input: [String: Any]) -> [NSAttributedString.Key: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
	return input.rawValue
}
