//
//  X.swift
//  PlaygroundKit
//
//  Created by Mathew Gacy on 10/7/20.
//  Copyright © 2020 Mathew Gacy. All rights reserved.
//

import UIKit

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

    // MARK: Appearance

    public var labelColor: UIColor = .label {
        didSet {
            valueLabel.textColor = labelColor
        }
    }

    // MARK: Subviews

    // TODO: Add cardView

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

    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [valueLabel, sliderControl])
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 5.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override public var intrinsicContentSize: CGSize {
        return stackView.intrinsicContentSize
    }

    // MARK: Lifecycle

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
        let inset: CGFloat = 8.0
        //let guide = layoutMarginsGuide
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset)
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
