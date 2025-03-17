import SwiftUI
import FirebaseAuth

struct SettingScreen: View {
  @State private var password = ""
  @State private var isShownDeletetionAlert = false
  @EnvironmentObject var userVM: UserViewModel
  
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea(.all)
      List {
        ColorSchemeChanger()
        updateEmailCell
        deleteAccountCell
      }
      .scrollContentBackground(.hidden)
      .scrollIndicators(.hidden)
      .listRowSpacing(10)
      .shadow(radius: 1)
    }
    .navigationTitle("Settings")
    .navigationBarTitleDisplayMode(.inline)
  }
  
  private var updateEmailCell: some View {
    NavigationLink {
      UpdateEmailScreen()
    } label: {
      ListCell(
        title: "Update Email",
        subtitle: "Update your email address.",
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
        title: "Delete Account",
        subtitle: "It will pernamently delete your data.",
        icon: "xmark.circle.fill",
        iconColor: .red
      )
    }
    .alert("Password", isPresented: $isShownDeletetionAlert) {
      SecureField("", text: $password)
      Button("Confirm", role: .destructive) {
        Task {
          await userVM.deleteUser(withPassword: password)
        }
      }
    } message: {
      Text("Enter your account password to delete your account.")
    }
  }
}

#Preview {
  SettingScreen()
    .environmentObject( UserViewModel() )
    .environmentObject( StationViewModel() )
}
