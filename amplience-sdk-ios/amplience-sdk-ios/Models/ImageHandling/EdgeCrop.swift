//
//  EdgeCrop.swift
//  amplience-sdk-ios
//
//

import Foundation

/**
 * Takes 4 parameters: [left], [top], [right], [bottom] to crop from each edge of the image
 */
struct EdgeCrop {
    let left: Int
    let top: Int
    let right: Int
    let bottom: Int
}
