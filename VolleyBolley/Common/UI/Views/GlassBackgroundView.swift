import UIKit

final class GlassBackgroundView: UIView {

    private let cornerRadius: CGFloat = 24

    private let blurView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .systemUltraThinMaterial)
        let view = UIVisualEffectView(effect: blur)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Init
    init() {
        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = AppColor.Background.glass.withAlphaComponent(0.19)
        layer.cornerRadius = cornerRadius
        clipsToBounds = true

        insertSubview(blurView, at: 0)
        setupConstraintsBlurView()

    }

    // MARK: - Constraints
    private func setupConstraintsBlurView() {
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
