//
//  AmplienceManager.swift
//  amplience-sdk-ios
//
//  Created by Dylan McKee on 18/05/2022.
//

import Foundation

public typealias ContentResponseCompletion = (ContentResponse?, Error?) -> ()
public typealias MultipleContentResponseCompletion = ([ContentResponse]?, Error?) -> ()
public typealias PagedResponseCompletion = (PagedResponse?, Error?) -> ()

public class AmplienceManager {
    public static let shared = AmplienceManager()
    
    private init() {}
    
    public var hub: String?
        
    /**
     * [isFresh] - switch between fresh or cached environments
     * See https://amplience.com/docs/development/freshapi/fresh-api.html for details
     *
     *
     **/
    public var isFresh = false
    
    public var freshApiKey: String?
    
    private var generateBaseUrl: String {
        get {
            return "https://\(hub!).cdn.content.amplience.net"
        }
    }
    
    private var generateFreshBaseUrl: String {
        get {
            return "https://\(hub!).fresh.content.amplience.net"
        }
    }
        
    private var currentBaseUrl: String {
        get {
            if isFresh {
                return generateFreshBaseUrl
            } else {
                return generateBaseUrl
            }
        }
    }
    
    public func getContentById(id: String, completion: @escaping ContentResponseCompletion) {
        let params: [String: Any] = [
            "depth": "all",
            "format": "inlined"
        ]
        let url = currentBaseUrl + "content/id/\(id)"
        BaseRequest().GET(url: url, params: params, object: ContentResponse.self, token: freshApiKey) {
            incidentTypes, error in
            completion(incidentTypes, error)
        }
    }
    
    public func getContentByKey(key: String, completion: @escaping ContentResponseCompletion) {
        let params: [String: Any] = [
            "depth": "all",
            "format": "inlined"
        ]
        let url = currentBaseUrl + "content/key/\(key)"
        BaseRequest().GET(url: url, params: params, object: ContentResponse.self, token: freshApiKey) {
            incidentTypes, error in
            completion(incidentTypes, error)
        }
    }
    
    public func getMultipleContent(contentRequest: ContentRequest, completion: @escaping MultipleContentResponseCompletion) {
        let url = currentBaseUrl + "content/fetch"
        BaseRequest().POST(url: url, requestObject: contentRequest, responseType: [ContentResponse].self) { result, error in
            completion(result, error)
        }
    }
    
    public func filterContent(filterRequest: FilterRequest, completion: @escaping PagedResponseCompletion) {
        let url = currentBaseUrl + "content/filter"
        BaseRequest().POST(url: url, requestObject: filterRequest, responseType: PagedResponse.self) { result, error in
            completion(result, error)
        }
    }
    
    
}
