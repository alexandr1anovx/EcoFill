import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct QRCodeScreen: View {
  
  @State private var qrCodeImage: UIImage?
  @State private var scannedCode: String?
  @State private var errorMessage: String?
  @State private var isAlertVisible = false
  @EnvironmentObject var authViewModel: AuthViewModel
  
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea()
      VStack(spacing:10) {
        
        if let user = authViewModel.currentUser {
          HStack(spacing: 0) {
            Text(user.id.dropLast(4))
              .font(.subheadline)
              .foregroundStyle(.gray)
            Text(user.id.suffix(4))
              .font(.headline)
          }
          
          if let qrCodeImage {
            Image(uiImage: qrCodeImage)
              .resizable()
              .interpolation(.none)
              .frame(width: 230, height: 230)
              .background(.white)
              .cornerRadius(10)
              .padding()
          } else {
            Text("qrcode_not_available")
              .foregroundColor(.red)
          }
          
          Spacer()
          
          Text("qrcode_screen_message")
            .font(.title2)
            .fontWeight(.bold)
          
          if scannedCode != nil {
            VStack(spacing: 12) {
              Label {
                Text("scanning_successful")
                  .font(.headline)
                  .fontWeight(.semibold)
              } icon: {
                Image(systemName: "checkmark.circle.fill")
                  .foregroundStyle(.green)
              }
              Text("bonuses_credited")
                .font(.subheadline)
                .fontWeight(.medium)
            }
            Spacer()
          } else {
            QRScannerView(scannedCode: $scannedCode, errorMessage: $errorMessage)
          }
        } else {
          ProgressView("loading_user_data")
        }
      }
    }
    .onAppear {
      generateQRCodeImage()
    }
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button("allow_camera") {
          isAlertVisible.toggle()
        }
        .alert(isPresented: $isAlertVisible) {
          Alert(
            title: Text("camera_access_required"),
            message: Text("go_to_settings"),
            primaryButton: .default(Text("Settings"), action: {
              UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }),
            secondaryButton: .default(Text("Cancel"))
          )
        }
      }
    }
  }
  
  // MARK: - Private Logical Methods
  
  private func openAppSettings() {
    guard let appSettings = URL(string: UIApplication.openSettingsURLString) else {
      return
    }
    if UIApplication.shared.canOpenURL(appSettings) {
      UIApplication.shared.open(appSettings)
    }
  }
  
  private func generateQRCodeImage() {
    guard let user = authViewModel.currentUser else {
      errorMessage = "error_missing_full_name"
      return
    }
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    filter.message = Data(user.fullName.utf8)
    
    if let outputImage = filter.outputImage,
       let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
      qrCodeImage = UIImage(cgImage: cgImage)
    } else {
      errorMessage = "error_generating_qrcode"
    }
  }
}

#Preview {
  QRCodeScreen()
}
