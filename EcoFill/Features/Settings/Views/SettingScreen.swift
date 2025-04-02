import SwiftUI

struct SettingScreen: View {
  
  @State private var deletionPassword = ""
  @State private var isShownDeletetionAlert = false
  @EnvironmentObject var authViewModel: AuthViewModel
  
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea(.all)
      List {
        ColorThemePickerView()
        LanguagePickerView()
        updateEmailCell
        deleteAccountCell
      }
      .scrollContentBackground(.hidden)
      .scrollIndicators(.hidden)
      .listRowSpacing(10)
      .shadow(radius: 1)
      .environment(\.defaultMinListRowHeight, 55)
    }
    .navigationTitle("settings_title")
    .navigationBarTitleDisplayMode(.inline)
  }
  
  private var updateEmailCell: some View {
    NavigationLink {
      UpdateEmailScreen()
    } label: {
      ListCell(
        title: "updateEmail_title",
        subtitle: "updateEmail_subtitle",
        icon: "envelope",
        iconColor: .primaryLabel
      )
    }
  }

  private var deleteAccountCell: some View {
    Button {
      isShownDeletetionAlert.toggle()
    } label: {
      ListCell(
        title: "delete_account_title",
        subtitle: "delete_account_subtitle",
        icon: "xmark.circle.fill",
        iconColor: .red
      )
    }
    .alert("Password", isPresented: $isShownDeletetionAlert) {
      SecureField("", text: $deletionPassword)
      Button("Cancel", role: .cancel) { deletionPassword = "" }
      Button("Confirm") {
        Task {
          await authViewModel.deleteUser(withPassword: deletionPassword)
          deletionPassword = ""
        }
      }
    } message: {
      Text("delete_account_message")
    }
  }
}

#Preview {
  SettingScreen()
    .environmentObject( AuthViewModel() )
    .environmentObject( MapViewModel() )
}
