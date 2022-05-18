//
//  Crop.swift
//  amplience-sdk-ios
//
//  Created by Dylan McKee on 18/05/2022.
//

import Foundation

struct Crop: Codable {
    let x: Int // offset from the top left of the image
    let y: Int // offset from the top of the image
    let w: Int // width of the selection
    let h: Int // height of the selection

}
