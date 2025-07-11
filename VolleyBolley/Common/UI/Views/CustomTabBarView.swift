import UIKit

final class CustomTabBarView: UIView {

    // MARK: - Public Properties
    struct TabItem {
        let title: String
        let image: UIImage?
    }

    var onSelectItem: ((Int) -> Void)?

    // MARK: - Private Properties
    private var buttons: [UIButton] = []
    private var items: [TabItem] = []

    private lazy var tabBarStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Initializers
    init(items: [TabItem]) {
        super.init(frame: .zero)
        self.items = items
        setupView()
        setupButtons()

        updateSelection(index: 0)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods
    func updateSelection(index: Int) {
        for (buttonIndex, button) in buttons.enumerated() {
            guard let stack = button.subviews.first(where: { $0 is UIStackView }) as? UIStackView,
                  let label = stack.arrangedSubviews.compactMap({ $0 as? UILabel }).first,
                  let imageView = stack.arrangedSubviews.compactMap({ $0 as? UIImageView }).first else { continue }

            label.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
            imageView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }

            let title = items[buttonIndex].title
            label.text = title
            imageView.image = items[buttonIndex].image

            if buttonIndex == index {
                label.textColor = .clear

                DispatchQueue.main.async {
                    let textGradient = CALayer.makeGradientTextMask(for: label)
                    label.layer.addSublayer(textGradient)

                    let size = imageView.bounds.size == .zero ? CGSize(width: 24, height: 24) : imageView.bounds.size
                    let iconGradient = CALayer.makeGradientIconMask(
                        image: self.items[buttonIndex].image,
                        size: size
                    )
                    imageView.image = nil
                    imageView.layer.addSublayer(iconGradient)
                }
            } else {
                label.textColor = AppColor.Text.primary
            }
        }
    }

    // MARK: - Private Methods
    private func setupView() {
        backgroundColor = AppColor.Background.tabBar
        layer.cornerRadius = 32
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.masksToBounds = true

        addSubview(tabBarStackView)

        setupConstraintsTabBarStackView()
    }

    private func setupButtons() {
        for (index, item) in items.enumerated() {
            let button = createTabButton(title: item.title, image: item.image, index: index)
            buttons.append(button)
            tabBarStackView.addArrangedSubview(button)
        }
    }

    private func createTabButton(
        title: String,
        image: UIImage?,
        index: Int
    ) -> UIButton {
        let button = UIButton(type: .custom)
        button.tag = index

        button.imageView?.transform = .identity
        button.imageView?.contentMode = .center

        let imageView = UIImageView(image: image)
        imageView.tintColor = AppColor.Text.primary
        imageView.contentMode = .scaleAspectFit

        let label = UILabel()
        label.text = title
        label.font = AppFont.Hero.regular(size: 10)
        label.textAlignment = .center
        label.textColor = AppColor.Text.primary

        let stack = UIStackView(arrangedSubviews: [imageView, label])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false

        button.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: button.trailingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24)
        ])

        button.addAction(UIAction { [weak self] _ in
            self?.updateSelection(index: index)
            self?.onSelectItem?(index)
        }, for: .touchUpInside)

        return button
    }

    // MARK: - Constraints
    private func setupConstraintsTabBarStackView() {
        NSLayoutConstraint.activate([
            tabBarStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tabBarStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tabBarStackView.topAnchor.constraint(equalTo: topAnchor),
            tabBarStackView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
