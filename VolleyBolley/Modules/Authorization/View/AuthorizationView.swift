import UIKit

class AuthorizationView: UIViewController, AuthViewProtocol {
    var presenter: AuthPresenterProtocol!
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign up with a social media"
        label.font = AppFont.ActayWide.bold(size: 36)
        label.textColor = AppColor.Text.primary
        label.numberOfLines = 4
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let phoneAuthButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue with phone number", for: .normal)
        button.titleLabel?.font = AppFont.Hero.regular(size: 18)
        button.setTitleColor(AppColor.Text.inverted, for: .normal)
        button.backgroundColor = AppColor.Background.largeActionButtonDefault
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let googleAuthButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue with Google", for: .normal)
        button.titleLabel?.font = AppFont.Hero.regular(size: 18)
        button.setTitleColor(AppColor.Text.inverted, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let facebookAuthButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue with Facebook", for: .normal)
        button.titleLabel?.font = AppFont.Hero.regular(size: 18)
        button.setTitleColor(AppColor.Text.primary, for: .normal)
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: .launch)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupUI()
//        getStartedButton.addTarget(self, action: #selector(getStartedTapped), for: .touchUpInside)
    }
    
    private func setupUI() {
           view.addSubview(descriptionLabel)
           view.addSubview(phoneAuthButton)
           view.addSubview(googleAuthButton)
           view.addSubview(facebookAuthButton)
           view.addSubview(backgroundImageView)
           
           NSLayoutConstraint.activate([
               backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
               backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
               backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               
               descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
               descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
               descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
               
               logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               logoImageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 40),
               logoImageView.widthAnchor.constraint(equalToConstant: 160),
               logoImageView.heightAnchor.constraint(equalToConstant: 160),
               
               appNameLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 16),
               appNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               
               getStartedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
               getStartedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
               getStartedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
               getStartedButton.heightAnchor.constraint(equalToConstant: 50)
           ])
       }
    
}

