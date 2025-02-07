import SwiftUI

struct HomeScreen: View {
  
  @Binding var isShownTabBar: Bool
  @State private var isShownQR: Bool = false
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        VStack {
          UserDataView()
          CityFuelsView()
            .padding(15)
          List(Service.services) { service in
            
            NavigationLink {
              switch service.type {
              case .support:
                SupportScreen()
                  .onAppear { isShownTabBar = false }
              }
            } label: {
              CustomListCell(title: service.type.rawValue,
                   description: service.description,
                   image: service.image,
                   imageColor: .accent)
            }
            .listRowBackground(Color.primaryBackground)
          }
          .listStyle(.plain)
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItem(placement: .topBarLeading) {
            Image(.logo)
              .resizable()
              .frame(width: 54, height: 54)
          }
          ToolbarItem(placement: .topBarTrailing) {
            Button {
              isShownQR.toggle()
            } label: {
              Image("qrcode")
                .navigationBarImageSize
                .foregroundStyle(.accent)
            }
            .buttonStyle(.animated)
          }
        }
        .sheet(isPresented: $isShownQR) {
          QRCodeView()
            .presentationDetents([.height(250)])
            .presentationDragIndicator(.visible)
            .presentationCornerRadius(20)
        }
        .onAppear { isShownTabBar = true }
      }
    }
  }
}
