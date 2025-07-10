import UIKit

final class CustomTabBar: UITabBar {

    // MARK: - Properties
    private let shapeLayer = CAShapeLayer()
    private let customHeight: CGFloat = 53
    private var gradientLabels: [UILabel] = []
    private var cachedTitles: [String] = []
//    private let backgroundView = UIView()

    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.height = customHeight
        return size
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        setupRoundedCorners()
        updateGradientLabelFrames()

//        backgroundView.frame = bounds
//        backgroundView.backgroundColor = AppColor.Background.screen
//        if backgroundView.superview == nil {
//            insertSubview(backgroundView, at: 0)
//        }
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let defaultHitTest = super.hitTest(point, with: event)
        return defaultHitTest == nil ? nil : defaultHitTest
    }

    func addGradientLabels(titles: [String]) {
        gradientLabels.forEach { $0.removeFromSuperview() }
        gradientLabels = []
        cachedTitles = titles

        guard let items = self.items else { return }

        for item in items {
            guard let itemView = item.value(forKey: "view") as? UIView else { continue }

            let itemCenter = itemView.center
            let labelWidth = itemView.bounds.width
            let labelHeight: CGFloat = 14
            let spacing: CGFloat = 10

            let labelFrame = CGRect(
                x: itemCenter.x - labelWidth / 2,
                y: itemCenter.y + spacing,
                width: labelWidth,
                height: labelHeight
            )

            let label = UILabel(frame: labelFrame)
            label.backgroundColor = .clear
            label.textAlignment = .center
            addSubview(label)
            gradientLabels.append(label)
        }

        updateLabelStyles(selectedIndex: selectedItemIndex())
    }

    func updateLabelStyles(selectedIndex: Int) {
        for (index, label) in gradientLabels.enumerated() {
            label.layer.sublayers?.forEach { $0.removeFromSuperlayer() }

            if index == selectedIndex {
                label.text = nil

                let gradient = CAGradientLayer.getGradientLayer()
                gradient.frame = label.bounds

                let textLayer = CATextLayer()
                textLayer.string = NSAttributedString(string: cachedTitles[index], attributes: [
                    .font: AppFont.Hero.regular(size: 10)
                ])
                textLayer.frame = label.bounds
                textLayer.contentsScale = UIScreen.main.scale
                textLayer.alignmentMode = .center

                gradient.mask = textLayer
                label.layer.addSublayer(gradient)
            } else {
                label.text = cachedTitles[index]
                label.font = AppFont.Hero.regular(size: 10)
                label.textColor = AppColor.Text.primary
            }
        }
    }

    private func selectedItemIndex() -> Int {
        guard let selectedItem = self.selectedItem, let items = self.items else { return 0 }
        return items.firstIndex(of: selectedItem) ?? 0
    }

    private func setupRoundedCorners() {
        let radius: CGFloat = 32.0
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: radius, height: radius)
        )

        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = AppColor.Background.tabBar.cgColor
        shapeLayer.frame = bounds

        if shapeLayer.superlayer == nil {
            layer.insertSublayer(shapeLayer, at: 0)
        }
    }

    private func updateGradientLabelFrames() {
        guard let items = items, gradientLabels.count == items.count else { return }

        for item in items {
            guard let itemView = item.value(forKey: "view") as? UIView else { continue }

            let itemCenter = itemView.center
            let labelWidth = itemView.bounds.width
            let labelHeight: CGFloat = 14
            let spacing: CGFloat = 10

            _ = UILabel(frame: CGRect(
                x: itemCenter.x - labelWidth / 2,
                y: itemCenter.y + spacing,
                width: labelWidth,
                height: labelHeight
            ))
        }
    }
}
