//
//  WidgetsTools.swift
//  PetoiSerialSwift
//
//  Created by Orlando Chen on 2021/3/29.
//

import Foundation
import UIKit

class WidgetTools
{
    static func underline(label: UILabel)
    {
        if let text = label.text {
            let attributedString =
                NSAttributedString(string: text,
                                   attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
            label.attributedText = attributedString
        }
    }
}
