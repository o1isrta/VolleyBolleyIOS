//
//  AvatarImageView.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 17.07.2025.
//

import UIKit

final class AvatarImageView: UIImageView {

    private enum Constants {
        static let cornerRadius: CGFloat = 23
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

    func configure(with image: UIImage?) {
        guard let image else { return }

        self.image = image
    }

    // MARK: - Private Method

    private func setupView() {
        contentMode = .scaleAspectFill
        layer.cornerRadius = Constants.cornerRadius
        layer.borderWidth = Constants.borderWidth
        layer.borderColor = AppColor.Border.primary.cgColor
        clipsToBounds = true
        image = UIImage(systemName: "person.circle.fill")
        backgroundColor = AppColor.Background.primary
        tintColor = AppColor.Icon.avatar
    }
}
