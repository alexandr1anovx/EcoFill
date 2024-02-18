//
//  UserDataPreview.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 04.12.2023.
//

import SwiftUI

struct UserDataPreview: View {
  // MARK: - Properties
  @EnvironmentObject var authenticationVM: AuthenticationViewModel
  
  var body: some View {
    HStack {
      if let user = authenticationVM.currentUser {
        VStack(alignment: .leading, spacing:10) {
          Text(user.fullName)
            .font(.callout)
            .fontWeight(.medium)
            .fontDesign(.rounded)
            .foregroundStyle(.defaultReversed)
          
          Text(user.email)
            .font(.system(size: 15))
            .fontWeight(.medium)
            .fontDesign(.rounded)
            .foregroundStyle(.gray)
        }
        
        Spacer()
        
        HStack(spacing:10) {
          Image("city")
            .resizable()
            .frame(width: 25, height: 25)
          Text(user.city)
            .font(.callout)
            .fontWeight(.medium)
            .fontDesign(.rounded)
            .foregroundStyle(.defaultReversed)
        }
      }
    }
  }
}

#Preview {
  UserDataPreview()
    .environmentObject(AuthenticationViewModel())
}
