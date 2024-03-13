//
//  FeedbackScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 10.12.2023.
//

import SwiftUI

enum FeedbackFormTextField {
  case email, message
}

struct SupportScreen: View {
  
  // MARK: - Properties
  @EnvironmentObject var authenticationVM: AuthenticationViewModel
  @FocusState private var focusedFeedbackTF: FeedbackFormTextField?
  
  @State private var email: String = ""
  @State private var message: String = ""
  
  // MARK: - body
  var body: some View {
    NavigationStack {
      VStack(alignment: .leading, spacing: 10) {
        
        VStack(alignment: .leading, spacing: 20) {
          CustomTextField(inputData: $email,
                          title: "Email",
                          placeholder: "Write your email address here.")
          .keyboardType(.emailAddress)
          .textInputAutocapitalization(.never)
          .autocorrectionDisabled(true)
          .focused($focusedFeedbackTF, equals: .email)
          .submitLabel(.next)
          .onSubmit { focusedFeedbackTF = .message }
          
          CustomTextField(inputData: $message,
                          title: "Message",
                          placeholder: "Write your message here.")
          .focused($focusedFeedbackTF, equals: .message)
          .onSubmit { focusedFeedbackTF = nil }
          .submitLabel(.done)
          
          Button("Send", systemImage: "paperplane.fill") {
            
          }
          .buttonStyle(CustomButtonModifier(pouring: .accent))
          .disabled(!isValidForm)
          .opacity(isValidForm ? 1.0 : 0.5)
        }
        .padding()
        
        VStack(alignment: .leading, spacing: 3) {
          Text("Call our hotline:")
            .font(.footnote)
            .foregroundStyle(.gray)
          
          ScrollableHotlineNumbers()
        }
        .padding()
        
        Spacer()
      }
      .navigationTitle("Support")
      .navigationBarTitleDisplayMode(.inline)
      .onAppear {
        if let userEmail = authenticationVM.currentUser?.email {
          email = userEmail
        } else {
          email = "No email"
        }
      }
    }
  }
}

#Preview {
  SupportScreen()
    .environmentObject(AuthenticationViewModel())
}

extension SupportScreen: AuthenticationForm {
  var isValidForm: Bool {
    return !message.isEmpty
  }
}
