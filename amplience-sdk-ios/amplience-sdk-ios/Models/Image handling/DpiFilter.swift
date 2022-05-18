//
//  DpiFilter.swift
//  amplience-sdk-ios
//
//  Created by Dylan McKee on 18/05/2022.
//

import Foundation

enum DpiFilter: String {
    case Quadratic = "q"
    case Sinc = "s"
    case Lanczos = "l"
    case Point = "p"
    case Cubic = "c"
}
