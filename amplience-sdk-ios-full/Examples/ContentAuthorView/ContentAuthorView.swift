//
//  ContentAuthorView.swift
//  amplience-sdk-ios-full
//
//  Created by Maksym Paidych on 05.07.2022.
//

import UIKit
import Amplience

class ContentAuthorView: UIView {

    @IBOutlet private var containerView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var avatarImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadView()
    }
    
    func configure(model: ContentAuthor) {
        nameLabel.text = model.name
        
        if let bg = model.avatar?.image {
            let url = AmplienceManager.shared.getImageUrl(image: bg, builder: ImageUrlBuilder())
            ImageLoader.shared.loadImage(urlString: url, completion: { [weak self] image in
                guard let self = self else { return }
                self.avatarImageView.image = image
            })
        }
        
    }
    
    private func loadView() {
        Bundle.main.loadNibNamed("ContentAuthorView", owner: self)
        addSubview(containerView)
        containerView.frame = bounds
        containerView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
