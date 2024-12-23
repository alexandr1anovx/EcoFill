//
//  UIApplication+Extension.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 16.10.2024.
//

import UIKit

// Disables the keyboard when the user taps on any part of the screen.
extension UIApplication {
  func endEditing() {
    sendAction(#selector(UIResponder.resignFirstResponder),
               to: nil,
               from: nil,
               for: nil)
  }
}
