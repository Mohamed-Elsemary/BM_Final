//
//  MyFavourite.swift
//  BM_Graduation_Project
//
//  Created by Elhussian Mohamed on 28/08/2023.
//

import Foundation
struct MyFavourite: Codable {
    let conversionRates: ConversionRates?

    enum CodingKeys: String, CodingKey {
        case conversionRates = "conversion_rates"
    }
}

struct ConversionRates: Codable {
    let eur, sar, egp: Double?

    enum CodingKeys: String, CodingKey {
        case eur = "EUR"
        case sar = "SAR"
        case egp = "EGP"
    }
}
