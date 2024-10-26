import SwiftUI

struct EntryPoint: View {
    
    @State private var isShownContent: Bool = false
    @EnvironmentObject var userVM: UserViewModel
    
    var body: some View {
        Group {
            if userVM.userSession != nil {
                if isShownContent {
                    TabBarView()   
                } else {
                    LaunchView()
                }
            } else {
                SignInScreen()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.spring(duration: 1)) {
                    isShownContent.toggle()
                }
            }
        }
    }
}

struct LaunchView: View {
    var body: some View {
        ZStack {
            Color.primaryBackground.ignoresSafeArea()
            Image("logo")
        }
    }
}
