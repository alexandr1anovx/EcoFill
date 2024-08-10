import SwiftUI

struct ServiceCell: View {
    
    // MARK: - Public Properties
    let service: Service
    
    // MARK: - body
    var body: some View {
        NavigationLink {
            switch service.type {
            case .support:
                SupportScreen()
            }
        } label: {
            HStack(spacing: 15) {
                Image(systemName: service.imageName)
                    .font(.title)
                    .foregroundStyle(.accent)
                VStack(alignment: .leading, spacing: 8) {
                    Text(service.title)
                        .font(.lexendCallout)
                        .foregroundStyle(.cmReversed)
                    Text(service.description)
                        .font(.lexendCaption)
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.leading)
                }
            }
        }
    }
}
