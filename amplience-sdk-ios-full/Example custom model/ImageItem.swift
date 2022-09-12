//
//  ImageItem.swift
//  amplience-sdk-ios-full
//
//

import Foundation
import Amplience

struct ImageItem: Codable {
    let image: AmplienceImage?
    let altText: String?

    private enum CodingKeys: String, CodingKey {
        case image, altText
    }

    init(dict: [String: Any]) {
        altText = dict[CodingKeys.altText.rawValue] as? String
        if let imageDict = dict[CodingKeys.image.rawValue] as? [String: Any] {
            image = AmplienceImage(dict: imageDict)
        } else {
            image = nil
        }
    }
}
