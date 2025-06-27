//
//  SupportViewModel.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 27.06.2025.
//

import Foundation

@MainActor
final class SupportViewModel: ObservableObject {
  @Published var email: String = ""
  @Published var message: String = ""
  @Published var isShownMessageSentAlert: Bool = false
  let sessionManager: SessionManager
  
  var isMessageCorrect: Bool {
    message.count > 10 && message.count <= 100
  }
  
  init(sessionManager: SessionManager) {
    self.sessionManager = sessionManager
  }
  
  func sendMessage() async {
    // Add functionality to save sent messages within each user model.
  }
  
  func retrieveUserEmail() {
    guard let user = sessionManager.currentUser else {
      print("⚠️ SupportViewModel: Fail to retrieve user!")
      return
    }
    email = user.email
  }
}
