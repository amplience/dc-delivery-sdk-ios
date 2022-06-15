//
//  Slide.swift
//  amplience-sdk-ios-full
//
//  Created by Maksym Paidych on 16.06.2022.
//

import Foundation
import Amplience

struct Slide: Codable {
    let headline: String
    let subheading: String
    let imageItem: AmplienceImage
    
    private enum CodingKeys : String, CodingKey {
      case imageItem, headline, subheading
    }
    
    init(dict: [String: Any]) {
        headline = dict[CodingKeys.headline.rawValue] as! String
        subheading = dict[CodingKeys.subheading.rawValue] as! String
        imageItem = AmplienceImage(dict: (dict[CodingKeys.imageItem.rawValue] as! [String: Any])["image"] as! [String: Any])
    }
}
