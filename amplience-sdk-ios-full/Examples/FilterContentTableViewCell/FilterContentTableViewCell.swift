//
//  FilterContentTableViewCell.swift
//  amplience-sdk-ios-full
//
//  Created by Maksym Paidych on 05.07.2022.
//

import UIKit
import Amplience

class FilterContentTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var contentTitleLabel: UILabel!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var rankLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var imageTopLabel: UILabel!
    @IBOutlet private weak var bannerImageView: UIImageView!
    @IBOutlet private weak var authorsStackView: UIStackView!
    @IBOutlet private weak var authorsContainerStackView: UIStackView!
    
    private let authorViewHeight: CGFloat = 70
    private let spacing: CGFloat = 5
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(model: FilterContent, completion: () -> Void) {
        contentTitleLabel.text = model.title
        categoryLabel.text = model.category
        dateLabel.text = model.date
        rankLabel.text = "\(model.ranking ?? 0)"
        descriptionLabel.text = model.description
        
        imageTopLabel.text = model.image?.image.name
        if let bg = model.image?.image {
            let url = AmplienceManager.shared.getImageUrl(image: bg, builder: ImageUrlBuilder())
            ImageLoader.shared.loadImage(urlString: url, completion: { [weak self] image in
                guard let self = self else { return }
                self.bannerImageView.image = image
            })
        }
        
        authorsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for author in model.authors {
            let authorView = ContentAuthorView()
            authorView.frame.size.height = authorViewHeight
            authorView.configure(model: author)
            authorsStackView.addArrangedSubview(authorView)
        }
        
       completion()
    }
    
}
