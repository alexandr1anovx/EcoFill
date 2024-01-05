//
//  UserPrivateDataPreview.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 04.12.2023.
//

import SwiftUI

@MainActor
struct UserPrivateDataPreview: View {
  @EnvironmentObject var authViewModel: AuthViewModel
  @State private var fullName: String = ""
  @State private var email: String = ""
  @State private var isPresentedDeletion: Bool = false
  @FocusState private var focusedTextField: FormTextField?
  
  var body: some View {
    NavigationStack {
      Form {
        Section {
          TextField("Ім'я та прізвище", text: $fullName)
            .textContentType(.name)
            .focused($focusedTextField, equals: .fullName)
            .onSubmit { focusedTextField = .email }
            .submitLabel(.next)
          
          TextField("Електронна пошта", text: $email)
            .keyboardType(.emailAddress)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .focused($focusedTextField, equals: .email)
            .onSubmit { focusedTextField = nil }
            .submitLabel(.done)
        } header: {
          Text("Персональні дані")
        }
        
        Section {
          Button("Редагувати", systemImage: "pencil") {
            focusedTextField = .fullName
          }
          .foregroundStyle(.red)
          
          Button("Зберегти зміни", systemImage: "checkmark.circle.fill") {
            // FIREBASE SAVE DATA FUNCTION
          }
        }
        
        Button("Видалити обліковий запис",
               systemImage: "xmark.circle.fill",
               role: .destructive,
               action: {
          isPresentedDeletion.toggle()
        })
        .foregroundStyle(.red)
        .confirmationDialog("Ви впевнені?",
                            isPresented: $isPresentedDeletion) {
          Button("Видалити", role: .destructive) {
            authViewModel.deleteAccount()
          }
        } message: {
          Text("Усі ваші дані будуть видалені")
        }
      }
      
      /// Show an alert, the type of which depends of the Form error.
      //      .alert(item: $userViewModel.alertItem) { alertItem in
      //        Alert(title: alertItem.title,
      //              message: alertItem.message,
      //              dismissButton: alertItem.dismissButton)
      //      }
    }
  }
}

#Preview {
  UserPrivateDataPreview()
}
