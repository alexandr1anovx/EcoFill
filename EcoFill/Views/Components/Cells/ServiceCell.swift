import SwiftUI

struct ServiceCell: View {
    let service: Service
    
    var body: some View {
        NavigationLink {
            switch service.type {
            case .support: SupportScreen()
            }
        } label: {
            HStack(spacing: 15) {
                Image(systemName: service.image)
                    .font(.title)
                    .foregroundStyle(.accent)
                VStack(alignment: .leading, spacing: 8) {
                    Text(service.type.rawValue)
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
