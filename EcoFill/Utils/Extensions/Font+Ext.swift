//
//  Font+Ext.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 14.10.2024.
//

import Foundation
import SwiftUI

extension Font {
    enum PoppinsFont {
        case regular
        case medium
        case bold
        
        var value: String {
            switch self {
            case .regular:
                return "Poppins-Regular"
            case .medium:
                return "Poppins-Medium"
            case .bold:
                return "Poppins-Bold"
            }
        }
    }
    
    static func poppins(_ type: PoppinsFont, size: CGFloat = 20) -> Font {
        return .custom(type.value, size: size)
    }
}
