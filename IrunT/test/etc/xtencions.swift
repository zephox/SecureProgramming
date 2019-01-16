//
//  xtencions.swift
//  test
//
//  Created by Alex Iakab on 06/12/2018.
//  Copyright © 2018 Alex Iakab. All rights reserved.
//
import Foundation
import UIKit
import Alamofire

extension UIColor{
    static let goodGreen = UIColor(red:0.00, green:1.00, blue:0.00, alpha:1.0)
}
extension URL{
    static let CPU = "https://zephox.nl/cpu.json"
    static let PSU = "https://zephox.nl/psu.json"
    static let GPU = "https://zephox.nl/gpu.json"
    static let Memory = "https://zephox.nl/memory.json"
    static let Case = "https://zephox.nl/case.json"
    static let Motherboard = "https://zephox.nl/motherboard.json"
    static let Storage = "https://zephox.nl/storage.json"
    static let CpuCooler = "https://zephox.nl/cooler.json"
    static let GameList = "https://www.game-debate.com/game/api/list"
}


extension DataRequest{
    /// @Returns - DataRequest
    /// completionHandler handles JSON Object T
    @discardableResult func responseObject<T: Decodable> (
        queue: DispatchQueue? = nil ,
        completionHandler: @escaping (DataResponse<T>) -> Void ) -> Self{
        
        let responseSerializer = DataResponseSerializer<T> { request, response, data, error in
            guard error == nil else {return .failure("shit goes wrong" as! Error)}
            
            let result = DataRequest.serializeResponseData(response: response, data: data, error: error)
            guard case let .success(jsonData) = result else{
                return .failure("shit goes wrong" as! Error)
            }
            
            // Json Decoder. Decodes the data object into expected type T
            // throws error when fails
            let decoder = JSONDecoder()
            guard let responseObject = try? decoder.decode(T.self, from: jsonData)else{
                return .failure("shit goes wrong" as! Error)
            }
            return .success(responseObject)
        }
        return response(queue: queue, responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
    
    /// @Returns - DataRequest
    /// completionHandler handles JSON Array [T]
    @discardableResult func responseCollection<T: Decodable>(
        queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<[T]>) -> Void
        ) -> Self{
        
        let responseSerializer = DataResponseSerializer<[T]>{ request, response, data, error in
            guard error == nil else {return  .failure("shit goes wrong" as! Error)}
            
            let result = DataRequest.serializeResponseData(response: response, data: data, error: error)
            guard case let .success(jsonData) = result else{
                return  .failure("shit goes wrong" as! Error)
            }
            
            let decoder = JSONDecoder()
            guard let responseArray = try? decoder.decode([T].self, from: jsonData)else{
                return  .failure("shit goes wrong" as! Error)
            }
            
            return .success(responseArray)
        }
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}

//extension DataRequest {
//    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
//        return DataResponseSerializer { _, response, data, error in
//            guard error == nil else { return .failure(error!) }
//            guard let data = data else {
//                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
//            }
//            return Result { try newJSONDecoder().decode(T.self, from: data) }
//        }
//    }
//
//    @discardableResult
//    func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
//        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
//    }
//
//    @discardableResult
//    func responseGPU(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<GPUS>) -> Void) -> Self {
//        return responseDecodable(queue: queue, completionHandler: completionHandler)
//    }
//    @discardableResult
//    func responseGeneric<T:Decodable>(queue: DispatchQueue? = nil,completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
//        return responseDecodable(completionHandler: completionHandler)
//    }
//}
//
