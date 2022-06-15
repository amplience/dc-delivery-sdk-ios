//
//  SlideTableViewCell.swift
//  amplience-sdk-ios-full
//
//  Created by Maksym Paidych on 15.06.2022.
//

import UIKit
import Amplience

class SlideTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var topTitleLabel: UILabel!
    @IBOutlet private weak var bottomTitleLabel: UILabel!
    @IBOutlet private weak var bannerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configure(with slide: Slide) {
        topTitleLabel.text = slide.headline
        bottomTitleLabel.text = slide.subheading
        
        let url = AmplienceManager.shared.getImageUrl(image: slide.imageItem, builder: ImageUrlBuilder())
        ImageLoader.shared.loadImage(urlString: url, completion: { [weak self] image in
            guard let self = self else { return }
            self.bannerImageView.image = image
        })
    }
}
