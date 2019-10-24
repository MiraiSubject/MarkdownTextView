//
//  MarkdownAttributes.swift
//  MarkdownTextView
//
//  Created by Indragie on 4/28/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

import UIKit

/**
*  Encapsulates the attributes to use for styling various types
*  of Markdown elements.
*/
public struct MarkdownAttributes {
    public var defaultAttributes: TextAttributes = [
        convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
    ]
    
    public var strongAttributes: TextAttributes?
    public var emphasisAttributes: TextAttributes?
    
    public struct HeaderAttributes {
        public var h1Attributes: TextAttributes? = [
            convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        ]
        
        public var h2Attributes: TextAttributes? = [
            convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        ]
        
        public var h3Attributes: TextAttributes? = [
            convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        ]
        
        public var h4Attributes: TextAttributes? = [
            convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
        ]
        
        public var h5Attributes: TextAttributes? = [
            convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
        ]
        
        public var h6Attributes: TextAttributes? = [
            convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
        ]
        
        func attributesForHeaderLevel(_ level: Int) -> TextAttributes? {
            switch level {
            case 1: return h1Attributes
            case 2: return h2Attributes
            case 3: return h3Attributes
            case 4: return h4Attributes
            case 5: return h5Attributes
            case 6: return h6Attributes
            default: return nil
            }
        }
        
        public init() {}
    }
    
    public var headerAttributes: HeaderAttributes? = HeaderAttributes()
    
    fileprivate static let MonospaceFont: UIFont = {
        let bodyFont = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        let size = bodyFont.pointSize
        return UIFont(name: "Menlo", size: size) ?? UIFont(name: "Courier", size: size) ?? bodyFont
    }()
    
    public var codeBlockAttributes: TextAttributes? = [
        convertFromNSAttributedStringKey(NSAttributedString.Key.font): MarkdownAttributes.MonospaceFont
    ]
    
    public var inlineCodeAttributes: TextAttributes? = [
        convertFromNSAttributedStringKey(NSAttributedString.Key.font): MarkdownAttributes.MonospaceFont
    ]
    
    public var blockQuoteAttributes: TextAttributes? = [
        convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor): UIColor.darkGray
    ]
    
    public var orderedListAttributes: TextAttributes? = [
        convertFromNSAttributedStringKey(NSAttributedString.Key.font): fontWithTraits(.traitBold, font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body))
    ]
    
    public var orderedListItemAttributes: TextAttributes? = [
        convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body),
        convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor): UIColor.darkGray
    ]
    
    public var unorderedListAttributes: TextAttributes? = [
        convertFromNSAttributedStringKey(NSAttributedString.Key.font): fontWithTraits(.traitBold, font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body))
    ]
    
    public var unorderedListItemAttributes: TextAttributes? = [
        convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body),
        convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor): UIColor.darkGray
    ]
    
    public init() {}
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
	return input.rawValue
}
