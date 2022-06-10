//
//  Banner.swift
//  amplience-sdk-ios-full
//
//  Created by Dylan McKee on 26/05/2022.
//

import Foundation
import Amplience

struct Banner: Codable {
    let background: AmplienceImage?
    let headline: String
    let strapline: String
    let callToActionText: String
    let callToActionUrl: String

    private enum CodingKeys : String, CodingKey {
      case background, headline, strapline, callToActionText = "calltoactiontext", callToActionUrl = "calltoactionurl"
    }
    
    init(dict: [String: AnyCodable]) {
        headline = dict[CodingKeys.headline.rawValue]!.value as! String
        strapline = dict[CodingKeys.strapline.rawValue]!.value as! String
        callToActionText = dict[CodingKeys.callToActionText.rawValue]!.value as! String
        callToActionUrl = dict[CodingKeys.callToActionUrl.rawValue]!.value as! String
        background = AmplienceImage(dict: dict[CodingKeys.background.rawValue]!.value as! [String: Any])
    }
}
