import SwiftUI
import MapKit

enum StationType: String, Identifiable, CaseIterable {
  case fuel = "Fuel"
  case ev = "Electric"
  
  var id: Self { self }
  var iconName: String {
    switch self {
    case .fuel:
      return "fuelpump.fill"
    case .ev:
      return "ev.charger.fill"
    }
  }
}

struct MapItemView: View {
  @Environment(MapViewModel.self) var viewModel
  let station: Station
  var withPadding: Bool = false
  @State private var stationType: StationType = .fuel
  
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      Spacer()
      Picker("Type", selection: $stationType) {
        ForEach(StationType.allCases) { type in
          Label(type.rawValue, systemImage: type.iconName)
        }
      }
      .pickerStyle(.segmented)
      
      VStack(alignment: .leading, spacing: 10) {
        MapItemCell(iconName: "location.app.fill", title: "Address", data: station.street)
        MapItemCell(iconName: "timer", title: "Schedule", data: station.schedule)
        MapItemCell(iconName: "dollarsign.circle.fill", title: "Payment", data: station.paymentMethods)
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
      FuelStackView(for: station)
      RouteButton()
    }
    .padding(.horizontal, withPadding ? 15 : 0)
  }
}

struct MapItemCell: View {
  let iconName: String
  let title: String
  let data: String
  var body: some View {
    HStack {
      HStack(spacing: 5) {
        Image(systemName: iconName)
          .font(.title3)
          .foregroundStyle(.green)
        Text("\(title):")
          .foregroundStyle(.secondary)
      }
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
          transportType == viewModel.selectedTransport ? .green : Color(.systemGray6)
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
  MapItemView(station: MockData.station)
    .environment(MapViewModel.mockObject)
}

