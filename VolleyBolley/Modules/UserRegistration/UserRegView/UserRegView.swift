import UIKit

class UserRegViewController: UIViewController {
    
    var presenter: UserRegPresenterProtocol!
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private lazy var titleLabel = CustomTitle(text: "Registration", isLarge: true)
    
    private lazy var nameLabel = CustomLabel(text: "Name", isBold: true)
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Anton"
        textField.backgroundColor = AppColor.Border.primary
        textField.layer.cornerRadius = 16
        textField.textColor = AppColor.Text.placeholder
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setLeftPaddingPoints(16)
        return textField
    }()
    
    private lazy var surnameLabel = CustomLabel(text: "Surname", isBold: true)
    private lazy var surnameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Ivanov"
        textField.backgroundColor = AppColor.Border.primary
        textField.layer.cornerRadius = 16
        textField.textColor = AppColor.Text.placeholder
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setLeftPaddingPoints(16)
        return textField
    }()
    private lazy var surnameSeparator = CustomSeparator()
    
    private lazy var genderLabel = CustomLabel(text: "Gender", isBold: true)
    private lazy var maleButton = PickButton(title: "Male", isSelected: true)
    private lazy var femaleButton = PickButton(title: "Female", isSelected: false)
    private lazy var genderSeparator = CustomSeparator()
    
    private lazy var birthdayLabel = CustomLabel(text: "Date of birth", isBold: true)
    private lazy var birthdayTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "__/__/____"
        textField.textAlignment = .center
        textField.backgroundColor = AppColor.Text.primary
        textField.layer.cornerRadius = 16
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numberPad
        return textField
    }()
    private let birthdaySeparator = CustomSeparator()
    
    private lazy var levelLabel = CustomLabel(text: "Level", isBold: true)
    private lazy var lightLevelButton = PickButton(title: "Light", isSelected: true)
    private lazy var mediumLevelButton = PickButton(title: "Medium", isSelected: false)
    private lazy var hardLevelButton = PickButton(title: "Hard", isSelected: false)
    private lazy var proLevelButton = PickButton(title: "pro", isSelected: false)
    private lazy var levelSeparator = CustomSeparator()
    
    private lazy var countryLabel = CustomLabel(text: "Your country", isBold: true)
    
    
    
    private lazy var getStartedButton = NextStepButton(title: "GET STARTED", initialState: .active)
    
    private var selectedGender: String? = "Male"
    private var selectedLevel: String? = "Light"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.Background.screen
        setupScrollView()
        setupUI()
        setupActions()
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
    }
    
    private func setupUI() {
        let subviews = [
            titleLabel, nameLabel, nameTextField,
            surnameLabel, surnameTextField, surnameSeparator,
            genderLabel, maleButton, femaleButton, genderSeparator,
            birthdayLabel, birthdayTextField, birthdaySeparator,
            levelLabel, lightLevelButton, mediumLevelButton, hardLevelButton,
            proLevelButton, levelSeparator, countryLabel, getStartedButton
        ]
        
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            // titleLabel
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            // nameLabel
            nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            // nameTextField
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 51),
            
            // surnameLabel
            surnameLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            surnameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            // surnameTextField
            surnameTextField.topAnchor.constraint(equalTo: surnameLabel.bottomAnchor, constant: 8),
            surnameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            surnameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            surnameTextField.heightAnchor.constraint(equalToConstant: 51),
            
            // surnameSeparator
            surnameSeparator.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 16),
            surnameSeparator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            surnameSeparator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            surnameSeparator.heightAnchor.constraint(equalToConstant: 1),
            
            // genderLabel
            genderLabel.topAnchor.constraint(equalTo: surnameSeparator.bottomAnchor, constant: 16),
            genderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            // maleButton
            maleButton.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 8),
            maleButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            maleButton.widthAnchor.constraint(equalToConstant: 100),
            maleButton.heightAnchor.constraint(equalToConstant: 39),
            
            // femaleButton
            femaleButton.centerYAnchor.constraint(equalTo: maleButton.centerYAnchor),
            femaleButton.leadingAnchor.constraint(equalTo: maleButton.trailingAnchor, constant: 16),
