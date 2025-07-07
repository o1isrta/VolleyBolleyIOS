import UIKit

class PhoneRegView: UIViewController {
    
    var presenter: PhoneRegPresenterProtocol?
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
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
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Registration"
        label.font = AppFont.ActayWide.bold(size: 24)
        label.textColor = AppColor.Text.primary
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
        textField.placeholder = "+ With the country code"
        textField.keyboardType = .phonePad
        textField.borderStyle = .roundedRect
        
        textField.layer.cornerRadius = 16
           textField.layer.borderWidth = 1
//        textField.layer.borderColor = AppColor.Border.primary
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
//    private lazy var nextButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("NEXT STEP", for: .normal)
//        button.titleLabel?.font = AppFont.ActayWide.bold(size: 16)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    
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
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            backButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            backButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            phoneNumberLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            
            phoneTextField.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 8),
            phoneTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            phoneTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            phoneTextField.heightAnchor.constraint(equalToConstant: 50),
            
            nextButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 16),
            nextButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -24)
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
