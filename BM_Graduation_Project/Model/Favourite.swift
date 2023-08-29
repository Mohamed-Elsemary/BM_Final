//
//  Favourite.swift
//  BM_Graduation_Project
//
//  Created by Elhussian Mohamed on 26/08/2023.
//

import Foundation
// MARK: - Datum
struct Favourite: Codable {
    let code, name: String?
    let flagURL: String?
    enum CodingKeys: String, CodingKey {
            case code, name
            case flagURL = "flagUrl"
        }
}
