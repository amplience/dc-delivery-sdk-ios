//
//  MenuTableViewController.swift
//  amplience-sdk-ios-full
//
//

import UIKit
import Amplience

class MenuTableViewController: UITableViewController {
    
    private let titles = ["Banner example", "Slides example", "Multi content example", "Filter example"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ContentClient.getInstance.configuration = Configuration(hub: "ampproduct-doc", isFresh: false)

    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuTableViewCell
        
        // Configure the cell...
        cell.mainLabel.text = titles[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0: showBannerVC()
        case 1: showSlidesVC()
        case 2: showMultiContentVC()
        case 3: showFilterVC()
        default: break
        }
        
    }
    
    private func showBannerVC() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "BannerViewController") as! BannerViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showSlidesVC() {
        let vc = storyboard!.instantiateViewController(withIdentifier: "SlidesViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showMultiContentVC() {
        let vc = storyboard!.instantiateViewController(withIdentifier: "MultiContentViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showFilterVC() {
        let vc = storyboard!.instantiateViewController(withIdentifier: "FilterViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
