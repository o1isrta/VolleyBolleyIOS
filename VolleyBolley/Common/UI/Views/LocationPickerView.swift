import UIKit

class LocationPickerView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: - Public Properties
    
    private var items: [String]
    
    var selectedItem: String? {
        return textField.text
    }
    
    // MARK: - UI Elements
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Choose your location"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 16
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .left
        textField.setLeftPaddingPoints(16)
        return textField
    }()
    
    private let pickerView = UIPickerView()
    
    // MARK: - Init
    
    init(items: [String], placeholder: String = "Choose your location") {
        self.items = items
        super.init(frame: .zero)
        
        textField.placeholder = placeholder
        if let first = items.first {
            textField.text = first
        }
        
        setupView()
        setupPicker()
    }
    
    required init?(coder: NSCoder) {
        self.items = []
        super.init(coder: coder)
        setupView()
        setupPicker()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupPicker() {
        pickerView.delegate = self
        pickerView.dataSource = self
        
        textField.inputView = pickerView
        
        // Toolbar Done
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        textField.inputAccessoryView = toolbar
    }
    
    // MARK: - Actions
    
    @objc private func donePressed() {
        textField.resignFirstResponder()
    }
    
    // MARK: - UIPickerView Delegate & DataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        items[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = items[row]
    }
}
