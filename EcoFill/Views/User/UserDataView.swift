//
//  UserDataPreview.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 04.12.2023.
//

import SwiftUI

struct UserDataView: View {
  @EnvironmentObject var authenticationVM: AuthenticationViewModel
  
  var body: some View {
    if let user = authenticationVM.currentUser {
      HStack {
        VStack(alignment: .leading, spacing: 8) {
          
          Text(user.fullName)
            .font(.lexendBody)
            .foregroundStyle(.cmReversed)
          Row(img: .mail, text: user.email)
            .lineLimit(2)
        }
        
        Spacer()
        
        Row(img: .location, text: user.city)
      }
      .padding(.top, 30)
      .padding(.horizontal, 20)
      .padding(.bottom, 20)
      
    } else {
      Text("Server error.")
        .font(.lexendHeadline)
    }
  }
}
