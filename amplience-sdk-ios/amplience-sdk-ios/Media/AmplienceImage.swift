//
//  Image.swift
//  amplience-sdk-ios
//
//  Created by Dylan McKee on 18/05/2022.
//

import Foundation

public struct AmplienceImage: Codable {
    let id: String
    public let name: String
    let endpoint: String
    let defaultHost: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, endpoint, defaultHost
    }
    
    public init(dict: [String: Any]) {
        id = dict[CodingKeys.id.rawValue] as! String
        name = dict[CodingKeys.name.rawValue] as! String
        endpoint = dict[CodingKeys.endpoint.rawValue] as! String
        defaultHost = dict[CodingKeys.defaultHost.rawValue] as! String
    }

    /**
     * [getImageUrl] returns a url that can be used with any image loading libraries
     *
     * @param image - implementation of an [AmplienceImage]
     * @param builder (optional) - manipulate the image. See [ImageUrlBuilder] for more info
     */
    public func getImageUrl(builder: ImageUrlBuilder) -> String {
        var string = "https://\(defaultHost)/i/\(endpoint)/\(name)"
        string += builder.build()
        return string
    }
}
