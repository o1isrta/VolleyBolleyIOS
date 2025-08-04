import UIKit
//
//final class CreateGameButton: UIControl {
//
//    // MARK: - Subviews
//
//    private let backgroundView = AppEffect.glass
//
//    private lazy var titleLabel: UILabel = {
//        let view = UILabel()
//        view.text = "Create a new game"
//        view.font = AppFont.ActayWide.bold(size: 24)
//        view.textColor = AppColor.Text.primary
//        return view
//    }()
//
//    private lazy var locationIcon: UIImageView = {
//        let view = UIImageView()
//        view.image = UIImage(systemName: "location.fill")
//        view.tintColor = AppColor.Icon.location
//        view.contentMode = .scaleAspectFit
//        return view
//    }()
//
//    private lazy var clubNameLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Karon Beach Club"
//        label.font = AppFont.Hero.bold(size: 16)
//        label.textColor = AppColor.Text.primary
//        return label
//    }()
//
//    private lazy var addressLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Patak Rd, Mueang Phuket"
//        label.font = AppFont.Hero.light(size: 14)
//        label.textColor = AppColor.Text.primary.withAlphaComponent(0.85)
//        return label
//    }()
//
//    private lazy var weatherIcon: UIImageView = {
//        let view = UIImageView()
//        view.image = UIImage(systemName: "cloud.sun")
//        view.tintColor = AppColor.Icon.primary
//        view.contentMode = .scaleAspectFit
//        return view
//    }()
//
//    private lazy var temperatureLabel: UILabel = {
//        let label = UILabel()
//        label.text = "26°C"
//        label.font = AppFont.ActayWide.bold(size: 16)
//        label.textColor = AppColor.Text.primary
//        return label
//    }()
//
//    // MARK: - Init
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupViews()
//        setupLayout()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // MARK: - Setup
//
//    private func setupViews() {
//        backgroundColor = .clear
//        layer.cornerRadius = 32
//        clipsToBounds = true
//
//        [backgroundView, titleLabel, locationIcon, clubNameLabel, addressLabel, weatherIcon, temperatureLabel].forEach {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            addSubview($0)
//        }
//    }
//
//    // MARK: - Layout Setup
//
//    private func setupLayout() {
//        setupConstraintsView()
//        setupConstraintsBackgroundView()
//        setupConstraintsTitleLabel()
//        setupConstraintsLocationIcon()
//        setupConstraintsClubNameLabel()
//        setupConstraintsAddressLabel()
//        setupConstraintsWeatherIcon()
//        setupConstraintsTemperatureLabel()
//    }
//
//    // MARK: - Constraints
//    
//    private func setupConstraintsView() {
//        NSLayoutConstraint.activate([
//            heightAnchor.constraint(equalToConstant: 116)
//        ])
//    }
//
//    private func setupConstraintsBackgroundView() {
//        NSLayoutConstraint.activate([
//            backgroundView.topAnchor.constraint(equalTo: topAnchor),
//            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor)
//        ])
//    }
//
//    private func setupConstraintsTitleLabel() {
//        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
//            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
//            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -20)
//        ])
//    }
//
//    private func setupConstraintsLocationIcon() {
//        NSLayoutConstraint.activate([
//            locationIcon.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
//            locationIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
//            locationIcon.widthAnchor.constraint(equalToConstant: 16),
//            locationIcon.heightAnchor.constraint(equalToConstant: 16)
//        ])
//    }
//
//    private func setupConstraintsClubNameLabel() {
//        NSLayoutConstraint.activate([
//            clubNameLabel.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor, constant: 8),
//            clubNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 18)
//        ])
//    }
//
//    private func setupConstraintsAddressLabel() {
//        NSLayoutConstraint.activate([
//            addressLabel.topAnchor.constraint(equalTo: clubNameLabel.bottomAnchor, constant: 2),
//            addressLabel.leadingAnchor.constraint(equalTo: clubNameLabel.leadingAnchor)
//        ])
//    }
//
//    private func setupConstraintsWeatherIcon() {
//        NSLayoutConstraint.activate([
//            weatherIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
//            weatherIcon.centerYAnchor.constraint(equalTo: clubNameLabel.centerYAnchor),
//            weatherIcon.widthAnchor.constraint(equalToConstant: 24),
//            weatherIcon.heightAnchor.constraint(equalToConstant: 24)
//        ])
//    }
//
//    private func setupConstraintsTemperatureLabel() {
//        NSLayoutConstraint.activate([
//            temperatureLabel.leadingAnchor.constraint(equalTo: weatherIcon.trailingAnchor, constant: 4),
//            temperatureLabel.centerYAnchor.constraint(equalTo: weatherIcon.centerYAnchor)
//        ])
//    }
//}
