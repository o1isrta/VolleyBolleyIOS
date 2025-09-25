//
//  TableViewSupport.swift
//  VolleyBolley
//
//  Created by Вадим on 25.09.2025.
//

import UIKit

final class IntrinsicTableView: UITableView {
    override var contentSize: CGSize {
        didSet { invalidateIntrinsicContentSize() }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
