//
//  Networking.swift
//  webView
//
//  Created by LKY on 12/01/21.
//

import Foundation
import Alamofire

final class Networking {
    static let shared = Networking()
    
    private let kBaseUrl = "https://gorest.co.in/public-api/"
    private let kStatusOk = 200...299
    private let kToken = "80bf96509f05620f824458d30ba68d757ee10a40251692542b5c50f5e744fb2c"
    
    func getUser(id: Int, success: @escaping (_ user:User)->(), failure: @escaping (_ error: Error?)->()){
        
        let url = "\(kBaseUrl)users/\(id)"
        
        AF.request(url, method: .get).validate(statusCode: kStatusOk).responseDecodable (of: UserResponse.self, decoder: DateDecoder()){response in
            
            if let user = response.value?.data{
                success(user)

            }else{
                //print(response.error?.responseCode ?? "No error")
                failure(response.error)
            }
        }
    }
    
    func addUser(user: NewUser, success: @escaping (_ user:User)->(), failure: @escaping (_ error: Error?)->()){
        
        let url = "\(kBaseUrl)users"
        let headers: HTTPHeaders = [.authorization(bearerToken: kToken)]
        
        AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default, headers: headers).validate(statusCode: kStatusOk).responseDecodable (of: UserResponse.self, decoder: DateDecoder()){
            response in
            
            if let user = response.value?.data, user.id != nil{
                success(user)
            }else{
                failure(response.error)
            }
        }
        
    }
    
    func updateUser(id:Int, user: NewUser, success: @escaping (_ user:User)->(), failure: @escaping (_ error: Error?)->()){
        
        let url = "\(kBaseUrl)users/\(id)"
        let headers: HTTPHeaders = [.authorization(bearerToken: kToken)]
        
        AF.request(url, method: .put, parameters: user, encoder: JSONParameterEncoder.default, headers: headers).validate(statusCode: kStatusOk).responseDecodable (of: UserResponse.self, decoder: DateDecoder()){
            response in
            
            if let user = response.value?.data, user.id != nil{
                success(user)
            }else{
                failure(response.error)
            }
        }
        
    }
    
    func deleteUser(id:Int, success: @escaping ()->(), failure: @escaping (_ error: Error?)->()){
        
        let url = "\(kBaseUrl)users/\(id)"
        let headers: HTTPHeaders = [.authorization(bearerToken: kToken)]
        
        AF.request(url, method: .delete, headers: headers).validate(statusCode: kStatusOk).response{
            response in
            if let error = response.error{
                failure(error)
            }else{
                success()
            }
        }
        
    }

    
}

