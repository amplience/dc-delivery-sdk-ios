//
//  Slide.swift
//  amplience-sdk-ios-full
//
//

import Foundation
import Amplience

struct Slide: Codable {
    let headline: String?
    let subheading: String?
    let imageItem: AmplienceImage

    private enum CodingKeys: String, CodingKey {
        case imageItem, headline, subheading
    }

    init(dict: [String: Any]) {
        headline = dict[CodingKeys.headline.rawValue] as? String
        subheading = dict[CodingKeys.subheading.rawValue] as? String
        if let dict = (dict[CodingKeys.imageItem.rawValue] as? [String: Any])?["image"] as? [String: Any] {
            imageItem = AmplienceImage(dict: dict)
        } else {
            imageItem = AmplienceImage(dict: dict["image"] as! [String: Any])
        }
    }
}
