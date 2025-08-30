import SwiftUI
import MapKit

struct MapItemView: View {
  @Environment(MapViewModel.self) var viewModel
  let station: Station
  @State private var selectedType: StationType
  
  private var availableTypes: [StationType] {
    var types: [StationType] = []
    if station.fuelInfo != nil { types.append(.fuel) }
    if station.evInfo != nil {
      types.append(.ev)
    }
    return types
  }
  
  init(station: Station) {
    self.station = station
    var initialType: StationType = .ev
    
    if station.fuelInfo != nil {
      initialType = .fuel
    } else if let evInfo = station.evInfo, !evInfo.connectors.isEmpty {
      initialType = .ev
    }
    _selectedType = State(initialValue: initialType)
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 15) {
      Spacer()
      HStack {
        VStack(alignment: .leading, spacing: 8) {
          Text(station.street)
            .font(.title3)
            .fontWeight(.semibold)
          Text(station.city)
            .font(.subheadline)
            .foregroundStyle(.secondary)
        }
        .padding(.top)
        
        Spacer()
        
        if availableTypes.count > 1 {
          Picker("Type of service", selection: $selectedType) {
            ForEach(availableTypes) { type in
              Text(type.rawValue)
                .tag(type)
            }
          }
          .pickerStyle(.menu)
          .tint(.blue)
        }
      }
      
      VStack {
        switch selectedType {
        case .fuel:
          if let fuelInfo = station.fuelInfo {
            FuelStackExtended(info: fuelInfo)
          } else {
            ContentUnavailableView(
              "Fuel information is not available",
              systemImage: "fuelpump.slash.fill"
            )
          }
        case .ev:
          if let evInfo = station.evInfo {
            EVChargingView(info: evInfo)
          } else {
            ContentUnavailableView(
              "Charging information is not available",
              systemImage: "ev.charger.slash.fill"
            )
          }
        }
      }
      .padding(.vertical)
      
      VStack(alignment: .leading, spacing: 10) {
        MapItemCell(
          title: "Schedule",
          data: station.schedule
        )
        MapItemCell(
          title: "Payment",
          data: station.paymentMethods.joined(separator: ", ")
        )
      }
      
      HStack {
        Text("Travel Mode:")
          .font(.footnote)
          .fontWeight(.semibold)
        ScrollView(.horizontal) {
          HStack(spacing: 8) {
            ForEach(viewModel.transportTypes, id: \.self) { type in
              ModeButton(transportType: type)
            }
          }
        }
        .shadow(radius: 2)
        .scrollIndicators(.hidden)
      }
      
      RouteButton()
        .padding(.top)
    }
    .presentationDetents([.fraction(selectedType == .ev ? 0.68 : 0.6)])
    .presentationDragIndicator(.visible)
    .presentationCornerRadius(30)
    .padding(.horizontal)
  }
}

struct MapItemCell: View {
  let title: String
  let data: String
  var body: some View {
    HStack {
      Text("• \(title):")
        .foregroundStyle(.secondary)
      Text(data)
        .foregroundStyle(.primary)
    }
    .font(.footnote)
    .fontWeight(.medium)
  }
}

struct ModeButton: View {
  @Environment(MapViewModel.self) var viewModel
  let transportType: MKDirectionsTransportType
  var body: some View {
    Button {
      viewModel.selectedTransport = transportType
    } label: {
      Label(transportType.title, systemImage: transportType.iconName)
        .font(.footnote)
        .fontWeight(.medium)
        .foregroundStyle(transportType == viewModel.selectedTransport ? .white : .primary)
        .padding(12)
        .background(
          transportType == viewModel.selectedTransport ? .blue : Color(.systemGray6)
        )
        .clipShape(.rect(cornerRadius: 15))
        .animation(.spring, value: viewModel.selectedTransport)
    }
  }
}
struct RouteButton: View {
  @Environment(MapViewModel.self) var viewModel
  var body: some View {
    Group {
      if viewModel.showRoute {
        Button {
          viewModel.showRoute = false
        } label: {
          Label("Hide Route", systemImage: "x.circle")
            .prominentButtonStyle(tint: .red)
        }
      } else {
        Button {
          viewModel.showRoute = true
        } label: {
          Label("Show Route", systemImage: "arrow.trianglehead.branch")
            .prominentButtonStyle(tint: .green)
        }
      }
    }.buttonStyle(.plain)
  }
}

#Preview {
  MapItemView(station: Station.mock)
    .environment(StationViewModel.mockObject)
    .environment(MapViewModel.mockObject)
}
