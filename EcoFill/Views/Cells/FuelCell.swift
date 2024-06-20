//
//  FuelCell.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 20.02.2024.

import SwiftUI

struct FuelCell: View {
  // MARK: - properties
  let fuel: String
  let price: Double
  let width: CGFloat
  let pouring: LinearGradient
  
  var body: some View {
    RoundedRectangle(cornerRadius: 11)
      .fill(pouring)
      .frame(width: width, height: 43)
      .overlay(alignment: .center) {
        
        HStack(spacing: 20) {
          
          Text(fuel)
            .font(.lexendCallout)
            .foregroundStyle(.cmWhite)
          
          Text("\(price, specifier: "₴%.2f")")
            .font(.lexendFootnote)
            .fontWeight(.medium)
            .foregroundStyle(.accent)
        }
      }
  }
}

#Preview {
  FuelCell(fuel: "Euro A-95",
           price: 45.50,
           width: 150,
           pouring: Color.gradientGreenBlack)
}

