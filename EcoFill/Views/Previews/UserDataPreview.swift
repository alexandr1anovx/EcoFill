//
//  UserDataPreview.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 04.12.2023.
//

import SwiftUI

struct UserDataPreview: View {
  var body: some View {
    VStack(spacing: 20) {
      Image(systemName: "person.circle.fill")
        .resizable()
        .frame(width: 45, height: 45)
        .foregroundStyle(.customSystemReversed)
        .opacity(0.9)
      
      VStack(spacing: 10) {
        // Test name
        Text("Alexander")
          .font(.title2)
          .fontWeight(.semibold)
          .foregroundStyle(.customSystemReversed)
        
        // Test email
        Text("an4lex.gmail.com")
          .font(.callout)
          .fontWeight(.semibold)
          .foregroundStyle(.gray)
      }
    }
    .padding()
  }
}

#Preview {
  UserDataPreview()
}
