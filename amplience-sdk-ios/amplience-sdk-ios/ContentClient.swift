//
//  ContentClient.swift
//  amplience-sdk-ios
//
//

import Foundation

enum RequestOptions: String {
    case all
    case inlined
}

public typealias ContentResponseCompletion = (ContentResponse?, Error?) -> Void
public typealias MultipleContentResponseCompletion = ([ContentResponse]?, Error?) -> Void
public typealias PagedResponseCompletion = (FilterContentResponse?, Error?) -> Void

public class ContentClient {

    public required init(configuration: Configuration) {
        self.configuration = configuration
        setupStagingEnvironment()
    }
    
    private init() {
        setupStagingEnvironment()
    }

    /**
     * [configuration]
     * The current conent configuration
     */
    public var configuration: Configuration!
    
    /**
     * [shared]
     * Get the current instance of the [AmplienceManager].
     */
    public static let getInstance = ContentClient()

    /**
     * [isFresh] - switch between fresh or cached environments
     * See https://amplience.com/docs/development/freshapi/fresh-api.html for details
     *
     * @throws RuntimeException if you have not provided a freshApiKey in the [AmplienceManager.initialise] method
     */

    public var freshApiKey: String?

    private var generateBaseUrl: String {
        get {
            if let virtualStagingEnvironmenetUrl = stagingEnvironment {
                // Formulates the virtual staging environment URL as per: https://amplience.com/blog/preview-native-apps-with-dynamic-content-and-appetize/
                return "https://\(virtualStagingEnvironmenetUrl)/"
            }
            return "https://\(configuration.hub).cdn.content.amplience.net/"
        }
    }

    private var generateFreshBaseUrl: String {
        get {
            if let virtualStagingEnvironmenetUrl = stagingEnvironment {
                // Formulates the virtual staging environment URL as per: https://amplience.com/blog/preview-native-apps-with-dynamic-content-and-appetize/
                return "https://\(virtualStagingEnvironmenetUrl)/"
            }
            
            return "https://\(configuration.hub).fresh.content.amplience.net/"
        }
    }

    private var currentBaseUrl: String {
        if configuration.isFresh {
            return generateFreshBaseUrl
        } else {
            return generateBaseUrl
        }
    }
    
    private var stagingEnvironment: String?
    
    private func setupStagingEnvironment() {
        if let stagingEnvironmentUrl = UserDefaults.standard.string(forKey: "stagingEnvironment") {
            stagingEnvironment = stagingEnvironmentUrl
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
        BaseRequest().GET(url: url, params: params, object: ContentResponse.self, token: freshApiKey) { incidentTypes, error in
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
        BaseRequest().GET(url: url, params: params, object: ContentResponse.self, token: freshApiKey) { incidentTypes, error in
            completion(incidentTypes, error)
        }
    }

    /**
     * [listContent]
     * @param requests - ids or keys of content to get
     * @param locale (optional) - to override default locale
     *
     * @return [Result]List<[ContentResponse]>- returns either a success or failure.
     * Can get successful result with result.getOrNull()
     * Can get error response with result.getExceptionOrNull()
     */
    private func listContent(contentRequest: ListContentRequest, completion: @escaping MultipleContentResponseCompletion) {
        let url = currentBaseUrl + "content/fetch"
        BaseRequest().POST(url: url, requestObject: contentRequest, responseType: [ContentResponse].self) { result, error in
            completion(result, error)
        }
    }
    
    /**
     * [listContentById]
     * @param ids - ids  of content to get
     * @param parameters - to set depth/local/format
     *
     * @return [Result]List<[ContentResponse]>- returns either a success or failure.
     * Can get successful result with result.getOrNull()
     * Can get error response with result.getExceptionOrNull()
     */
    public func listContentById(ids: [String], parameters: Parameters, completion: @escaping MultipleContentResponseCompletion) {
        let request = ListContentRequest(requests: ids.map { ContentRequest(id: $0, key: nil) }, parameters: parameters)
        listContent(contentRequest: request, completion: completion)
    }
    
    /**
     * [listContentByKey]
     * @param keys - keys  of content to get
     * @param parameters - to set depth/local/format
     *
     * @return [Result]List<[ContentResponse]>- returns either a success or failure.
     * Can get successful result with result.getOrNull()
     * Can get error response with result.getExceptionOrNull()
     */
    public func listContentByKey(keys: [String], parameters: Parameters, completion: @escaping MultipleContentResponseCompletion) {
        let request = ListContentRequest(requests: keys.map { ContentRequest(id: $0, key: nil) }, parameters: parameters)
        listContent(contentRequest: request, completion: completion)
    }

    /**
     * [filterContent]
     * @param filters - any number of [FilterBy] key value pairs
     * @param sortBy (optional) - a key [SortBy.key] and optional order
     * @param page (optional) - pagination
     * @param locale (optional) - to override default locale
     *
     * @return [Result][ContentResponse] - returns either a success or failure.
     * Can get successful result with result.getOrNull()
     * Can get error response with result.getExceptionOrNull()
     */
    public func filterContent(filterRequest: FilterContentRequest, completion: @escaping PagedResponseCompletion) {
        let url = currentBaseUrl + "content/filter"
        BaseRequest().POST(url: url, requestObject: filterRequest, responseType: FilterContentResponse.self) { result, error in
            completion(result, error)
        }
    }
}
