//
//  ImageLoader.swift
//  Amplience
//
//  Created by Maksym Paidych on 10.06.2022.
//

import UIKit

public class ImageLoader {
    
    private init() {}
    
    public static let shared = ImageLoader()
    
    public func loadImage(urlString: String, completion: @escaping (_ image: UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        if urlString.count < 1 {
            completion(nil)
            return
        }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }
        }
    }
    
}
