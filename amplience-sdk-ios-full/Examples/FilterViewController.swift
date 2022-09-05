//
//  FilterViewController.swift
//  amplience-sdk-ios-full
//
//  Created by Maksym Paidych on 05.07.2022.
//

import UIKit
import Amplience

class FilterViewController: UIViewController {
    
    @IBOutlet private weak var categoryTextField: UITextField!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var sortTextField: UITextField!
    
    private let sortPickerView: ToolbarPickerView = ToolbarPickerView()
    private let categoryPickerView: ToolbarPickerView = ToolbarPickerView()
    
    private let categories = [("Women", "Women"), ("Men", "Men"), ("Kids", "Kids"), ("Beauty", "Beauty"), ("Homewares", "Homewares")]
    private let sortItems = [("ASC", "ASC"), ("DESC", "DESC")]
    private var selectedCategory: String?
    private var selectedSort: String?
    private var filterItems: [FilterContent] = []
    private let cellID = "FilterContentTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
    }
    
    @IBAction func performButtonPressed(_ sender: Any) {
        performGetFilteredContent()
    }
    
    private func configureView() {
        configureCategoryTextField()
        configureSortTextField()
        configureTableView()
    }
    
    private func configureCategoryTextField() {
        categoryPickerView.prepareFor(elements: categories,
                                    selectedIndex: 0)

        categoryPickerView.doneButtonTappedHandler = { [weak self] (index, name, value) in
            self?.categoryTextField.text = name
            self?.categoryTextField.resignFirstResponder()
            self?.selectedCategory = name
        }

        categoryPickerView.cancelButtonTappedHandler = { [weak self] in
            self?.categoryTextField.resignFirstResponder()
        }

        categoryTextField.inputView = categoryPickerView
        categoryTextField.inputAccessoryView = categoryPickerView.toolbar
    }
    
    private func configureSortTextField() {
        sortPickerView.prepareFor(elements: sortItems,
                                    selectedIndex: 0)

        sortPickerView.doneButtonTappedHandler = { [weak self] (index, name, value) in
            self?.sortTextField.text = name
            self?.selectedSort = name
            self?.sortTextField.resignFirstResponder()
        }

        sortPickerView.cancelButtonTappedHandler = { [weak self] in
            self?.sortTextField.resignFirstResponder()
        }

        sortTextField.inputView = sortPickerView
        sortTextField.inputAccessoryView = sortPickerView.toolbar
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
    }
    
    private func performGetFilteredContent() {
        guard let category = selectedCategory else { return }
        
        ContentClient.getInstance.filterContent(filterRequest: FilterContentRequest(filterBy: [FilterBy(path: "/_meta/schema", value: "https://example.com/blog-post-filter-and-sort"), FilterBy(path: "/category", value: category)], sortBy: SortBy(key: "readTime", order: selectedSort == "ASC" ? .ASC : .DESC), page: nil)) { [weak self] response, error in
            
            if let items = response?.responses {
                self?.filterItems = items.map { FilterContent(dict: $0.content) }
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
}

extension FilterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! FilterContentTableViewCell
        
        if indexPath.row < filterItems.count {
            cell.configure(model: filterItems[indexPath.row]) {
                self.tableView.reloadRows(at: [indexPath], with: .none)
            }
        }
        
        return cell
    }
    
}
 
extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
