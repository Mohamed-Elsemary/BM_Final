//
//  Compare.swift
//  BM_Graduation_Project
//
//  Created by Elhussian Mohamed on 26/08/2023.
//

import Foundation

struct Compare: Codable {
    let firstTargetCurrency, secondTargetCurrency: TargetCurrency?
}

struct TargetCurrency: Codable {
    let conversionResult: Double?

    enum CodingKeys: String, CodingKey {
        case conversionResult = "conversion_result"
    }
}
