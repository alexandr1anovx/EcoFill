//
//  UserDataPreview.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 04.12.2023.
//

import SwiftUI

struct UserDataPreview: View {
  @AppStorage("user") private var userData: Data?
  @EnvironmentObject var userViewModel: UserViewModel
  
  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 12) {
        
        Text(userViewModel.user.firstName)
          .font(.system(size: 22,
                        weight: .medium,
                        design: .rounded))
          .foregroundStyle(.customSystemReversed)
        
        Text(userViewModel.user.email)
          .font(.system(size: 18,
                        weight: .medium,
                        design: .rounded))
          .foregroundStyle(.gray)
      }
      
      Spacer()
      
      Label("Kyiv", systemImage: "mappin")
        .font(.system(size: 17,
                      weight: .medium,
                      design: .rounded))
        .foregroundStyle(.customSystemReversed)
        .symbolEffect(.pulse)
    }
  }
}

#Preview {
  UserDataPreview()
    .environmentObject(UserViewModel())
}
