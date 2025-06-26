//
//  ValidationService.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 13.06.2025.
//

import Foundation

struct ValidationService {
  
  static func isValid(fullName: String) -> Bool {
    let regex = #"^[a-zA-Z-]+ ?.* [a-zA-Z-]+$"#
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    return predicate.evaluate(with: fullName)
  }
  
  static func isValid(email: String) -> Bool {
    let regex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,64}$"
    let predicate = NSPredicate(format: "SELF MATCHES[c] %@", regex)
    return predicate.evaluate(with: email)
  }
  
  static func isValid(password: String) -> Bool {
    let regex = #"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"#
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    return predicate.evaluate(with: password)
  }
}
