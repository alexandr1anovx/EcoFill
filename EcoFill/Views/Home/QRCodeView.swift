import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct QRCodeView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Spacer()
                XmarkButton()
            }
            if let user = userViewModel.currentUser {
                Image(uiImage: generateQRCode(from: user.initials))
                    .resizable()
                    .interpolation(.none)
                    .frame(width: 180, height: 180)
            } else {
                ProgressView("Loading user data...")
            }
        }
        .padding(.horizontal)
    }
}

extension QRCodeView {
    private func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        if let outputImage = filter.outputImage,
           let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgImage)
        }
        return UIImage(resource: .xmark)
    }
}
