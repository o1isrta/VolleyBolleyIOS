import UIKit

class OnboardingViewController: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome!"
        label.font = AppFont.ActayWide.bold(size: 36)
        label.textColor = AppColor.Text.primary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "This app helps you find beach volleyball games and match with players at your skill level."
        label.font = AppFont.Hero.regular(size: 20)
        label.textColor = AppColor.Text.primary
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage.vbLogo)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
        
    private let appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "VOLLEYBOLLEY"
        label.font = AppFont.ActayWide.bold(size: 36)
        label.textColor = AppColor.Text.primary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
        private let getStartedButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("GET STARTED", for: .normal)
            button.backgroundColor = UIColor(red: 1, green: 0.84, blue: 0, alpha: 1) // желтый
            button.setTitleColor(.black, for: .normal)
            button.layer.cornerRadius = 8
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()

        private let backgroundImageView: UIImageView = {
            let imageView = UIImageView(image: .launchScreen)
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
}

