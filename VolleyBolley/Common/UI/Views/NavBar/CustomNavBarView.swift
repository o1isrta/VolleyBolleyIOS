import UIKit

final class CustomNavBarView: UIView {

    private enum Constants {
        static let avatarSize: CGFloat = 46
        static let avatarLeading: CGFloat = 8
        static let avatarBottom: CGFloat = -8

        static let nameLabelLeading: CGFloat = 8

        static let navBarCornerRadius: CGFloat = 32
        static let levelViewCornerRadius: CGFloat = 23
        static let levelViewBorderWidth: CGFloat = 1
        static let levelViewSize: CGFloat = 46
        static let levelViewTrailing: CGFloat = -8
        static let levelViewBottom: CGFloat = -8
    }

    // MARK: - Private Properties

    private lazy var avatarImageView = AvatarImageView()

    private lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.font = AppFont.ActayWide.bold(size: 20)
        view.textColor = AppColor.Text.primary
        return view
    }()

    private lazy var levelView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.levelViewCornerRadius
        view.layer.borderWidth = Constants.levelViewBorderWidth
        view.layer.borderColor = AppColor.Border.primary.cgColor
        view.clipsToBounds = true
        return view
    }()

    private lazy var levelLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = AppFont.Quantex.regular(size: 8)
        view.textColor = AppColor.Text.primary
        return view
    }()

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)
        setupView()
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    func configure(with viewModel: NavBarViewModel) {
        avatarImageView.configure(with: viewModel.avatarImage)
        nameLabel.text = viewModel.displayName.capitalized
        levelView.backgroundColor = viewModel.levelColor
        levelLabel.text = viewModel.levelText
    }

    // MARK: - Private Methods

    private func setupView() {
        backgroundColor = AppColor.Background.navBar

        layer.cornerRadius = Constants.navBarCornerRadius
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        layer.masksToBounds = true

        [avatarImageView, nameLabel, levelView, levelLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }

    // MARK: - Layout Setup

    private func setupLayout() {
        setupConstraintsAvatarImageView()
        setupConstraintsNameLabel()
        setupConstraintsLevelView()
    }

    // MARK: - Constraints

    private func setupConstraintsAvatarImageView() {
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.avatarLeading),
            avatarImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.avatarBottom),
            avatarImageView.widthAnchor.constraint(equalToConstant: Constants.avatarSize),
            avatarImageView.heightAnchor.constraint(equalToConstant: Constants.avatarSize)
        ])
    }

    private func setupConstraintsNameLabel() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(
                equalTo: avatarImageView.trailingAnchor,
                constant: Constants.nameLabelLeading
            ),
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor)
        ])
    }

    private func setupConstraintsLevelView() {
        NSLayoutConstraint.activate([
            levelView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.levelViewTrailing),
            levelView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.levelViewBottom),
            levelView.widthAnchor.constraint(equalToConstant: Constants.levelViewSize),
            levelView.heightAnchor.constraint(equalToConstant: Constants.levelViewSize),

            levelLabel.centerXAnchor.constraint(equalTo: levelView.centerXAnchor),
            levelLabel.centerYAnchor.constraint(equalTo: levelView.centerYAnchor)
        ])
    }
}
