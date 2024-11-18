//
//  EmojiOnlyTextField.swift
//  oneone2
//
//  Created by 이윤주 on 11/18/24.
//

import Foundation
import UIKit
class EmojiOnlyTextField:UITextField{
    override var textInputMode: UITextInputMode? {
           for mode in UITextInputMode.activeInputModes {
               if mode.primaryLanguage == "emoji" {
                   return mode
               }
           }
           return nil
       }
}
