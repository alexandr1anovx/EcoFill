//
//  FeedbackScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 10.12.2023.
//

import SwiftUI

struct FeedbackScreen: View {
  @State private var email: String = ""
  @State private var message: String = ""
  
  var body: some View {
    NavigationStack {
      VStack(spacing:30) {
        CustomTextField(text: $email,title: "Email address",placeholder: "Write your email here.")
          .keyboardType(.emailAddress)
          .textInputAutocapitalization(.never)
          .autocorrectionDisabled(true)
        
        CustomTextField(text: $message,title: "Message", placeholder: "Write your feedback message here.")
        
        Button {
          // Send feedback action
        } label: {
          RoundedRectangle(cornerRadius:10)
            .fill(.customGreen)
            .frame(width: 160, height: 50)
            .overlay {
              Text("Send feedback")
                .foregroundStyle(.white).bold()
            }
        }
        .padding(.top,10)
        
        Spacer()
      }
      .padding(.horizontal)
      .padding(.vertical,30)
      .navigationTitle("Feedback")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

#Preview {
  FeedbackScreen()
}
