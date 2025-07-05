import UIKit

final class CustomNavBarView: UIView {

    // MARK: - UI Elements
    private lazy var photoImageView: UIImageView = {
        let view = UIImageView()
        view.image = .imgPerson
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 23
        view.layer.borderWidth = 1
        view.layer.borderColor = AppColor.Border.primary.cgColor
        view.clipsToBounds = true
        return view
    }()

    private lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.text = "artem".capitalized
        view.font = AppFont.ActayWide.bold(size: 20)
        view.textColor = AppColor.Text.primary
        return view
    }()

    private lazy var rankView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.Background.levelBadgeLight
        view.layer.cornerRadius = 23
        view.layer.borderWidth = 1
        view.layer.borderColor = AppColor.Border.primary.cgColor
        view.clipsToBounds = true
        return view
    }()

    private lazy var rankLabel: UILabel = {
        let view = UILabel()
        view.text = "Light".uppercased()

        view.textAlignment = .center
        view.font = AppFont.Quantex.regular(size: 8)
        view.textColor = AppColor.Text.primary
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupLayout()
    }

    private func setupView() {
        backgroundColor = AppColor.Background.navBar

        layer.cornerRadius = 32
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        layer.masksToBounds = true

        [photoImageView, nameLabel, rankView, rankLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }

    // MARK: - Layout
    private func setupLayout() {
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            photoImageView.widthAnchor.constraint(equalToConstant: 46),
            photoImageView.heightAnchor.constraint(equalToConstant: 46),

            nameLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 8),
            nameLabel.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor),

            rankView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            rankView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            rankView.widthAnchor.constraint(equalToConstant: 46),
            rankView.heightAnchor.constraint(equalToConstant: 46),

            rankLabel.centerXAnchor.constraint(equalTo: rankView.centerXAnchor),
            rankLabel.centerYAnchor.constraint(equalTo: rankView.centerYAnchor)
        ])
    }
}
