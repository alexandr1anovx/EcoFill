//
//  SupportViewModel.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 27.06.2025.
//

import Foundation

@MainActor
@Observable
final class SupportViewModel {
  var showAlert = false
  var email = ""
  var message = ""
  var isMessageCorrect: Bool {
    message.count > 10 && message.count <= 100
  }
  
  func sendMessage() async {
    showAlert = true
  }
}
