import SwiftUI
import MapKit

struct MapStyleView: View {
    
    // MARK: - Public Properties
    @Binding var mapStyle: MapStyle
    
    // MARK: - Private Properties
    @State private var isStandardStyleSelected = false
    @State private var isHybridStyleSelected = false
    
    var body: some View {
        HStack(spacing: 10) {
            Button("Standard") {
                mapStyle = .standard
                isStandardStyleSelected = true
                isHybridStyleSelected = false
            }
            Button("Hybrid") {
                mapStyle = .hybrid
                isStandardStyleSelected = false
                isHybridStyleSelected = true
            }
        }
        .customButtonStyle(pouring: .cmBlack)
    }
}
