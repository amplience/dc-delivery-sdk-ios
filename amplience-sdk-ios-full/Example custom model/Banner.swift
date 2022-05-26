//
//  Banner.swift
//  amplience-sdk-ios-full
//
//  Created by Dylan McKee on 26/05/2022.
//

import Foundation
import Amplience

struct Banner: Codable {
    let background: AmplienceImage
    let headline: String
    let strapline: String
    let callToActionText: String
    let callToActionUrl: String

    private enum CodingKeys : String, CodingKey {
      case background, headline, strapline, callToActionText = "calltoactiontext", callToActionUrl = "calltoactionurl"
    }
}
