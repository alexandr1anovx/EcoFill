//
//  ValidationServiceProtocol.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 13.06.2025.
//

import Foundation

protocol ValidationServiceProtocol {
  func isValid(fullName: String) -> Bool
  func isValid(email: String) -> Bool
  func isValid(password: String) -> Bool
}
