//
//  AmplienceManager.swift
//  amplience-sdk-ios
//
//  Created by Dylan McKee on 18/05/2022.
//

import Foundation

enum RequestOptions: String {
    case all = "all"
    case inlined = "inlined"
}

public typealias ContentResponseCompletion = (ContentResponse?, Error?) -> ()
public typealias MultipleContentResponseCompletion = ([ContentResponse]?, Error?) -> ()
public typealias PagedResponseCompletion = (PagedResponse?, Error?) -> ()

public class AmplienceManager {

    /**
     * [shared]
     * Get the current instance of the [AmplienceManager].
     */
    public static let shared = AmplienceManager()

    private init() {}

    /**
     * [hub]
     * The current conent hub name.
     */
    public var hub: String?

    /**
     * [isFresh] - switch between fresh or cached environments
     * See https://amplience.com/docs/development/freshapi/fresh-api.html for details
     *
     * @throws RuntimeException if you have not provided a freshApiKey in the [AmplienceManager.initialise] method
     */
    public var isFresh: Bool = false

    public var freshApiKey: String?

    private var generateBaseUrl: String {
        get {
            return "https://\(hub!).cdn.content.amplience.net/"
        }
    }

    private var generateFreshBaseUrl: String {
        get {
            return "https://\(hub!).fresh.content.amplience.net/"
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

    /**
     * [getContentById]
     * @param id - the id of the object you want to retrieve
     *
     * @return [Result][ContentResponse] - returns either a success or failure.
     * Can get successful result with result.getOrNull()
     * Can get error response with result.getExceptionOrNull()
     */
    public func getContentById(id: String, completion: @escaping ContentResponseCompletion) {
        let params: [String: Any] = [
            "depth": RequestOptions.all.rawValue,
            "format": RequestOptions.inlined.rawValue
        ]
        let url = currentBaseUrl + "content/id/\(id)"
        BaseRequest().GET(url: url, params: params, object: ContentResponse.self, token: freshApiKey) {
            incidentTypes, error in
            completion(incidentTypes, error)
        }
    }

    /**
     * [getContentByKey]
     * @param key - the key of the object you want to retrieve
     *
     * @return [Result][ContentResponse] - returns either a success or failure.
     * Can get successful result with result.getOrNull()
     * Can get error response with result.getExceptionOrNull()
     */
    public func getContentByKey(key: String, completion: @escaping ContentResponseCompletion) {
        let params: [String: Any] = [
            "depth": RequestOptions.all.rawValue,
            "format": RequestOptions.inlined.rawValue
        ]
        let url = currentBaseUrl + "content/key/\(key)"
        BaseRequest().GET(url: url, params: params, object: ContentResponse.self, token: freshApiKey) {
            incidentTypes, error in
            completion(incidentTypes, error)
        }
    }

    /**
     * [getMultipleContent]
     * @param requests - ids or keys of content to get
     * @param locale (optional) - to override default locale
     *
     * @return [Result]List<[ContentResponse]>- returns either a success or failure.
     * Can get successful result with result.getOrNull()
     * Can get error response with result.getExceptionOrNull()
     */
    private func getMultipleContent(contentRequest: ContentRequest, completion: @escaping MultipleContentResponseCompletion) {
        let url = currentBaseUrl + "content/fetch"
        BaseRequest().POST(url: url, requestObject: contentRequest, responseType: [ContentResponse].self) { result, error in
            completion(result, error)
        }
    }
    
    /**
     * [getContentItemsById]
     * @param ids - ids  of content to get
     * @param parameters - to set depth/local/format
     *
     * @return [Result]List<[ContentResponse]>- returns either a success or failure.
     * Can get successful result with result.getOrNull()
     * Can get error response with result.getExceptionOrNull()
     */
    public func getContentItemsById(ids: [String], parameters: Parameters, completion: @escaping MultipleContentResponseCompletion) {
        let request = ContentRequest(requests: ids.map { Request(id: $0, key: nil) }, parameters: parameters)
        getMultipleContent(contentRequest: request, completion: completion)
    }
    
    /**
     * [getContentItemsByKey]
     * @param keys - keys  of content to get
     * @param parameters - to set depth/local/format
     *
     * @return [Result]List<[ContentResponse]>- returns either a success or failure.
     * Can get successful result with result.getOrNull()
     * Can get error response with result.getExceptionOrNull()
     */
    public func getContentItemsByKey(keys: [String], parameters: Parameters, completion: @escaping MultipleContentResponseCompletion) {
        let request = ContentRequest(requests: keys.map { Request(id: $0, key: nil) }, parameters: parameters)
        getMultipleContent(contentRequest: request, completion: completion)
    }

    /**
     * [getContentByFilters]
     * @param filters - any number of [FilterBy] key value pairs
     * @param sortBy (optional) - a key [SortBy.key] and optional order
     * @param page (optional) - pagination
     * @param locale (optional) - to override default locale
     *
     * @return [Result][ContentResponse] - returns either a success or failure.
     * Can get successful result with result.getOrNull()
     * Can get error response with result.getExceptionOrNull()
     */
    public func getContentByFilters(filterRequest: FilterRequest, completion: @escaping PagedResponseCompletion) {
        let url = currentBaseUrl + "content/filter"
        BaseRequest().POST(url: url, requestObject: filterRequest, responseType: PagedResponse.self) { result, error in
            completion(result, error)
        }
    }
}
