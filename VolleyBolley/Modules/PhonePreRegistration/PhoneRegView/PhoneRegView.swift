import UIKit

final class PhoneRegView: UIViewController {
    
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
        textField.borderStyle = .none
        
        textField.layer.cornerRadius = 16
        textField.layer.borderWidth = 1
        textField.layer.borderColor = AppColor.Border.primary.cgColor
        textField.backgroundColor = .systemBackground
//        textField.textColor = .label
        textField.textColor = AppColor.Text.placeholder
        
        textField.setLeftPaddingPoints(16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(phoneNumberDidChange), for: .editingChanged)
        return textField
    }()
    
    private let nextButton = NextStepButton(title: "NEXT STEP", initialState: .inactive)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.Background.screen
        setupUI()
        setupActions()
        
        nextButton.setTitle("NEXT STEP", for: .normal)
            nextButton.setState(.inactive)
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
    
    @objc private func phoneNumberDidChange() {
        let phoneNumber = phoneTextField.text ?? ""
        presenter?.phoneNumberDidChange(phoneNumber)
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
    func setNextButtonActive(_ isActive: Bool) {
        nextButton.setState(isActive ? .active : .inactive)
    }
    
    func updateNextButtonTitle(_ title: String) {
        UIView.transition(with: nextButton, duration: 0.3, options: .transitionCrossDissolve) {
            self.nextButton.setTitle(title, for: .normal)
        }
    }
    
    func autoFillCountryCode(_ code: String) {
            if phoneTextField.text?.isEmpty ?? true {
                phoneTextField.text = code
            }
        }
    
    func enableNextButton(_ isEnabled: Bool) {
        nextButton.setState(isEnabled ? .active : .inactive)
    }
}

@available(iOS 17.0, *)
#Preview {
    PhoneRegView()
}
