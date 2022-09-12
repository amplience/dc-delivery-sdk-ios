//
//  SlidesViewController.swift
//  amplience-sdk-ios-full
//
//

import UIKit
import Amplience

class SlidesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let cellID = "SlideTableViewCell"
    private var slides: [Slide] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchSlides()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
    }
    
    private func fetchSlides() {
        ContentClient.getInstance.getContentById(id: "bd89c2ed-0ed5-4304-8c89-c0710af500e2") { [weak self] content, error in
            guard let self = self else { return }
            
            if let content = content, let slides = content.content["slides"]?.value as? [[String: Any]] {
                self.slides = slides.map { Slide(dict: $0) }
                self.tableView.reloadData()
            }
        }
    }

}

extension SlidesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return slides.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! SlideTableViewCell
        
        if indexPath.row < slides.count {
            cell.configure(with: slides[indexPath.row])
        }
        
        return cell
    }
}

extension SlidesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
