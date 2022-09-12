//
//  SlideCollectionViewCell.swift
//  amplience-sdk-ios-full
//
//

import UIKit
import Amplience

class SlideCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var slideImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with slide: Slide) {
        let url = slide.imageItem.getImageUrl(builder: ImageUrlBuilder())
        ImageLoader.shared.loadImage(urlString: url, completion: { [weak self] image in
            guard let self = self else { return }
            self.slideImageView.image = image
        })
    }

}
