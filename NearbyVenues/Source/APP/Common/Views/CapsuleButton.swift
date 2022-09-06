//
//  CapsuleButton.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/22/22.
//


import UIKit

class CapsuleButton: UIButton {

    private var heightConstraint: NSLayoutConstraint?

    init() {
        super.init(frame: .zero)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        tintColor = Color.tint
        backgroundColor = Color.tint
        setTitleColor(Color.primaryWhite, for: .normal)
        clipsToBounds = true
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        guard
            superview.isNotNil,
            heightConstraint.isNilOrEmpty
        else { return }

        heightConstraint = heightAnchor.constraint(equalToConstant: Constants.minimumTouchSize.height)

        if let heightConstraint = heightConstraint {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                self.apply(constraints: [heightConstraint])
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = frame.height / 2.0
    }

}
