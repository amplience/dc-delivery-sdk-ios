//
//  Image.swift
//  amplience-sdk-ios
//
//  Created by Dylan McKee on 18/05/2022.
//

import Foundation

struct Image{
    let id: String
    let name: String
    let endpoint: String
    let defaultHost: String

    func getUrl() -> String {
        return ""//AmplienceManager.getInstance().getImageUrl(this)
    }
}
