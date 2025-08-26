import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct QRCodeScreen: View {
  
  @Environment(SessionManager.self) var sessionManager
  @StateObject private var viewModel: QRCodeViewModel
  
  init(viewModel: QRCodeViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }
  
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea()
      VStack(spacing:10) {
        
        if let user = sessionManager.currentUser {
          HStack(spacing: 0) {
            Text(user.uid.dropLast(4))
              .font(.subheadline)
              .foregroundStyle(.gray)
            Text(user.uid.suffix(4))
              .font(.headline)
          }
          
          if let qrCodeImage = viewModel.qrCodeImage {
            Image(uiImage: qrCodeImage)
              .resizable()
              .interpolation(.none)
              .frame(width: 230, height: 230)
              .background(.white)
              .cornerRadius(10)
              .padding()
          } else {
            Text("QR Code is not available")
              .foregroundColor(.red)
          }
          
          Spacer()
          
          Text("Scan the QR Code:")
            .font(.title2)
            .fontWeight(.bold)
          
          if viewModel.scannedCode != nil {
            Label {
              Text("Scanning was successful!")
                .font(.headline)
                .fontWeight(.semibold)
            } icon: {
              Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.accent)
            }
            Spacer()
          } else {
            QRScannerView(
              scannedCode: $viewModel.scannedCode,
              errorMessage: $viewModel.errorMessage
            )
          }
        } else {
          ProgressView("Loading user data...")
        }
      }
    }
    .onAppear {
      viewModel.generateQRCodeImage()
    }
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button("Camera Settings") {
          viewModel.isShownAlert.toggle()
        }
        .alert(isPresented: $viewModel.isShownAlert) {
          Alert(
            title: Text("Camera access is required to scan the code."),
            message: Text("Go to settings?"),
            primaryButton: .default(Text("Settings"), action: {
              UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }),
            secondaryButton: .default(Text("Cancel"))
          )
        }
      }
    }
  }
}

