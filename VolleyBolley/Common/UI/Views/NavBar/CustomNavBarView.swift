import UIKit

final class CustomNavBarView: UIView {

    private enum Constants {
        static let avatarSize: CGFloat = 46
        static let avatarLeading: CGFloat = 8
        static let avatarBottom: CGFloat = -8

        static let nameLabelLeading: CGFloat = 8

        static let navBarCornerRadius: CGFloat = 32
        static let levelViewTrailing: CGFloat = -8
        static let levelViewBottom: CGFloat = -8
    }

    // MARK: - Private Properties

    private lazy var avatarImageView = AvatarImageView()
    private lazy var levelView = LevelBadgeView()

    private lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.font = AppFont.ActayWide.bold(size: 20)
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
        levelView.configure(with: viewModel.level)
    }

    // MARK: - Private Methods

    private func setupView() {
        backgroundColor = AppColor.Background.navBar

        layer.cornerRadius = Constants.navBarCornerRadius
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        layer.masksToBounds = true

        [avatarImageView, nameLabel, levelView].forEach {
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
            levelView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.levelViewBottom)
        ])
    }
}
