//
//  AvatarImageView.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 17.07.2025.
//

import UIKit

final class AvatarImageView: UIImageView {

	// MARK: - Private Properties

    private enum Constants {
        static let borderWidth: CGFloat = 1
    }

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    convenience init() {
        self.init(frame: .zero)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	// MARK: - Public Method

	override func layoutSubviews() {
		super.layoutSubviews()
		layer.cornerRadius = min(bounds.width, bounds.height) / 2
		clipsToBounds = true
	}

    func configure(with image: UIImage?) {
        guard let image else { return }

        self.image = image
    }

    // MARK: - Private Method

    private func setupView() {
        contentMode = .scaleAspectFill
        layer.borderWidth = Constants.borderWidth
        layer.borderColor = AppColor.Border.primary.cgColor
        image = UIImage.Icon.profile
        backgroundColor = AppColor.Background.primary
        tintColor = AppColor.Icon.avatar
    }
}
