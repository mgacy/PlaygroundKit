//
//  SliderComponentView.swift
//  PlaygroundKit
//
//  Created by Mathew Gacy on 10/7/20.
//  Copyright © 2020 Mathew Gacy. All rights reserved.
//

import UIKit

//@available(iOS 13.0, *)
public class SliderComponentView: UIView {
    public typealias ValueHandlerBlock = (Float) -> Void

    public var sliderDidChangeHandler: ValueHandlerBlock?

    public let minimumValue: Float
    public let maximumValue: Float

    // FIXME: the following was causing autolayout issues when changing values
//    public var minimumValue: Float = -100.0 {
//        didSet {
//            sliderControl.minimumValue = minimumValue
//        }
//    }
//
//    public var maximumValue: Float = 100.0 {
//        didSet {
//            sliderControl.maximumValue = maximumValue
//        }
//    }

    public var isContinuous: Bool = false {
        didSet {
            sliderControl.isContinuous = isContinuous
        }
    }

    public var value: Float {
        get {
            return sliderControl.value
        }
        set {
            // TODO: handle value outside minimumValue / maximumValue
            sliderControl.value = newValue
            valueLabel.text =  String(format: "%.2f", sliderControl.value)
            sliderDidChangeHandler?(sliderControl.value)
        }
    }

    public var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }

    // MARK: Appearance

    public var labelColor: UIColor = .label {
        didSet {
            valueLabel.textColor = labelColor
        }
    }

    // MARK: Subviews

    // TODO: Add cardView

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var sliderControl: UISlider = {
        let control = UISlider()
        control.minimumValue = minimumValue
        control.maximumValue = maximumValue
        control.isContinuous = isContinuous // Fix slow rendering
        control.addTarget(self, action: #selector(sliderValueDidChange(_:)), for: .valueChanged)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()

    private lazy var labelStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        view.axis = .horizontal
        view.distribution = .fillEqually // or .fill
        view.spacing = UIStackView.spacingUseSystem
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [labelStack, sliderControl])
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 5.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override public var intrinsicContentSize: CGSize {
        let labelWidth = titleLabel.intrinsicContentSize.width + valueLabel.intrinsicContentSize.width + labelStack.spacing
        let labelHeight = max(titleLabel.intrinsicContentSize.height, valueLabel.intrinsicContentSize.height)
        let sliderWidth = sliderControl.intrinsicContentSize.width
        let sliderHeight = sliderControl.intrinsicContentSize.height
        return CGSize(width: max(labelWidth, sliderWidth) + layoutMargins.width,
                      height: labelHeight + sliderHeight + layoutMargins.height + stackView.spacing)
    }

    // MARK: Lifecycle

    public convenience init(valueRange range: Float) {
        self.init(frame: .zero, minimumValue: -range * 0.5, maximumValue: range * 0.5)
    }

    public convenience init(minimumValue: Float = -10.0, maximumValue: Float = 10.0) {
        self.init(frame: CGRect.zero, minimumValue: minimumValue, maximumValue: maximumValue)
    }

    public init(frame: CGRect, minimumValue: Float, maximumValue: Float) {
        self.minimumValue = minimumValue
        self.maximumValue = maximumValue
        super.init(frame: frame)
        self.configure()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Configuration

    private func configure() {
        backgroundColor = .clear
        addSubview(stackView)
        setupConstraints()
        valueLabel.text =  String(format: "%.2f", sliderControl.value)
    }

    private func setupConstraints() {
        let guide = layoutMarginsGuide
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: guide.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
    }

    // MARK: B

    @objc func sliderValueDidChange(_ sender: UISlider) {
        valueLabel.text =  String(format: "%.2f", sender.value)
        sliderDidChangeHandler?(sender.value)
    }

    // MARK: C

    public func reset() {
        let newValue: Float = 0.0
        sliderControl.setValue(newValue, animated: true)
        valueLabel.text = String(format: "%.2f", newValue)
    }

}
