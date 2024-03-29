//
//  Image.swift
//  amplience-sdk-ios
//
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
        let encodedName = name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!.replacingOccurrences(of: "&", with: "%26").replacingOccurrences(of: "=", with: "%3D")
        var string = "https://\(defaultHost)/i/\(endpoint)/\(encodedName)"
        string += builder.build()
        return string
    }
}
