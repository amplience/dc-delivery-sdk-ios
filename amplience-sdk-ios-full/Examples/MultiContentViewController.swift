//
//  MultiContentViewController.swift
//  amplience-sdk-ios-full
//
//  Created by Maksym Paidych on 17.06.2022.
//

import UIKit
import Amplience

class MultiContentViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private var model: MultiContent = MultiContent()
    private let slidesCellID = "SlideTableViewCell"
    private let carouselCellID = "SlidesCarouselTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        fetchContent()
    }
    
    private func fetchContent() {
        AmplienceManager.shared.getContentByKey(key: "example-content-items") { [weak self] content, error in
            guard let self = self else { return }
            
            if let content = content?.content, let examples = content["examples"]?.value as? [[String: Any]] {
                
                for example in examples {
                    if let slides = example["slides"] as? [[String: Any]] {
                        self.model.slides = slides.map { Slide(dict: $0) }
                    } else if let text = example["text"] as? String {
                        self.model.text = text
                    } else if let video = example["video"] as? [String: Any] {
                    
                    } else {
                        self.model.banner = Banner(dict: example)
                    }
                }
                self.tableView.reloadData()
            }
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: slidesCellID, bundle: nil), forCellReuseIdentifier: slidesCellID)
        tableView.register(UINib(nibName: carouselCellID, bundle: nil), forCellReuseIdentifier: carouselCellID)
    }
    

}

extension MultiContentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row != 2 ? 250 : UITableView.automaticDimension
    }
}

extension MultiContentViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.itemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0, let banner = model.banner {
            let cell = tableView.dequeueReusableCell(withIdentifier: slidesCellID, for: indexPath) as! SlideTableViewCell
            cell.configure(with: banner)
            cell.delegate = self
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: carouselCellID, for: indexPath) as! SlidesCarouselTableViewCell
            cell.configure(with: model.slides)
            
            return cell
        }
        
        let cell = UITableViewCell()
        cell.textLabel?.text = model.text
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}

extension MultiContentViewController: SlideTableViewCellDelegate {
    func didPressAction(with url: URL) {
        UIApplication.shared.open(url)
    }
}
