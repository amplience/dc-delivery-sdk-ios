//
//  BannerViewController.swift
//  amplience-sdk-ios-full
//
//  Created by Dylan McKee on 26/05/2022.
//

import UIKit
import Amplience

class BannerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadBanner()
    }
    
    private func loadBanner() {
        AmplienceManager.shared.getContentByKey(key: "promotions/feature-carousel") { [weak self] response, error in
            guard let self = self else { return }
            if let erorr = error {
                print(error?.localizedDescription)
            } else if let response = response {
                print(response)
            }
        }
        
    }

}
