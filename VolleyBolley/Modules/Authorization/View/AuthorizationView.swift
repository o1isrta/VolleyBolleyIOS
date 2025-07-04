import UIKit

class AuthorizationView: UIViewController, AuthViewProtocol {
    var presenter: AuthPresenterProtocol?
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign up \nwith\na social\nmedia"
        label.font = AppFont.ActayWide.bold(size: 36)
        label.textColor = AppColor.Text.primary
        label.numberOfLines = 4
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 18
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var phoneAuthButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue with phone number", for: .normal)
        button.titleLabel?.font = AppFont.Hero.regular(size: 18)
        button.setTitleColor(AppColor.Text.inverted, for: .normal)
        button.backgroundColor = AppColor.Background.largeActionButtonDefault
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 54).isActive = true
        return button
    }()
    
    private lazy var googleAuthButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Continue with Google", for: .normal)
        button.titleLabel?.font = AppFont.Hero.regular(size: 18)
        button.setTitleColor(AppColor.Text.inverted, for: .normal)
        button.backgroundColor = .white
        
        if let googleIcon = UIImage(named: "google") {
            button.setImage(googleIcon, for: .normal)
        }
        
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 56).isActive = true
        return button
    }()
    
    private lazy var facebookAuthButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Continue with Facebook", for: .normal)
        button.titleLabel?.font = AppFont.Hero.regular(size: 18)
        button.setTitleColor(AppColor.Text.primary, for: .normal)
        button.backgroundColor = AppColor.Background.fbButton
        if let facebookIcon = UIImage(named: "facebook") {
            button.setImage(facebookIcon, for: .normal)
        }
        
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 56).isActive = true
        return button
    }()
    
    private lazy var buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.Background.tabBar
        view.layer.cornerRadius = 32
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: .launch)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
    }
    
    private func setupUI() {
        view.addSubview(backgroundImageView)
        view.addSubview(descriptionLabel)
        view.addSubview(bottomView)
        
        bottomView.addSubview(buttonsStack)
        
        buttonsStack.addArrangedSubview(phoneAuthButton)
        buttonsStack.addArrangedSubview(googleAuthButton)
        buttonsStack.addArrangedSubview(facebookAuthButton)
           
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 250),
            
            buttonsStack.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 24),
            buttonsStack.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 24),
            buttonsStack.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -24)
        ])
    }
    
    private func setupActions() {
        phoneAuthButton.addTarget(self, action: #selector(phoneTapped), for: .touchUpInside)
        googleAuthButton.addTarget(self, action: #selector(googleTapped), for: .touchUpInside)
        facebookAuthButton.addTarget(self, action: #selector(facebookTapped), for: .touchUpInside)
    }
        
        @objc private func phoneTapped() {
            presenter?.phoneButtonTapped()
        }
        
        @objc private func googleTapped() {
            presenter?.googleButtonTapped()
        }
        
        @objc private func facebookTapped() {
            presenter?.facebookButtonTapped()
        }
    
}

