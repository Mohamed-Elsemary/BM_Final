//
//  UserDefaults .swift
//  BM_Graduation_Project
//
//  Created by mohamed on 29/08/2023.
//
import Foundation
struct DataBase {
    static private let defaults = UserDefaults.standard
    static func save(favorites: [Favourite]) {
            let encoder = JSONEncoder()
            let encodedFavorites = try? encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: "Favorite")
    }
    static func retrieveFavorites(completion: @escaping (Result<[Favourite], Error>) -> Void) {
        guard let favoritesData = defaults.object(forKey: "Favorite") as? Data else {
            completion(.success([]))
            return
        }
            let decoder = JSONDecoder()
            let favorites = try? decoder.decode([Favourite].self, from: favoritesData)
            completion(.success(favorites!))
    }
    static func add (item:Favourite){
        
        
    }
    static func remove(item:Favourite){
        
        
    }
    
}