//            femaleButton.widthAnchor.constraint(equalToConstant: 100),
            femaleButton.heightAnchor.constraint(equalToConstant: 39),
            
            // genderSeparator
            genderSeparator.topAnchor.constraint(equalTo: maleButton.bottomAnchor, constant: 16),
            genderSeparator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            genderSeparator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // birthdayLabel
            birthdayLabel.topAnchor.constraint(equalTo: genderSeparator.bottomAnchor, constant: 16),
            birthdayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            // birthdayTextField
            birthdayTextField.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor, constant: 8),
            birthdayTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            birthdayTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -219),
            birthdayTextField.heightAnchor.constraint(equalToConstant: 51),
            
            
            // levelLabel
            levelLabel.topAnchor.constraint(equalTo: birthdayTextField.bottomAnchor, constant: 16),
            levelLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            // lightLevelButton
            lightLevelButton.topAnchor.constraint(equalTo: levelLabel.bottomAnchor, constant: 12),
            lightLevelButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            lightLevelButton.widthAnchor.constraint(equalToConstant: 100),
            lightLevelButton.heightAnchor.constraint(equalToConstant: 39),
            
            // mediumLevelButton
            mediumLevelButton.centerYAnchor.constraint(equalTo: lightLevelButton.centerYAnchor),
            mediumLevelButton.leadingAnchor.constraint(equalTo: lightLevelButton.trailingAnchor, constant: 8),
//            mediumLevelButton.widthAnchor.constraint(equalToConstant: 100),
            mediumLevelButton.heightAnchor.constraint(equalToConstant: 39),
            
            // hardLevelButton
            hardLevelButton.centerYAnchor.constraint(equalTo: mediumLevelButton.centerYAnchor),
            hardLevelButton.leadingAnchor.constraint(equalTo: mediumLevelButton.trailingAnchor, constant: 8),
//            hardLevelButton.widthAnchor.constraint(equalToConstant: 100),
            hardLevelButton.heightAnchor.constraint(equalToConstant: 39),
            
            // proLevelButton
            proLevelButton.centerYAnchor.constraint(equalTo: hardLevelButton.centerYAnchor),
            proLevelButton.leadingAnchor.constraint(equalTo: hardLevelButton.trailingAnchor, constant: 8),
//            proLevelButton.widthAnchor.constraint(equalToConstant: 100),
            proLevelButton.heightAnchor.constraint(equalToConstant: 39),
            
            // levelSeparator
            
            // getStartedButton
            getStartedButton.topAnchor.constraint(equalTo: birthdayTextField.bottomAnchor, constant: 32),
            getStartedButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            getStartedButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            getStartedButton.heightAnchor.constraint(equalToConstant: 50),
            getStartedButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
        ])
    }
    
    private func setupActions() {
        maleButton.addTarget(self, action: #selector(genderButtonTapped(_:)), for: .touchUpInside)
        femaleButton.addTarget(self, action: #selector(genderButtonTapped(_:)), for: .touchUpInside)
        lightLevelButton.addTarget(self, action: #selector(levelButtonTapped(_:)), for: .touchUpInside)
        mediumLevelButton.addTarget(self, action: #selector(levelButtonTapped(_:)), for: .touchUpInside)
        hardLevelButton.addTarget(self, action: #selector(levelButtonTapped(_:)), for: .touchUpInside)
        proLevelButton.addTarget(self, action: #selector(levelButtonTapped(_:)), for: .touchUpInside)
        getStartedButton.addTarget(self, action: #selector(getStartedTapped), for: .touchUpInside)
    }
    
    @objc private func genderButtonTapped(_ sender: PickButton) {
        [maleButton, femaleButton].forEach { $0.updateSelectionState(false) }
        sender.updateSelectionState(true)
        selectedGender = sender.title(for: .normal)
        print("\(selectedGender ?? "") button tapped")
    }
    
    @objc private func levelButtonTapped(_ sender: PickButton) {
        [lightLevelButton, mediumLevelButton, hardLevelButton, proLevelButton].forEach { $0.updateSelectionState(false) }
        sender.updateSelectionState(true)
        selectedLevel = sender.title(for: .normal)
        print("\(selectedLevel ?? "") button tapped")
    }
    
    @objc private func getStartedTapped() {
        let name = nameTextField.text ?? ""
        let surname = surnameTextField.text ?? ""
        let gender = selectedGender ?? ""
        presenter.didTapGetStarted(name: name, surname: surname, gender: gender)
    }
}

extension UserRegViewController: UserRegViewProtocol {}
