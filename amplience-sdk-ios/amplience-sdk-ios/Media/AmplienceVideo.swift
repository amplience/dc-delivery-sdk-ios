//
//  AmplienceVideo.swift
//  Amplience
//
//  Created by Dylan McKee on 26/05/2022.
//

import Foundation

public struct AmplienceVideo: Codable {
    public let name: String
    public let defaultHost: String
    public let endpoint: String
    
    private enum CodingKeys: String, CodingKey {
        case name, defaultHost, endpoint
    }
    
    public init(dict: [String: Any]) {
        name = dict[CodingKeys.name.rawValue] as! String
        defaultHost = dict[CodingKeys.defaultHost.rawValue] as! String
        endpoint = dict[CodingKeys.endpoint.rawValue] as! String
    }
    
    /**
     * [getVideoUrl] returns a url that can be used with any video loading libraries
     *
     * @param video - implementation of an [AmplienceVideo]
     */
    public func getVideoUrl() -> String {
        return "https://\(defaultHost)/v/\(endpoint)/\(name)/mp4_720p"
    }

    /**
     * [getVideoThumbnailUrl] returns a url that can be used with any image loading libraries
     *
     * @param video - your implementation of an [AmplienceVideo]
     * @param builder (optional) - manipulate the thumbnail image. See [ImageUrlBuilder] for more info
     * @param thumbName (optional) - the specific thumb frame
     *     e.g. https://cdn.media.amplience.net/v/ampproduct/ski-collection/thumbs/frame_0020.png
     */
    public func getVideoThumbnailUrl(builder: ImageUrlBuilder, thumbName: String? = nil) -> String {
        var string = "https://\(defaultHost)/v/\(endpoint)/\(name)"
        if (thumbName != nil) {
            string += "/thumbs/\(thumbName!)"
        }
        string += builder.build()
        return string
    }

}
