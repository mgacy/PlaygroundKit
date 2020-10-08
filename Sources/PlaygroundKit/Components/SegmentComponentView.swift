//
//  X.swift
//  PlaygroundKit
//
//  Created by Mathew Gacy on 10/7/20.
//  Copyright © 2020 Mathew Gacy. All rights reserved.
//

import UIKit

// TODO: add optional method to convert segmentItems to titles?

public class SegmentComponentView<T>: UIView {

    public private(set) var segmentItems: [T] = [] // TODO: rename `segmentValues`?
    //var segmentTitles: [String] = []

    //public private(set) var value: T

    public var componentHandler: ((T) -> Void)?

    public var selectedSegmentIndex: Int {
        get {
            return segmentControl.selectedSegmentIndex
        }
        set {
            // FIXME: handle invalid value
            guard 0...segmentItems.count ~= newValue else { return }
            segmentControl.selectedSegmentIndex = newValue
            let value = segmentItems[newValue]
            componentHandler?(value)
        }
    }

    // MARK: - Appearance

    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    public var value: String? {
        didSet {
            valueLabel.text = value
        }
    }

    // MARK: - Subviews

    private lazy var segmentControl: UISegmentedControl = {
        let view = UISegmentedControl()
        view.addTarget(self, action: #selector(didChangeValue(_:)), for: .valueChanged)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let valueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var labelStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        view.axis = .horizontal
        view.alignment = .firstBaseline
        view.distribution = .fillEqually // ?
        view.spacing = 8.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override public var intrinsicContentSize: CGSize {
        let labelWidth = labelStackView.intrinsicContentSize.width      // -1
        let labelHeight = labelStackView.intrinsicContentSize.height    // -1
        let segmentHeight = segmentControl.intrinsicContentSize.height  // 31
        return CGSize(width: labelWidth, height: labelHeight + segmentHeight)
    }

    // MARK: - Lifecycle

    public convenience init?(segmentItems: [T], segmentTitles: [String]) {
        self.init(frame: CGRect.zero)
        self.segmentItems = segmentItems
        //self.segmentTitles = segmentTitles

        do {
            try updateItems(with: segmentItems, titles: segmentTitles, animated: false)
        } catch {
            return nil
        }
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    private func configure() {
        addSubview(labelStackView)

        // TESTING:
        //titleLabel.backgroundColor = .cyan
        //valueLabel.backgroundColor = .magenta
        //backgroundColor = .red

        addSubview(segmentControl)
        setupConstraints()
    }

    private func setupConstraints() {
        let spacing: CGFloat = 8.0
        NSLayoutConstraint.activate([
            // labelStackView
            labelStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
            labelStackView.topAnchor.constraint(equalTo: topAnchor, constant: spacing),
            labelStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing),

            // segmentControl
            segmentControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
            segmentControl.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: spacing),
            segmentControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing)
        ])
    }

    // TODO: add relativeWidthContstraint
    // TODO: update constraint once set
    public var relativeTitleWidth: CGFloat = 0.5

    private func setupConstraints2() {
        let spacing: CGFloat = 8.0
        NSLayoutConstraint.activate([
            // titleLabel
             titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
             titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: spacing),
             //titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing),
             titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: relativeTitleWidth, constant: -spacing),

            // valueLabel
            //valueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
            valueLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: spacing),
            valueLabel.topAnchor.constraint(equalTo: topAnchor, constant: spacing),
             valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing),
            // segmentControl
            segmentControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
            segmentControl.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: spacing),
            segmentControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing)
        ])
    }

    // MARK: - B

    @objc private func didChangeValue(_ sender: UISegmentedControl) {
        let idx = sender.selectedSegmentIndex
        print("Selected Segment Index: \(idx)")
        let value = segmentItems[idx]
        componentHandler?(value)
    }

    // MARK: - C

    // TODO: add optional parameter to set selected index?
    // TODO: if selected index not given but there was already one, should we restore that selection?
    public func updateItems(with newItems: [T], titles: [String], animated: Bool = false) throws  {
        guard newItems.count == titles.count else {
            throw SegmentComponentViewError.itemCountMismatch
        }
        segmentControl.removeAllSegments()

        segmentItems = newItems
        //segmentTitles = titles

        for (idx, title) in titles.enumerated() {
            segmentControl.insertSegment(withTitle: title, at: idx, animated: animated)
        }
    }
}

// MARK: - Support CustomStringConvertible
extension SegmentComponentView where T: CustomStringConvertible {

    public convenience init(items: [T]) {
        self.init(frame: CGRect.zero)
        updateItems(with: items)
    }

    // TODO: add optional parameter to set selected index?
    // TODO: if selected index not given but there was already one, should we restore that selection?
    public func updateItems(with newItems: [T], animated: Bool = true) {
        segmentControl.removeAllSegments()
        segmentItems = newItems
        for (idx, item) in newItems.enumerated() {
            segmentControl.insertSegment(withTitle: item.description, at: idx, animated: animated)
        }
    }
}

// MARK: - Internal Types
extension SegmentComponentView {
    public enum SegmentComponentViewError: Error, CustomStringConvertible {
        case itemCountMismatch
        case unknown(message: String)

        public var description: String {
            switch self {
            case .itemCountMismatch:
                return "Count of items must match that of titles"
            case .unknown(let message):
                return message
            }
        }
    }
}
