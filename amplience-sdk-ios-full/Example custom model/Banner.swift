//
//  Banner.swift
//  amplience-sdk-ios-full
//
//  Created by Dylan McKee on 26/05/2022.
//

import Foundation
import Amplience

struct Banner: Codable {
    let background: Background? // should be replaced with Background object
    let headline: String?
    let strapline: String?
    let callToActionText: String?
    let callToActionUrl: String?
    let link: Link?

    private enum CodingKeys : String, CodingKey {
      case background, headline, strapline, callToActionText = "calltoactiontext", callToActionUrl = "calltoactionurl", link
    }
    
    init(dict: [String: AnyCodable]) {
        headline = dict[CodingKeys.headline.rawValue]!.value as? String
        strapline = dict[CodingKeys.strapline.rawValue]!.value as? String
        callToActionText = dict[CodingKeys.callToActionText.rawValue]!.value as? String
        callToActionUrl = dict[CodingKeys.callToActionUrl.rawValue]!.value as? String
        background = Background(dict: dict[CodingKeys.background.rawValue]!.value as! [String: Any])
        if let linkDict = dict[CodingKeys.link.rawValue]?.value as? [String: Any] {
            link = Link(dict: linkDict)
        } else {
            link = nil
        }
    }
    
    init(dict: [String: Any]) {
        headline = dict[CodingKeys.headline.rawValue] as? String
        strapline = dict[CodingKeys.strapline.rawValue] as? String
        callToActionText = dict[CodingKeys.callToActionText.rawValue] as? String
        callToActionUrl = dict[CodingKeys.callToActionUrl.rawValue] as? String
        background = Background(dict: dict[CodingKeys.background.rawValue] as! [String: Any])
        if let linkDict = dict[CodingKeys.link.rawValue] as? [String: Any] {
            link = Link(dict: linkDict)
        } else {
            link = nil
        }
    }
}

struct Link: Codable {
    let url: String?
    let title: String?
    
    private enum CodingKeys : String, CodingKey {
      case title, url
    }
    
    init(dict: [String: Any]) {
        title = dict[CodingKeys.title.rawValue] as? String
        url = dict[CodingKeys.url.rawValue] as? String
    }
}

struct Background: Codable {
    let alt: String?
    let image: AmplienceImage?
    
    private enum CodingKeys : String, CodingKey {
      case alt, image
    }
    
    init(dict: [String: Any]) {
        alt = dict[CodingKeys.alt.rawValue] as? String
        if let imageDict = dict[CodingKeys.image.rawValue] as? [String: Any] {
            image = AmplienceImage(dict: imageDict)
        } else {
            image = AmplienceImage(dict: dict)
        }
       
    }
}
