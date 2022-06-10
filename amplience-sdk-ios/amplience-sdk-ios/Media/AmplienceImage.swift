//
//  Image.swift
//  amplience-sdk-ios
//
//  Created by Dylan McKee on 18/05/2022.
//

import Foundation

public struct AmplienceImage: Codable {
    let id: String
    let name: String
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

    func getUrl() -> String {
        return ""//TODO: AmplienceManager.getInstance().getImageUrl(this)
    }
}
