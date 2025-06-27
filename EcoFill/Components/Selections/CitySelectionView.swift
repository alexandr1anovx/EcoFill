//
//  CitySelectionView.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 20.06.2025.
//

import SwiftUI

struct CitySelectionView: View {
  
  @Binding var isExpanded: Bool
  @Binding var selectedCity: City
  
  var body: some View {
    VStack {
      HStack {
        Text("City:")
        Text(selectedCity.rawValue)
        Spacer()
        Button(isExpanded ? "Hide" : "Change") {
          withAnimation {
            isExpanded.toggle()
          }
        }.tint(.accent)
      }
      
      if isExpanded {
        HStack {
          ForEach(City.allCases, id: \.self) { city in
            cell(for: city)
          }
        }.padding(.vertical)
      }
    }
    .padding()
    .frame(height: isExpanded ? 140 : 55)
    .overlay {
      RoundedRectangle(cornerRadius: 15)
        .stroke(.gray.opacity(0.5), lineWidth: 1)
    }
  }
  
  // MARK: - Subviews
  
  private func cell(for city: City) -> some View {
    Button {
      selectedCity = city
    } label: {
      Text(city.rawValue)
        .padding(.horizontal)
        .padding(.vertical,10)
        .foregroundStyle(city == selectedCity ? .black : .white)
        .background(city == selectedCity ? .accent : .black)
        .clipShape(.capsule)
        .overlay {
          Capsule()
            .stroke(
              city == selectedCity ? .accent : .white,
              lineWidth: 1.5
            )
            .opacity(isExpanded ? 1.0 : 0.0)
        }
    }
  }
}
