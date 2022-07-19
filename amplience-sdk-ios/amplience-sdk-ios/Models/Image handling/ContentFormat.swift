//
//  ContentFormat.swift
//  amplience-sdk-ios
//
//  Created by Dylan McKee on 18/05/2022.
//

import Foundation

public enum ContentFormat: String {
    case Webp = "webp"
    case Jp2 = "jp2"
    case Jpeg = "jpeg"
    case Png = "png"
    case Gif = "gif"
    case Bmp = "bmp"
    case mp4 = "mp4"
}

public enum VideoQuality: String {
    case p360 = "360p"
    case p480 = "480p"
    case p720 = "720p"
    case p1080 = "1080p"
}
