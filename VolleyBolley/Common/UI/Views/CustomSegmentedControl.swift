//
//  CustomSegmentedControl.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 04.07.2025.
//

import UIKit
/// Custom Segmented Control, replacement of UISegmentedControl
///
/// - Usage example:
/// ```swift
/// private let segmentedControl = CustomSegmentedControl(items: ["Map", "List"])
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
    private var buttons: [UIButton] = []
    // Selector view to highlight the selected segment
    private var selectorView: UIView!
    
    // MARK: - Initializers
    
    // Initializer to create the control with given segments
    public init(items: [String]) {
        self.segments = items
        super.init(frame: .zero)
        setupView()
    }
    
    // Required initializer (not used here)
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
    
    // Sets up the view's UI elements and layout
    func setupView() {
        // Set background color and corner radius
        backgroundColor = AppColor.Text.primary
        
        let gradientLayer = CALayer.getGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = 16
        layer.insertSublayer(gradientLayer, at: 0)
        
        // Save a link to the gradient layer for subsequent updating during resizing
        self.layer.sublayers?.first { $0 is CAGradientLayer }?.removeFromSuperlayer()
        layer.insertSublayer(gradientLayer, at: 0)

        // Create buttons for segments
        buttons = segments.map { createButton(withTitle: $0) }

        // Initialize the selector view
        selectorView = UIView()
        selectorView.backgroundColor = AppColor.Text.primary
        selectorView.layer.cornerRadius = 16
        addSubviews(selectorView)

        // Create a stack view to arrange buttons horizontally
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal // Arrange buttons horizontally
        stackView.alignment = .fill // Fill alignment
        stackView.distribution = .fillEqually // Equal button distribution
        addSubviews(stackView)
        
        // Enable Auto Layout for stack view
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
        button.setTitle(title, for: .normal) // Set button title
        button.setTitleColor(AppColor.Text.inverted, for: .normal) // Set default text color
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside) // Add tap action
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

@available(iOS 17.0, *)
#Preview {
    CustomSegmentedControl(items: ["Map", "List"])
}
