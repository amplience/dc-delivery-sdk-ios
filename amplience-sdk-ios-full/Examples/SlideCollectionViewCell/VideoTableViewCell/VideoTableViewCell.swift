//
//  VideoTableViewCell.swift
//  amplience-sdk-ios-full
//
//  Created by Maksym Paidych on 24.06.2022.
//

import UIKit


import UIKit
import Amplience
 
protocol VideoTableViewCellDelegate: AnyObject {
    func playVideo(_ url: URL)
}

class VideoTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    
    weak var delegate: VideoTableViewCellDelegate?
    private var model: AmplienceVideo?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func playButtonPressed(_ sender: Any) {
        guard let model = model, let url = URL(string: AmplienceManager.shared.getVideoUrl(video: model)) else { return }
        delegate?.playVideo(url)
    }
    
    func configure(with video: AmplienceVideo) {
        self.model = video
        nameLabel.text = video.name
    }
    
}

