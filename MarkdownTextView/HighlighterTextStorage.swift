//
//  RegularExpressionTextStorage.swift
//  MarkdownTextView
//
//  Created by Indragie on 4/28/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

import UIKit

/**
*  Text storage with support for automatically highlighting text
*  as it changes.
*/
open class HighlighterTextStorage: NSTextStorage {
    fileprivate let backingStore: NSMutableAttributedString
    fileprivate var highlighters = [HighlighterType]()
    
    /// Default attributes to use for styling text.
    open var defaultAttributes: [String: AnyObject] = [
        convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
    ] {
        didSet { editedAll(.editedAttributes) }
    }
    
    // MARK: API
    
    /**
    Adds a highlighter to use for highlighting text.
    
    Highlighters are invoked in the order in which they are added.
    
    :param: highlighter The highlighter to add.
    */
    open func addHighlighter(_ highlighter: HighlighterType) {
        highlighters.append(highlighter)
        editedAll(.editedAttributes)
    }
    
    // MARK: Initialization
    
    public override init() {
        backingStore = NSMutableAttributedString(string: "", attributes: convertToOptionalNSAttributedStringKeyDictionary(defaultAttributes))
        super.init()
    }

    required public init?(coder aDecoder: NSCoder) {
        backingStore = NSMutableAttributedString(string: "", attributes: convertToOptionalNSAttributedStringKeyDictionary(defaultAttributes))
        super.init(coder: aDecoder)
    }
    
    // MARK: NSTextStorage
    
    open override var string: String {
        return backingStore.string
    }
    
    open override func attributes(at location: Int, effectiveRange range: NSRangePointer?) -> [NSAttributedString.Key : Any] {
        return backingStore.attributes(at: location, effectiveRange: range)
    }
    
    open override func replaceCharacters(in range: NSRange, with attrString: NSAttributedString) {
        backingStore.replaceCharacters(in: range, with: attrString)
        edited(.editedCharacters, range: range, changeInLength: attrString.length - range.length)
    }
    
    open override func setAttributes(_ attrs: [NSAttributedString.Key : Any]?, range: NSRange) {
// Local variable inserted by Swift 4.2 migrator.
let attrs = convertFromOptionalNSAttributedStringKeyDictionary(attrs)

        backingStore.setAttributes(convertToOptionalNSAttributedStringKeyDictionary(attrs), range: range)
        edited(.editedAttributes, range: range, changeInLength: 0)
    }
    
    open override func processEditing() {
        // This is inefficient but necessary because certain
        // edits can cause formatting changes that span beyond
        // line or paragraph boundaries. This should be alright
        // for small amounts of text (which is the use case that
        // this was designed for), but would need to be optimized
        // for any kind of heavy editing.
        highlightRange(NSRange(location: 0, length: (string as NSString).length))
        super.processEditing()
    }
    
    fileprivate func editedAll(_ actions: NSTextStorage.EditActions) {
        edited(actions, range: NSRange(location: 0, length: backingStore.length), changeInLength: 0)
    }
    
    fileprivate func highlightRange(_ range: NSRange) {
        backingStore.beginEditing()
        setAttributes(convertToOptionalNSAttributedStringKeyDictionary(defaultAttributes), range: range)
        let attrString = backingStore.attributedSubstring(from: range).mutableCopy() as! NSMutableAttributedString
        for highlighter in highlighters {
            highlighter.highlightAttributedString(attrString)
        }
        replaceCharacters(in: range, with: attrString)
        backingStore.endEditing()
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromOptionalNSAttributedStringKeyDictionary(_ input: [NSAttributedString.Key: Any]?) -> [String: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKeyDictionary(_ input: [NSAttributedString.Key: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}
