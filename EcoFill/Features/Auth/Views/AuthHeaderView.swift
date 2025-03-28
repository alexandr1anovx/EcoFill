//
//  AuthHeaderView.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 28.03.2025.
//

import SwiftUI

struct AuthHeaderView: View {
  
  enum AuthAction {
    case signIn
    case signUp
    
    var title: LocalizedStringKey {
      switch self {
      case .signIn: "sign_in_title"
      case .signUp: "sign_up_title"
      }
    }
    var subtitle: LocalizedStringKey {
      switch self {
      case .signIn: "sign_in_subtitle"
      case .signUp: "sign_up_subtitle"
      }
    }
  }
  
  
  let authAction: AuthAction
  
  init(for authAction: AuthAction) {
    self.authAction = authAction
  }
  
  var body: some View {
    HStack(alignment: .firstTextBaseline) {
      Text(authAction.title)
        .font(.headline)
        .fontWeight(.bold)
        .foregroundStyle(.primaryLabel)
      Text(authAction.subtitle)
        .font(.subheadline)
        .fontWeight(.medium)
        .foregroundStyle(.gray)
    }
  }
}

#Preview {
  AuthHeaderView(for: .signIn)
}
