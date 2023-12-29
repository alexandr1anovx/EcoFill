//
//  UserDataPreview.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 04.12.2023.
//

import SwiftUI

struct UserDataPreview: View {
  @EnvironmentObject var authViewModel: AuthViewModel
  
  var body: some View {
    HStack {
      if let user = authViewModel.currentUser {
        VStack(alignment: .leading, spacing:15) {
          Text(user.fullName)
            .font(.system(size: 18,
                          weight: .medium,
                          design: .rounded))
            .foregroundStyle(.customSystemReversed)
          
          Text(user.email)
            .font(.system(size: 15,
                          weight: .medium,
                          design: .rounded))
            .foregroundStyle(.gray)
        }
        
        Spacer()
        
        Label(user.city, systemImage: "mappin")
          .font(.system(size: 15,
                        weight: .medium,
                        design: .rounded))
          .foregroundStyle(.customSystemReversed)
      }
    }
  }
}

//#Preview {
//  UserDataPreview()
//    .environmentObject(AuthViewModel())
//}
