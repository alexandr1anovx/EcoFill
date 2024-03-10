//
//  UserDataPreview.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 04.12.2023.
//

import SwiftUI

struct UserDataPreview: View {
  
  @EnvironmentObject var authenticationVM: AuthenticationViewModel
  
  var body: some View {
    HStack {
      if let user = authenticationVM.currentUser {
        
        VStack(alignment: .leading, spacing: 15) {
          Text(user.fullName)
            .font(.lexendBody)
            .foregroundStyle(.cmReversed)
          
          Text(user.email)
            .font(.lexendCallout)
            .foregroundStyle(.gray)
          
          HStack(spacing: 8) {
            Image("city")
              .resizable()
              .frame(width: 28, height: 28)
            Text(user.city)
              .font(.lexendFootnote)
              .foregroundStyle(.gray)
          }
        }
      }
      Spacer()
    }
  }
}

#Preview {
  UserDataPreview()
    .environmentObject(AuthenticationViewModel())
}
