#if DEBUG
//
//  UIViewPreview.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 03.08.2025.
//

import SwiftUI

struct UIViewPreview<View: UIView>: UIViewRepresentable {
	let view: View

	init(_ builder: @escaping () -> View) {
		view = builder()
	}

	// MARK: - UIViewRepresentable
	func makeUIView(context: Context) -> View {
		return view
	}

	func updateUIView(_ uiView: View, context: Context) {
		uiView.setContentHuggingPriority(.defaultLow, for: .horizontal)
		uiView.setContentHuggingPriority(.defaultLow, for: .vertical)
	}
}
#endif
