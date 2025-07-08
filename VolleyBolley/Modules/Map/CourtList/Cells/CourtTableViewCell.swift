//
//  CourtTableViewCell.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 08.07.2025.
//

import UIKit

class CourtTableViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        
        return stackView
    }()
    
    private lazy var descriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.spacing = 0
        
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold) // TODO
        label.textColor = .label // TODO
        label.translatesAutoresizingMaskIntoConstraints = false // TODO
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light) // TODO
        label.textColor = .secondaryLabel // TODO
        label.translatesAutoresizingMaskIntoConstraints = false // TODO
        return label
    }()
    
    private lazy var distanceContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#516372") // TODO
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false // TODO
        return view
    }()
    
    private lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular) // TODO
        label.textColor = .white  // TODO
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false // TODO
        return label
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configure(with court: CourtModel, distance: Double) {
        titleLabel.text = court.name
        descriptionLabel.text = court.shortDescription
        
        let distanceText: String
        if distance >= 0 {
            distanceText = distance < 1
                ? String(format: "%.0f м", distance * 1000)
                : String(format: "%.1f км", distance)
        } else {
            distanceText = "—"
        }
        
        distanceLabel.text = distanceText
    }
}

// MARK: - Private Methods

private extension CourtTableViewCell {
    
    func setupUI() {
        selectionStyle = .none
        backgroundColor = .systemBackground // TODO
        // description
        [
            titleLabel,
            descriptionLabel,
        ].forEach {
            descriptionStackView.addArrangedSubview($0)
        }
        // distance
        distanceContainer.addSubview(distanceLabel)
        // main elements
        [
            descriptionStackView,
            distanceContainer
        ].forEach {
            mainStackView.addArrangedSubview($0)
        }

        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            // Main stack
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            // Distance container
            distanceContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            distanceContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            // Distance label
            distanceLabel.topAnchor.constraint(equalTo: distanceContainer.topAnchor, constant: 4),
            distanceLabel.leadingAnchor.constraint(equalTo: distanceContainer.leadingAnchor, constant: 8),
            distanceLabel.trailingAnchor.constraint(equalTo: distanceContainer.trailingAnchor, constant: -8),
            distanceLabel.bottomAnchor.constraint(equalTo: distanceContainer.bottomAnchor, constant: -4),
            distanceLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 50),
        ])
    }
}
