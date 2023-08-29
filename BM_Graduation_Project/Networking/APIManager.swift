//  APIManager.swift
//  BM_Graduation_Project
//  Created by mohamed on 25/08/2023.

import Foundation
import Alamofire
class APIManager {
    
    static func getRatesData(data: Rates,currncyes : [String],completion: @escaping (_ error: Error?,_ ratesArr: [Double]?) -> Void){
        let url = URLs.favourite + "?base=" + data.base
        AF.request(url  , method: .post, parameters: currncyes, encoder: JSONParameterEncoder.default , headers: nil)
            .response
        { response in
            guard response.error == nil else {
                print (response.error!)
                completion (response.error!, nil)
                return
            }
            guard let data = response.data  else{
                print(NetworkingError.errorMessage)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let ratesRes  = try decoder.decode(MyFavouriteResponse.self, from: data)
                print(ratesRes)
                guard let ratesData = ratesRes.data else {
                    fatalError()
                    
                }
                print(ratesData)
                completion(nil,ratesData)
            }
            catch let error {
                print(error)
                completion(error, nil)
            }
            
            }
   }

     static func getCompareData(data: DataToCompare, completion: @escaping (_ error: Error?,_ comArr: Compare?) -> Void){
        let parameters: [String: Any] = ["amount": data.amount, "base": data.base, "target1": data.target1, "target2" :data.target2]
        AF.request(URLs.compare, method: HTTPMethod.get, parameters: parameters, encoding: URLEncoding.default, headers: nil) .response { response in
            
            guard response.error == nil else {
                print (response.error!)
                completion (response.error!, nil)
                return
            }
            guard let data = response.data  else{
                print(NetworkingError.errorMessage)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let compareRes = try decoder.decode(CompareResponse.self, from: data)
                guard let compareData = compareRes.data else {
                    fatalError()
                    
                }
                print(compareData)
                completion(nil,compareData)
            }
            catch let error {
                print(error)
                completion(error, nil)
            }
            
        }
        
    }
   
    static func getConvertData(data: DataToConvert,completion: @escaping (_ error: Error?,_ convArr: Convert?) -> Void){
        
        let parameters: [String: Any] = ["amount": data.amount, "base": data.base, "target": data.target]
        
        AF.request(URLs.convert, method: HTTPMethod.get, parameters: parameters , encoding: URLEncoding.default, headers: nil) .response { response in
            
            guard response.error == nil else {
                print (response.error!)
                completion (response.error!, nil)
                return
            }
            guard let data = response.data  else{
                print("data11",NetworkingError.errorMessage)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let convertRes = try decoder.decode(ConvertResponse.self, from: data)
                guard let convertData = convertRes.data else {
                    fatalError()
                    
                }
                print(convertData)
                completion(nil,convertData)
            }
            catch let error {
                print(error)
                completion(error, nil)
            }
            
        }
        
    }
    
    static func getFavouriteData( completion: @escaping (_ error: Error?,_ favArr: [Favourite]?) -> Void){
        
        AF.request(URLs.favouritelist, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: nil) .response { response in
            
            guard response.error == nil else {
                print (response.error!)
                completion (response.error!, nil)
                return
            }
            guard let data = response.data  else{
                print(NetworkingError.errorMessage)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let favouriteRes = try decoder.decode(FavouriteList.self, from: data)
                guard let favouriteData = favouriteRes.data else {
                    fatalError()
                    
                }
                completion(nil,favouriteData)
            }
            catch let error {
                print(error)
                completion(error, nil)
            }
            
        }
       
        
        
        
    }
    
}
