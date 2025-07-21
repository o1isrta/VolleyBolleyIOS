//
//  CustomMarkerAnnotationView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 21.07.2025.
//

import MapKit

final class CustomMarkerAnnotationView: MKAnnotationView {

	override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
		super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
		configure()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func configure() {
		image = UIImage(resource: ImageResource.pinGame)
		frame.size = CGSize(width: 30, height: 50)
		centerOffset = CGPoint(x: 0, y: -frame.height/2)
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		frame.size = selected ? CGSize(width: 44, height: 72) : CGSize(width: 30, height: 50)
		centerOffset = CGPoint(x: 0, y: -frame.height/2)
	}
}
