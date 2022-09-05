//
//  BaseRequest.swift
//  amplience-sdk-ios
//
//  Created by Dylan McKee on 26/05/2022.
//

import Foundation
import UIKit

class BaseRequest: NSObject {
    typealias SuccessCompletion = (Error?) -> ()
    typealias BaseCompletion<Object: Codable> = (Object?, Error?) -> ()
    
    // This base request allows you to fetch from a URL and have it automatically process the data.
    func GET<Object: Codable>(url: String, params: [String: Any] = [:], object: Object.Type, token: String? = nil, completion: @escaping BaseCompletion<Object>) {
        var urlComponents = URLComponents(string: url)
        urlComponents?.queryItems = []
        for (key, value) in params {
            let queryItem = URLQueryItem(name: key, value: String(describing: value))
            urlComponents?.queryItems?.append(queryItem)
        }
        if let url = urlComponents?.url {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            self.addRequestHeaders(request: &request)
            if let t = token { self.addAuthenticationHeader(token: t, request: &request)}

            return self.processRequest(Object.self, request: request, completion: completion)
        } else {
            completion(nil, NetworkingError.badRequest)
        }
    }
    
    // This base request allows you to fetch from a URL and have it automatically process the data.
    func POST<RequestObject: Codable, ResponseObject: Codable>(url: String, params: [String: Any] = [:], requestObject: RequestObject, responseType: ResponseObject.Type, token: String? = nil, completion: @escaping BaseCompletion<ResponseObject>) {
        var urlComponents = URLComponents(string: url)
        urlComponents?.queryItems = []
        for (key, value) in params {
            let queryItem = URLQueryItem(name: key, value: String(describing: value))
            urlComponents?.queryItems?.append(queryItem)
        }
        if let url = urlComponents?.url {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            if let t = token { self.addAuthenticationHeader(token: t, request: &request)}
            let encoder = JSONEncoder()
            request.httpBody = try? encoder.encode(requestObject)
            self.addRequestHeaders(request: &request)
            return self.processRequest(ResponseObject.self, request: request, completion: completion)
        } else {
            completion(nil, NetworkingError.badRequest)
        }
    }

    // Take the response, try to decode it, if successful return to the caller.
    func processRequest<Object: Decodable>(_ objectType: Object.Type, request: URLRequest, shouldRetry: Bool = true, completion: @escaping BaseCompletion<Object>) {
        
        let task = URLSession.logSharedSession.dataTask(with: request) { (data, response, error) in
            // System URL Errors like -1001 will hit this
            
            guard let httpResponse = response as? HTTPURLResponse else {
                if let error = error as? NSError {
                    if [NetworkingError.badGateway, NetworkingError.timedOut, NetworkingError.cannotFindHost, NetworkingError.cannotConnectToHost, NetworkingError.notConnectedToInternet].map({ $0.code() }).contains(error.code) && shouldRetry {
                       self.processRequest(objectType, request: request, shouldRetry: false, completion: completion)
                       return
                   } else {
                       completion(nil, NetworkingError(from: error.code))
                   }
                } else {
                    completion(nil, NetworkingError.generic)
                }
                return
            }
            
            
            // Did the server timeout? if so, retry it.
             if [NetworkingError.badGateway, NetworkingError.timedOut, NetworkingError.cannotFindHost, NetworkingError.cannotConnectToHost, NetworkingError.notConnectedToInternet].map({ $0.code() }).contains(httpResponse.statusCode) { // bad gateway, timedout variations
                if shouldRetry {
                    self.processRequest(objectType, request: request, shouldRetry: false, completion: completion)
                    return
                } else {
                    completion(nil, NetworkingError.serverError)
                    return
                }
            }
            
            // was the code something else unsavoury?
           if !(200...304).contains(httpResponse.statusCode) {
               completion(nil, NetworkingError.init(from: httpResponse.statusCode))
               return
           }
            
            if let response = response as? HTTPURLResponse, let data = data, 200...304 ~= response.statusCode {
                DispatchQueue.main.async {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .secondsSince1970
                    do {
                        let object = try decoder.decode(Object.self, from: data)
                        // update our cache.
                        completion(object, nil)
                    } catch {
                        completion(nil, NetworkingError.decodingFailed)
                    }
                }
            } else {
                    completion(nil, NetworkingError.generic)
                }
            }
        task.resume()
    }
    
    func addRequestHeaders(request: inout URLRequest) {
        var headers: [String: String] = [:]
        headers["Accept"] = "application/json"
        headers["Content-Type"] = "application/json"
        
        headers.forEach { (key: String, value: String) in
            request.addValue(value, forHTTPHeaderField: key)
        }
    }
    
    func addAuthenticationHeader(token: String, request: inout URLRequest) {
        request.setValue(token, forHTTPHeaderField: "X-API-Key")
    }
}

extension URLSession {
    static var logSharedSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = TimeInterval(60)
        config.timeoutIntervalForResource = TimeInterval(60)
        return URLSession(configuration: config)
    }()
}
