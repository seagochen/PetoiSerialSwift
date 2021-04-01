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
    
    static func underline(textfield: UITextField, color: UIColor)
    {
        let underLine = UIView.init(frame: CGRect.init(x: 0, y: textfield.height - 2, width: textfield.width, height: 2))
        underLine.backgroundColor = color
        textfield.addSubview(underLine)
        textfield.borderStyle = .none
    }
    
    static func roundCorner(button: UIButton)
    {
        button.layer.borderWidth = 1
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
    }
    
    static func roundCorner(textView: UITextView, boardColor: UIColor)
    {
        textView.layer.borderColor = ColorConverter.convert(color: boardColor)
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 5
        textView.layer.masksToBounds = true
    }
    
    static func transparent(textView: UITextView, alpha: Float32)
    {
        textView.layer.backgroundColor = ColorConverter.convert(color: UIColor.clear)
    }
}
