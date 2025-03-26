import SwiftUI
import MapKit

extension MKDirectionsTransportType: CaseIterable, Hashable {
  public static var allCases: [MKDirectionsTransportType] {
    return [.automobile, .walking]
  }
  
  var title: String {
    switch self {
    case .automobile: "Automobile"
    case .walking: "Walking"
    default: "Unknown"
    }
  }
  
  var iconName: String {
    switch self {
    case .automobile: "car"
    case .walking: "figure.walk"
    default: "questionmark"
    }
  }
}

struct MapItemView: View {
  
  let station: Station
  @EnvironmentObject var stationVM: StationViewModel
  
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea(.all)
      VStack(alignment: .leading, spacing: 18) {
        Spacer()
        addressLabel.padding(.leading, 15)
        scheduleLabel.padding(.leading, 15)
        paymentLabel.padding(.leading, 15)
        HStack(spacing: 8) {
          Text("Transport type:")
            .font(.footnote)
            .fontWeight(.medium)
            .foregroundStyle(.primaryLabel)
          ForEach(MKDirectionsTransportType.allCases, id: \.self) { type in
            transportTypeLabel(for: type)
          }
        }
        
        .padding(.horizontal,15)
        FuelStackView(for: station).padding(.horizontal, 15)
        routeButton
      }
    }
  }
  
  private func transportTypeLabel(for type: MKDirectionsTransportType) -> some View {
    Label(type.title, systemImage: type.iconName)
      .font(.footnote)
      .fontWeight(.medium)
      .foregroundStyle(type == stationVM.selectedTransportType ? .black : .primaryLime)
      .padding(10)
      .background(type == stationVM.selectedTransportType ? .primaryLime : .black)
      .clipShape(.capsule)
      .shadow(radius: 2)
      .animation(.spring, value: stationVM.selectedTransportType)
      .onTapGesture {
        stationVM.selectedTransportType = type
      }
  }
  
  private var addressLabel: some View {
    HStack(spacing: 8) {
      Image(.marker)
        .foregroundStyle(.primaryIcon)
      Text(station.street)
        .font(.footnote)
        .fontWeight(.medium)
        .foregroundStyle(.primaryLabel)
        .lineLimit(2)
        .multilineTextAlignment(.leading)
    }
  }
  
  private var scheduleLabel: some View {
    HStack(spacing: 8) {
      Image(.clock)
        .foregroundStyle(.primaryIcon)
      Text(station.schedule)
        .font(.footnote)
        .fontWeight(.medium)
        .foregroundStyle(.primaryLabel)
    }
  }
  
  private var paymentLabel: some View {
    HStack(spacing: 8) {
      Image(.money).foregroundStyle(.primaryIcon)
      Text("Payment:").foregroundStyle(.primaryLabel)
      Text("Cash, ApplePay.").foregroundStyle(.gray)
    }
    .font(.footnote)
    .fontWeight(.medium)
  }
  
  @ViewBuilder
  private var routeButton: some View {
    if stationVM.isShownRoute {
      Button {
        stationVM.isShownRoute = false
      } label: {
        ButtonLabel(
          "Hide Route",
          textColor: .white,
          pouring: .red
        )
      }
    } else {
      Button {
        stationVM.isShownRoute = true
      } label: {
        ButtonLabel(
          "Show Route",
          textColor: .black,
          pouring: .primaryLime
        )
      }
    }
  }
}

#Preview {
  MapItemView(station: .mockStation)
    .environmentObject(StationViewModel())
}
