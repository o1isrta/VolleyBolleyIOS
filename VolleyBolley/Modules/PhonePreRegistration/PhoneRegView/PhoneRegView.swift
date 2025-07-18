import UIKit

class PhoneRegView: UIViewController {
    
    var presenter: PhoneRegPresenterProtocol?
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.Background.blur
        view.layer.cornerRadius = 32
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var titleLabel = CustomTitle(text: "Registration", isLarge: true)
    
    private lazy var phoneNumberLabel = CustomLabel(text: "Your phone number", isBold: true)
    
    private lazy var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "+ With the country code"
        textField.keyboardType = .phonePad
//        textField.borderStyle = .roundedRect
        textField.borderStyle = .none
        
        textField.layer.cornerRadius = 16
        textField.layer.borderWidth = 1
        textField.layer.borderColor = AppColor.Border.primary.cgColor
        textField.backgroundColor = .systemBackground
        textField.textColor = .label
        
        textField.setLeftPaddingPoints(16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let nextButton = NextStepButton(title: "NEXT STEP", initialState: .inactive)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.Background.screen
        setupUI()
        setupActions()
    }
    
    private func setupUI() {
        view.addSubview(containerView)
        containerView.addSubview(backButton)
        containerView.addSubview(titleLabel)
        containerView.addSubview(phoneNumberLabel)
        containerView.addSubview(phoneTextField)
        containerView.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            backButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 22.5),
            backButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 18),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            phoneNumberLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            phoneTextField.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 8),
            phoneTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            phoneTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            phoneTextField.heightAnchor.constraint(equalToConstant: 51),
            
            nextButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 20),
            nextButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            nextButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupActions() {
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextStepTapped), for: .touchUpInside)
    }
    
    @objc private func backTapped() {
        presenter?.didTapBack()
    }
    
    @objc private func nextStepTapped() {
        let phoneNumber = phoneTextField.text ?? ""
        presenter?.didTapNextStep(with: phoneNumber)
    }
}

extension PhoneRegView: PhoneRegViewProtocol {
    
}

@available(iOS 17.0, *)
#Preview {
    PhoneRegView()
}
