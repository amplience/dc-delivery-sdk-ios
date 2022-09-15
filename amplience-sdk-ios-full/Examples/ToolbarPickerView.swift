//
//  ToolbarPickerView.swift
//  amplience-sdk-ios-full
//
//

import UIKit

class ToolbarPickerView: UIPickerView {
    
    public private(set) var toolbar: UIToolbar?
    
    public var doneButtonTappedHandler: ((Int, String, Any) -> Void)?
    public var cancelButtonTappedHandler: (() -> Void)?
    public var selectedIndexChangedHandler: ((Int, String, Any) -> Void)?
    
    private var elements = [(String, Any)]()
    private var selectedElementIndex: Int = 0
    private var initialElementIndex: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        let toolBar = UIToolbar()
        toolBar.frame = CGRect(x: 0, y: 0, width: frame.width, height: 40)
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneButtonTapped))
        doneButton.tintColor = .systemRed
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelButtonTapped))
        cancelButton.tintColor = .systemRed
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        self.toolbar = toolBar
        
        self.dataSource = self
        self.delegate = self
    }
    
    func prepareFor(elements: [(String, Any)], selectedIndex: Int) {
        self.elements = elements
        self.selectedElementIndex = selectedIndex
        self.initialElementIndex = selectedIndex
        self.reloadAllComponents()
        self.selectRow(selectedIndex, inComponent: 0, animated: false)
    }
    
    @objc func doneButtonTapped() {
        doneButtonTappedHandler?(selectedElementIndex, elements[selectedElementIndex].0, elements[selectedElementIndex].1)
    }
    
    @objc func cancelButtonTapped() {
        selectedElementIndex = initialElementIndex
        selectedIndexChangedHandler?(initialElementIndex, elements[initialElementIndex].0, elements[initialElementIndex].1)
        cancelButtonTappedHandler?()
    }
}

extension ToolbarPickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        elements.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        elements[row].0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedElementIndex = row
        selectedIndexChangedHandler?(selectedElementIndex, elements[selectedElementIndex].0, elements[selectedElementIndex].1)
    }
}
