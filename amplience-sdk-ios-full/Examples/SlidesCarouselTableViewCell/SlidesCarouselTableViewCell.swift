//
//  SlidesCarouselTableViewCell.swift
//  amplience-sdk-ios-full
//
//  Created by Maksym Paidych on 17.06.2022.
//

import UIKit

class SlidesCarouselTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var slides: [Slide] = []
    private var cellID = "SlideCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        configureCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configure(with slides: [Slide]) {
        self.slides = slides
        collectionView.reloadData()
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
    }
    
}

extension SlidesCarouselTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SlideCollectionViewCell
        if indexPath.item < slides.count {
            cell.configure(with: slides[indexPath.item])
        }
        return cell
    }
    
}

extension SlidesCarouselTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 250)
    }
}
