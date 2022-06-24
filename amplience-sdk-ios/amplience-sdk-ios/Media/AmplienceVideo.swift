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
}
