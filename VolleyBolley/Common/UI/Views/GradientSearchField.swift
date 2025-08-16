import UIKit

enum GradientSearchFieldType: CaseIterable {
	case search, searchTeams

	var description: String {
		switch self {
		case .search: return String(localized: "Search")
		case .searchTeams: return String(localized: "Search teams or players")
		}
	}
}

class GradientSearchField: UISearchTextField {

	// MARK: - Private Properties

	private let typePlaceholder: GradientSearchFieldType

	private let cornerRadius: CGFloat = 16.0
	private let borderWidth: CGFloat = 1.0
	private let padding: CGFloat = 4.0

	private lazy var gradientBorderLayer: CAGradientLayer = {
		let gradientLayer = CAGradientLayer.getGradientLayer()
		gradientLayer.cornerRadius = cornerRadius
		return gradientLayer
	}()

	private lazy var backgroundLayer: CALayer = {
		let layer = CALayer()
		layer.backgroundColor = AppColor.Background.primary.cgColor
		layer.cornerRadius = cornerRadius
		return layer
	}()

	private lazy var backgroundMaskLayer: CAShapeLayer = {
		let maskLayer = CAShapeLayer()
		maskLayer.fillColor = AppColor.Background.primary.cgColor
		return maskLayer
	}()

	private lazy var searchIconView: UIImageView = {
		let image = UIImage(systemName: "magnifyingglass")
		let imageView = UIImageView(image: image)
		imageView.tintColor = AppColor.Icon.searField
		imageView.contentMode = .scaleAspectFit
		imageView.frame = CGRect(x: padding, y: 1, width: 20, height: 20)
		imageView.transform = CGAffineTransform(scaleX: -1, y: 1)
		return imageView
	}()

	private lazy var searchIconContainer: UIView = {
		let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
		view.addSubview(searchIconView)
		return view
	}()

	private lazy var maskLayer: CAShapeLayer = {
		let maskLayer = CAShapeLayer()
		maskLayer.lineWidth = borderWidth
		maskLayer.strokeColor = AppColor.Border.primary.cgColor
		maskLayer.fillColor = UIColor.clear.cgColor
		return maskLayer
	}()

	// MARK: - Initializers

	init(type: GradientSearchFieldType) {
		typePlaceholder = type
		super.init(frame: .zero)
		setup()
	}

	init(type: GradientSearchFieldType, frame: CGRect) {
		self.typePlaceholder = type
		super.init(frame: frame)
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public Methods

	override func layoutSubviews() {
		super.layoutSubviews()
		updateGradientBorder()
		updateBackgroundLayer()
	}

	override func textRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.inset(by: UIEdgeInsets(
			top: borderWidth,
			left: padding * 4 + 24 + borderWidth,
			bottom: borderWidth,
			right: padding + 24 + borderWidth
		))
	}

	override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
		return textRect(forBounds: bounds)
	}

	override func editingRect(forBounds bounds: CGRect) -> CGRect {
		return textRect(forBounds: bounds)
	}

	override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
		var rect = super.leftViewRect(forBounds: bounds)
		rect.origin.x += padding / 2 + borderWidth
		return rect
	}

	override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
		var rect = super.rightViewRect(forBounds: bounds)
		rect.origin.x -= padding / 2 + borderWidth
		return rect
	}

	override var intrinsicContentSize: CGSize {
		var size = super.intrinsicContentSize
		size.height = 44 + 2 * borderWidth
		return size
	}
}

// MARK: - Private Methods

private extension GradientSearchField {

	func setup() {
		configureAppearance()
		configureSearchIcon()
		configureClearButton()
		setupGradientBorder()
		setupBackgroundLayer()
	}

	func configureAppearance() {
		font = AppFont.Hero.regular(size: 14)
		placeholder = typePlaceholder.description
		textColor = AppColor.Text.inverted
		borderStyle = .none
		backgroundColor = .clear
		autocorrectionType = .no
		clipsToBounds = false

		let placeholderAttributes: [NSAttributedString.Key: Any] = [
			.foregroundColor: AppColor.Text.placeHolder,
			.font: AppFont.Hero.light(size: 14)
		]
		attributedPlaceholder = NSAttributedString(
			string: typePlaceholder.description,
			attributes: placeholderAttributes
		)
	}

	func configureSearchIcon() {
		leftView = searchIconContainer
		leftViewMode = .always
	}

	func updateGradientBorder() {
		// Increase the area for the border on all sides
		let borderBounds = CGRect(
			x: 0,
			y: 0,
			width: bounds.width + 2 * borderWidth,
			height: bounds.height + 2 * borderWidth
		)
		gradientBorderLayer.frame = borderBounds
		// Create path for border
		let borderPath = UIBezierPath(
			roundedRect: borderBounds.insetBy(dx: borderWidth/2, dy: borderWidth/2),
			byRoundingCorners: .allCorners,
			cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
		)
		// Create mask for gradient
		maskLayer.path = borderPath.cgPath
		gradientBorderLayer.mask = maskLayer
	}

	func setupGradientBorder() {
		layer.insertSublayer(gradientBorderLayer, at: 0)
	}

	private func setupBackgroundLayer() {
		// Place between gradientBorderLayer and content
		layer.insertSublayer(backgroundLayer, at: 0)
	}

	private func updateBackgroundLayer() {
		let backgroundBounds = CGRect(
			x: 0,
			y: 0,
			width: bounds.width + 1,
			height: bounds.height + 2
		)
		backgroundLayer.frame = backgroundBounds
		// Create path for border
		let borderPath = UIBezierPath(
			roundedRect: backgroundBounds.insetBy(dx: borderWidth/2, dy: borderWidth/2),
			byRoundingCorners: .allCorners,
			cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
		)
		// Create mask for gradient
		backgroundMaskLayer.path = borderPath.cgPath
		backgroundLayer.mask = backgroundMaskLayer
	}

	func configureClearButton() {
		clearButtonMode = .whileEditing
		if let clearButton = value(forKey: "_clearButton") as? UIButton {
			clearButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
			clearButton.tintColor = AppColor.Icon.searField
		}
	}
}

// MARK: - Preview

#if DEBUG
@available(iOS 17.0, *)
#Preview {
	let field = GradientSearchField(type: .searchTeams)
	field.translatesAutoresizingMaskIntoConstraints = false

	let container = UIView()
	container.backgroundColor = .lightGray
	container.addSubview(field)

	NSLayoutConstraint.activate([
		field.topAnchor.constraint(equalTo: container.topAnchor, constant: 100),
		field.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
		field.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
		field.heightAnchor.constraint(equalToConstant: 44)
	])

	return container
}
#endif
