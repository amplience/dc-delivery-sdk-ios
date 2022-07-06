//
//  FilterContent.swift
//  amplience-sdk-ios-full
//
//  Created by Maksym Paidych on 05.07.2022.
//

import Foundation
import Amplience

struct FilterContent: Codable {
    
    let title: String?
    let category: String?
    let description: String?
    let date: String?
    let ranking: Int?
    let image: ImageItem?
    let authors: [ContentAuthor]
    
    private enum CodingKeys: String, CodingKey {
        case title, category, description, date, ranking, image, authors
    }
    
    init(dict: [String: AnyCodable]) {
        title = dict[CodingKeys.title.rawValue]!.value as? String
        category = dict[CodingKeys.category.rawValue]!.value as? String
        description = dict[CodingKeys.description.rawValue]!.value as? String
        date = dict[CodingKeys.date.rawValue]!.value as? String
        ranking = dict[CodingKeys.ranking.rawValue]!.value as? Int
        if let imageDict = dict[CodingKeys.image.rawValue]!.value as? [String: Any] {
            image = ImageItem(dict: imageDict)
        } else {
            image = nil
        }
        
        if let authorsArrays = dict[CodingKeys.authors.rawValue]!.value as? [[String: Any]] {
            authors = authorsArrays.map { ContentAuthor(dict: $0) }
        } else {
            authors = []
        }
    }
}

struct ContentAuthor: Codable {
    
    let name: String?
    let avatar: ImageItem?
    
    private enum CodingKeys: String, CodingKey {
        case name, avatar
    }
    
    init(dict: [String: Any]) {
        name = dict[CodingKeys.name.rawValue] as? String
        if let imageDict = dict[CodingKeys.avatar.rawValue] as? [String: Any] {
            avatar = ImageItem(dict: imageDict)
        } else {
            avatar = nil
        }
    }
}
