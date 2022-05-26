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
    public var isFresh: Bool {
        get {
            return self.isFresh
        }
        set {
            if freshApiKey == nil {
                fatalError("Please set freshApiKey before enabligh Fresh environment mode!")
            }
            
            self.isFresh = newValue
        }
    }
    
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
            "depth": "all",
            "format": "inlined"
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
            "depth": "all",
            "format": "inlined"
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
    public func getMultipleContent(contentRequest: ContentRequest, completion: @escaping MultipleContentResponseCompletion) {
        let url = currentBaseUrl + "content/fetch"
        BaseRequest().POST(url: url, requestObject: contentRequest, responseType: [ContentResponse].self) { result, error in
            completion(result, error)
        }
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
    
    /**
     * [getImageUrl] returns a url that can be used with any image loading libraries
     *
     * @param image - implementation of an [AmplienceImage]
     * @param builder (optional) - manipulate the image. See [ImageUrlBuilder] for more info
     */
    public func getImageUrl(
        image: AmplienceImage,
        builder: ImageUrlBuilder
    ) -> String {
        var string = "https://\(image.defaultHost)/i/\(image.endpoint)/\(image.name)"
        string += builder.build()
        return string
    }

    /**
     * [getVideoUrl] returns a url that can be used with any video loading libraries
     *
     * @param video - implementation of an [AmplienceVideo]
     */
    public func getVideoUrl(
        video: AmplienceVideo
    ) -> String {
      return "https://\(video.defaultHost)/i/\(video.endpoint)/\(video.name)/mp4_720p"
    }

    /**
     * [getVideoThumbnailUrl] returns a url that can be used with any image loading libraries
     *
     * @param video - your implementation of an [AmplienceVideo]
     * @param builder (optional) - manipulate the thumbnail image. See [ImageUrlBuilder] for more info
     * @param thumbName (optional) - the specific thumb frame
     *     e.g. https://cdn.media.amplience.net/v/ampproduct/ski-collection/thumbs/frame_0020.png
     */
    func getVideoThumbnailUrl(
        video: AmplienceVideo,
        builder: ImageUrlBuilder,
        thumbName: String? = nil
    ) -> String {
        var string = "https://\(video.defaultHost)/v/\(video.endpoint)/\(video.name)"
        if (thumbName != nil) {
            string += "/thumbs/\(thumbName!)"
        }
        string += builder.build()
        return string
    }
    
}
