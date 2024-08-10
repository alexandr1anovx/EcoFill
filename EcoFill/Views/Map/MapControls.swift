import SwiftUI

struct MapControls: View {
    
    // MARK: - Public Properties
    @Binding var isPresentedList: Bool
    @Binding var isPresentedMapStyle: Bool
    
    // MARK: - body
    var body: some View {
        VStack(spacing: 10) {
            MapControlItem(img: .map) { isPresentedMapStyle = true }
            MapControlItem(img: .location) { isPresentedList = true }
        }
    }
}
