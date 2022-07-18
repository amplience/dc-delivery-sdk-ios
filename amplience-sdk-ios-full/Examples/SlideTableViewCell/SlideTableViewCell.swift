//
//  SlideTableViewCell.swift
//  amplience-sdk-ios-full
//
//  Created by Maksym Paidych on 15.06.2022.
//

import UIKit
import Amplience

protocol SlideTableViewCellDelegate: AnyObject {
    func didPressAction(with url: URL)
}

class SlideTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var topTitleLabel: UILabel!
    @IBOutlet private weak var bottomTitleLabel: UILabel!
    @IBOutlet private weak var bannerImageView: UIImageView!
    @IBOutlet private weak var actionButton: UIButton!
    @IBOutlet private weak var altTextLabel: UILabel!
    
    weak var delegate: SlideTableViewCellDelegate?
    private var banner: Banner?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction private func actionButtonPressed(_ sender: Any) {
        if let urlString = banner?.link?.url ?? banner?.callToActionUrl, let url = URL(string: urlString) {
            delegate?.didPressAction(with: url)
        }
    }
    
    func configure(with slide: Slide) {
        topTitleLabel.text = slide.headline
        bottomTitleLabel.text = slide.subheading
        
        let url = slide.imageItem.getImageUrl(builder: ImageUrlBuilder())
        ImageLoader.shared.loadImage(urlString: url, completion: { [weak self] image in
            guard let self = self else { return }
            self.bannerImageView.image = image
        })
    }
    
    func configure(with banner: Banner) {
        self.banner = banner
        topTitleLabel.text = banner.headline
        bottomTitleLabel.text = banner.strapline
        actionButton.setTitle(banner.link?.title ?? banner.callToActionText, for: .normal)
        actionButton.isHidden = false
        altTextLabel.text = banner.background?.alt ?? ""
        if let bg = banner.background?.image {
            let url = bg.getImageUrl(builder: ImageUrlBuilder())
            ImageLoader.shared.loadImage(urlString: url, completion: { [weak self] image in
                guard let self = self else { return }
                self.bannerImageView.image = image
            })
        }
    }
}
