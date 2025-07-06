import UIKit

class PhoneRegView: UIViewController {
    
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Registration"
        label.font = AppFont.ActayWide.bold(size: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Your phone number"
        label.font = AppFont.Hero.regular(size: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
       
    private lazy var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter phone number"
        textField.keyboardType = .phonePad
        textField.borderStyle = .roundedRect
        textField.placeholder = "+ With the country code"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
       
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT STEP", for: .normal)
        button.titleLabel?.font = AppFont.ActayWide.bold(size: 16)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
         view.backgroundColor = .white
         
         let stackView = UIStackView(arrangedSubviews: [
             titleLabel,
             phoneNumberLabel,
             countryCodeLabel,
             phoneTextField,
             nextButton
         ])
         stackView.axis = .vertical
         stackView.spacing = 16
         stackView.translatesAutoresizingMaskIntoConstraints = false
         
         view.addSubview(stackView)
         
         NSLayoutConstraint.activate([
             stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
             stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
             stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
             
             phoneTextField.heightAnchor.constraint(equalToConstant: 44),
             nextButton.heightAnchor.constraint(equalToConstant: 44)
         ])
     }
     
     @objc private func nextButtonTapped() {
         presenter.nextStepTapped(with: phoneTextField.text)
     }
}

