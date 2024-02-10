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
  @State private var message: String = ""
  @FocusState private var focusedFeedbackTF: FeedbackFormTextField?
  
  private var phoneNumbers: [String] = [
    "(096)-530-25-19",
    "(050)-612-70-70",
    "(067)-685-61-01"
  ]
  
  @EnvironmentObject var authViewModel: AuthViewModel
  
  // MARK: - body
  var body: some View {
    NavigationStack {
      
      // MARK: - Feedback
      VStack(alignment: .leading, spacing:10) {
        Text("Send a feedback message about our service.")
          .font(.footnote)
          .foregroundStyle(.gray)
        
        VStack(spacing:20) {
          if let userEmail = authViewModel.currentUser?.email {
            CustomTextField(text: .constant(userEmail),
                            title: "Email",
                            placeholder: "Write your email address here.")
            .keyboardType(.emailAddress)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
            .focused($focusedFeedbackTF, equals: .email)
            .submitLabel(.next)
            .onSubmit { focusedFeedbackTF = .message }
          } else {
            Label("Email is not available. Please, refresh the application.",
                  systemImage: "xmark.circle.fill")
            .foregroundStyle(.red)
            .padding(.vertical)
          }
          
          CustomTextField(text: $message,
                          title: "Message",
                          placeholder: "Write your message here.")
          .focused($focusedFeedbackTF, equals: .message)
          .onSubmit { focusedFeedbackTF = nil }
          .submitLabel(.done)
        }
        .padding(.vertical)
        
        CustomButton(title: "Send", bgColor: .accent) {
          // Send feedback action
        }
        .disabled(!isValidForm)
        .opacity(isValidForm ? 1.0 : 0.5)
        
        // MARK: - Phone support
        Text("Call our hotline:")
          .font(.footnote)
          .foregroundStyle(.gray)
          .padding(.top,30)
        
        ScrollView(.horizontal) {
          HStack(spacing:10) {
            ForEach(phoneNumbers, id: \.self) { number in
              Button(number, systemImage: "phone") {
                
              }
              .buttonStyle(.borderedProminent)
              .clipShape(.buttonBorder)
              .font(.callout)
              .tint(.accent)
              .foregroundStyle(.white)
            }
          }
        }
        .padding(.vertical,5)
        .scrollIndicators(.hidden)
        
        Spacer()
        
      } // vstack
      .padding(.horizontal,20)
      .padding(.vertical,20)
      .navigationTitle("Support")
      .navigationBarTitleDisplayMode(.inline)
      .onAppear {
        Task { await authViewModel.fetchUser() }
      }
    } // nav.stack
  }
}

#Preview {
  SupportScreen()
    .environmentObject(AuthViewModel())
}

extension SupportScreen: AuthenticationForm {
  var isValidForm: Bool {
    return !message.isEmpty
  }
}
