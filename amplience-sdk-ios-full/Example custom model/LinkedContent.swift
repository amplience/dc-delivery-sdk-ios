//
//  LinkedContent.swift
//  amplience-sdk-ios-full
//
//  Created by Maksym Paidych on 18.07.2022.
//

import Foundation
import Amplience

struct LinkedContent: Codable {
    let meta: LinkedContentMeta?
    let altText: String?
    let image: AmplienceImage?

    private enum CodingKeys: String, CodingKey {
        case altText, image
        case meta = "_meta"
    }

    init(dict: [String: AnyCodable]) {
        altText = dict[CodingKeys.altText.rawValue]?.value  as? String
        if let metaDict = dict[CodingKeys.meta.rawValue]?.value as? [String: Any] {
            meta = LinkedContentMeta(dict: metaDict)
        } else {
            meta = nil
        }
        if let dict = dict[CodingKeys.image.rawValue]?.value as? [String: Any] {
            image = AmplienceImage(dict: dict)
        } else {
            image = nil
        }
    }
}

struct LinkedContentMeta: Codable {
    let name: String?
    let schema: String?
    let deliveryId: String?

    private enum CodingKeys: String, CodingKey {
        case name, schema, deliveryId
    }

    init(dict: [String: Any]) {
        name = dict[CodingKeys.name.rawValue] as? String
        schema = dict[CodingKeys.schema.rawValue] as? String
        deliveryId = dict[CodingKeys.deliveryId.rawValue] as? String
    }
}
