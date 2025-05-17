//
//  View+Extension.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 14.05.2025.
//

import SwiftUICore
import UIKit

extension View {
  
  // MARK: Custom List Setup
  
  func customListSetup(
    height: CGFloat? = nil,
    rowHeight: CGFloat = 0,
    rowSpacing: CGFloat = 0,
    sectionSpacing: CGFloat = 0,
    shadow: CGFloat = 0,
    scrollDisabled: Bool = false
  ) -> some View {
    self
      .listStyle(.insetGrouped)
      .environment(\.defaultMinListRowHeight, rowHeight)
      .listRowSpacing(rowSpacing)
      .listSectionSpacing(sectionSpacing)
      .scrollContentBackground(.hidden)
      .scrollDisabled(scrollDisabled)
      .scrollIndicators(.hidden)
      .frame(height: height)
      .shadow(radius: shadow)
  }
  
  // MARK: Segmented Control UI Setup
  
  func setupSegmentedControlUI() {
    let appearance = UISegmentedControl.appearance()
    appearance.selectedSegmentTintColor = .buttonBackground
    appearance.setTitleTextAttributes(
      [.foregroundColor: UIColor.primaryText], for: .selected
    )
    appearance.setTitleTextAttributes(
      [.foregroundColor: UIColor.label], for: .normal
    )
    appearance.backgroundColor = .systemBackground
  }
}
