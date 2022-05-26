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

    func getUrl() -> String {
        return ""//TODO: AmplienceManager.getInstance().getImageUrl(this)
    }
}
