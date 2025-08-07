//
//  TimePickerButton.swift
//  VolleyBolley
//
//  Created by Danil Otmakhov on 05.08.2025.
//

import UIKit

final class TimePickerButton: UIButton {
    
    // MARK: - Constants
    
    private enum Constants {
        static let cornerRadius: CGFloat = 16
        static let stackSpacing: CGFloat = 4
    }
    
    // MARK: - Private Properties
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.Text.primary
        label.font = AppFont.Hero.regular(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var periodLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.Text.primary
        label.font = AppFont.Hero.regular(size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [timeLabel, periodLabel])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = Constants.stackSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var glassView: GlassmorphismView = {
        let view = GlassmorphismView()
        view.cornerRadius = Constants.cornerRadius
        view.blurIntensity = 1.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var date: Date? {
        didSet {
            updateLabel()
        }
    }
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        setup()
        updateLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overrides

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 89, height: 45)
    }
    
    // MARK: - Internal Methods
    
    func setDate(_ date: Date) {
        self.date = date
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        layer.cornerRadius = Constants.cornerRadius
        clipsToBounds = true

        [glassView, labelStack].forEach {
            addSubview($0)
        }
        sendSubviewToBack(glassView)
        
        NSLayoutConstraint.activate([
            glassView.topAnchor.constraint(equalTo: topAnchor),
            glassView.bottomAnchor.constraint(equalTo: bottomAnchor),
            glassView.leadingAnchor.constraint(equalTo: leadingAnchor),
            glassView.trailingAnchor.constraint(equalTo: trailingAnchor),
            labelStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            labelStack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func updateLabel() {
        guard let date else {
            timeLabel.text = "_:__"
            periodLabel.text = "PM"
            return
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        let fullTime = formatter.string(from: date)
        
        let components = fullTime.components(separatedBy: " ")
        timeLabel.text = components.first ?? "_:__"
        periodLabel.text = components.last ?? "PM"
    }
    
}

// MARK: - Preview

#if DEBUG
import SwiftUI

@available(iOS 17.0, *)
#Preview {
    TimePickerButton()
}
#endif

