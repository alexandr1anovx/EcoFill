//
//  String+Ext.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 05.12.2023.
//

import Foundation
import RegexBuilder

extension String {
  var isValidEmail: Bool {
      let emailRegex = Regex {
          OneOrMore {
              CharacterClass(
                  .anyOf("._%+-"),
                  ("A"..."Z"),
                  ("0"..."9"),
                  ("a"..."z")
              )
          }
          "@"
          OneOrMore {
              CharacterClass(
                  .anyOf("-"),
                  ("A"..."Z"),
                  ("a"..."z"),
                  ("0"..."9")
              )
          }
          "."
          Repeat(2...64) {
              CharacterClass(
                  ("A"..."Z"),
                  ("a"..."z")
              )
          }
      }
      return self.wholeMatch(of: emailRegex) != nil
  }
  
  var isValidPhoneNumber: Bool {
    let phoneRegex = Regex {
      /^/
      Optionally(.anyOf("+"))
      Optionally(.anyOf("("))
      Repeat(count: 3) {
        ("0"..."9")
      }
      Optionally(.anyOf(")"))
      Optionally {
        CharacterClass(
          .anyOf("-."),
          .whitespace
        )
      }
      Repeat(count: 3) {
        ("0"..."9")
      }
      Optionally {
        CharacterClass(
          .anyOf("-."),
          .whitespace
        )
      }
      Repeat(4...6) {
        ("0"..."9")
      }
      /$/
    }
    return self.wholeMatch(of: phoneRegex) != nil
  }
}
