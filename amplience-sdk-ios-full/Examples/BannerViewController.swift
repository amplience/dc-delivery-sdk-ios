//
//  BannerViewController.swift
//  amplience-sdk-ios-full
//
//  Created by Dylan McKee on 26/05/2022.
//

import UIKit
import Amplience

class BannerViewController: UIViewController {

    @IBOutlet private weak var topLabel: UILabel!
    @IBOutlet private weak var bottomLabel: UILabel!
    @IBOutlet private weak var buyButton: UIButton!
    @IBOutlet private weak var bannerImageView: UIImageView!
    
    private var banner: Banner? {
        didSet {
            fillData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadBanner()
    }
    
    @IBAction func buyButtonPresse(_ sender: Any) {
        if let urlString = banner?.callToActionUrl, let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
    
    private func loadBanner() {
        AmplienceManager.shared.getContentByKey(key: "example-key") { [weak self] response, error in
            guard let self = self else { return }
            if error != nil {
                print(error!.localizedDescription)
            } else if let response = response {
                let dict = response.content
                self.banner = Banner(dict: dict)
            }
        }
        
    }
    
    private func fillData() {
        guard let banner = banner else {
            [topLabel, bottomLabel, buyButton, bannerImageView].forEach { $0?.isHidden = true }
            return
        }
        
        [topLabel, bottomLabel, buyButton, bannerImageView].forEach { $0?.isHidden = false }
       
        topLabel.text = banner.headline
        bottomLabel.text = banner.strapline
        buyButton.setTitle(banner.callToActionText, for: .normal)
        if let bg = banner.background {
            let url = AmplienceManager.shared.getImageUrl(image: bg, builder: ImageUrlBuilder())
            ImageLoader.shared.loadImage(urlString: url, completion: { [weak self] image in
                guard let self = self else { return }
                self.bannerImageView.image = image
            })
        }
       
    }

}
