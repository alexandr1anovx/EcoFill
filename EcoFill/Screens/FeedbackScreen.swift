//
//  FeedbackScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 10.12.2023.
//

import SwiftUI

struct FeedbackScreen: View {
  @State private var email: String = ""
  @State private var feedbackMessage: String = ""
  
  var body: some View {
    NavigationStack {
      Form {
        Section{
          TextField("Електронна пошта", text: $email)
            .keyboardType(.emailAddress)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
        } header: {
          Text("Особисті дані")
        }
        
        Section{
          TextField("Сформулюйте свій відгук", text: $feedbackMessage)
            .submitLabel(.done)
        } footer: {
          Text("Щоб надіслати відгук, натисніть кнопку у верхньому правому куті.")
        }
      }
      .toolbar {
        ToolbarItem(placement: .confirmationAction) {
          Button("", systemImage: "paperplane") {
            // Send feedback action.
          }
        }
      }
      .navigationTitle("Відгук")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

#Preview {
  FeedbackScreen()
}
