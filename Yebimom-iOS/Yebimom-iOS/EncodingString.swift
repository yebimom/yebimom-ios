//
//  EncodingString.swift
//  Yebimom-iOS
//
//  Created by wikibootup on 6/19/15.
//  Copyright (c) 2015 wikibootup. All rights reserved.
//

import UIKit

func stringToUTF16String (stringaDaConvertire stringa: String) -> String {
    
    let encodedData = stringa.dataUsingEncoding(NSUTF16StringEncoding)!
    let attributedOptions = [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType]
    let attributedString = NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil, error: nil)!
    //println(attributedString.string)
    return attributedString.string
}
