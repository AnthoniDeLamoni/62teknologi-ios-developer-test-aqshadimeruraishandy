//
//  BPIndexView.swift
//  api-aqsha
//
//  Created by Alif on 30/07/23.
//

import Foundation
import SwiftUI



enum Currency : CaseIterable {
    case usd
    case gbp
    case eur
    
    var icon: String {
        switch self {
        case .usd:
            return "💵"
        case .gbp:
            return "💷"
        case .eur:
            return "💶"
        }
    }
    
    var code: String {
        switch self {
        case .usd:
            return "USD"
        case .gbp:
            return "GBP"
        case .eur:
            return "EUR"
        }
    }
}

struct PriceInfo {
    let currency: Currency
    let rate: String
    
    public init(currency: Currency, rate: String = "--") {
        self.currency = currency
        self.rate = rate
    }
}

class BpIndexViewModel : ObservableObject {
    
    @Published public private(set) var lastUpdated: String = ""
    @Published public private(set) var priceDetails: [PriceInfo] = Currency.allCases.map {
        PriceInfo(currency: $0)
    }
    
    func fetchData() {
        
    }
    
    
}

extension Color {
    static let bitGreen: Color = Color.green.opacity(0.5)
}

struct BpIndexView : View {
    var body: some View {
        Text("testing")
    }
}
