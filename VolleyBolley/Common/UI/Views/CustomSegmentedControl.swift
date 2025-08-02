//
//  CustomSegmentedControl.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 04.07.2025.
//

import UIKit

enum SegmentedControlType: CaseIterable {
    case players, games, map

    var segments: [String] {
        switch self {
        case .players: return [String(localized: "All players"), String(localized: "Favorites")]
        case .games: return [String(localized: "My games"), String(localized: "Archive")]
        case .map: return [String(localized: "Map"), String(localized: "List")]
        }
    }
}
/// Custom Segmented Control, replacement of UISegmentedControl
///
/// - Usage example:
/// ```swift
/// private let segmentedControl = CustomSegmentedControl(type: .map)
///
/// override func viewDidLoad() {
///     super.viewDidLoad()
///     ...
///     segmentedControl.segmentChanged = { [weak self] selectedIndex in
///         // do something
///     }
/// }
///
/// ```
public class CustomSegmentedControl: UIView {

    // MARK: - Public Properties

    // Array of segment titles
    public var segments: [String]
    // Currently selected segment index
    public var selectedSegmentIndex: Int = 0 {
        didSet {
            // Update UI when selected index changes
            updateSegmentedControl()
            // Trigger callback when the segment changes
            segmentChanged?(selectedSegmentIndex)
        }
    }
    // Callback for segment change
    public var segmentChanged: ((Int) -> Void)?

    // MARK: - Private Properties

    // Array to hold segment buttons
    private lazy var buttons: [UIButton] = []
    // Selector view to highlight the selected segment
    private lazy var selectorView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.Text.primary
        view.layer.cornerRadius = 16
        return view
    }()

    private lazy var gradientLayer: CAGradientLayer = {
        let view = CALayer.getGradientLayer()
        view.frame = bounds
        view.cornerRadius = 16
        return view
    }()

    // MARK: - Initializers

    init(type: SegmentedControlType) {
        self.segments = type.segments
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    override public func layoutSubviews() {
        super.layoutSubviews()
        // Update gradient layer when resizing
        if let gradientLayer = layer.sublayers?.first(where: { $0 is CAGradientLayer }) {
            gradientLayer.frame = bounds
        }

        updateSegmentedControl()
    }
}

// MARK: - Private Methods

private extension CustomSegmentedControl {

    func setupView() {
		backgroundColor = .clear
		layer.cornerRadius = 16
		layer.masksToBounds = true

        layer.insertSublayer(gradientLayer, at: 0)
        // Save a link to the gradient layer for subsequent updating during resizing
        self.layer.sublayers?.first { $0 is CAGradientLayer }?.removeFromSuperlayer()
        layer.insertSublayer(gradientLayer, at: 0)

        // Create buttons for segments
        buttons = segments.map { createButton(withTitle: $0) }

        addSubviews(selectorView)

        // Create a stack view to arrange buttons horizontally
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        addSubviews(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }

    // Creates a button for a given segment title
    func createButton(withTitle title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(AppColor.Text.inverted, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }

    // Updates the segmented control's UI based on the selected index
    func updateSegmentedControl() {
        let buttonWidth = frame.width / CGFloat(buttons.count) // Calculate button width
        let selectorWidth = buttonWidth - 4 // Calculate selector width with padding
        let selectorHeight: CGFloat = 30 // Selector height
        let selectorX = buttonWidth * CGFloat(selectedSegmentIndex) + 2 // Calculate selector X position
        let selectorY = (frame.height - selectorHeight) / 2 // Center selector vertically

        // Animate the selector's movement
        UIView.animate(withDuration: 0.3) {
            self.selectorView.frame = CGRect(x: selectorX, y: selectorY, width: selectorWidth, height: selectorHeight)
        }
    }

    // Handles button tap and updates the selected index
    @objc func buttonTapped(_ sender: UIButton) {
        guard let index = buttons.firstIndex(of: sender) else { return }
        selectedSegmentIndex = index
    }
}
