//
//  SlideCollectionViewCell.swift
//  amplience-sdk-ios-full
//
//  Created by Maksym Paidych on 17.06.2022.
//

import UIKit
import Amplience

class SlideCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var slideImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with slide: Slide) {
        let url = AmplienceManager.shared.getImageUrl(image: slide.imageItem, builder: ImageUrlBuilder())
        ImageLoader.shared.loadImage(urlString: url, completion: { [weak self] image in
            guard let self = self else { return }
            self.slideImageView.image = image
        })
    }

}
