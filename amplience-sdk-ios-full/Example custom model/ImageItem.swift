//
//  ImageItem.swift
//  amplience-sdk-ios-full
//
//  Created by Maksym Paidych on 16.06.2022.
//

import Foundation
import Amplience

struct ImageItem: Codable {
    let image: AmplienceImage
    let altText: String
    
    private enum CodingKeys: String, CodingKey {
        case image, altText
    }
    
    init(dict: [String: Any]) {
        altText = dict[CodingKeys.altText.rawValue] as! String
        image = AmplienceImage(dict: dict[CodingKeys.image.rawValue] as! [String: Any])
    }
}
