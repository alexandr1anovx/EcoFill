//
//  ValidationService.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 13.06.2025.
//

import Foundation

final class ValidationService: ValidationServiceProtocol {
  
  // MARK: - Singleton

  static let shared = ValidationService()
  private init() {}
  
  // MARK: - Public Methods
  
  func isValid(fullName: String) -> Bool {
    let regex = #"^[a-zA-Z-]+ ?.* [a-zA-Z-]+$"#
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    return predicate.evaluate(with: fullName)
  }
  
  func isValid(email: String) -> Bool {
    let regex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,64}$"
    let predicate = NSPredicate(format: "SELF MATCHES[c] %@", regex)
    return predicate.evaluate(with: email)
  }
  
  func isValid(password: String) -> Bool {
    let regex = #"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"#
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    return predicate.evaluate(with: password)
  }
}
