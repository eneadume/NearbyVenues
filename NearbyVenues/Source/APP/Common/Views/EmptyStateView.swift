//
//  EmptyStateView.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/22/22.
//

import UIKit

class EmptyStateView: UIView {
    
    var isLoading: Bool = false {
        didSet {
            if isLoading {
                button.isHidden = true
                activityIndicator.startAnimating()
            } else {
                button.isHidden = shouldButtonBeHidden
                activityIndicator.stopAnimating()
            }
        }
    }
    
    var image: UIImage? = nil {
        didSet {
            imageView.image = image
        }
    }
    
    var imageColor: UIColor = Color.tint {
        didSet {
            imageView.tintColor = imageColor
        }
    }
    
    var title: String? = nil {
        didSet {
            titleLabel.text = title
        }
    }
    
    var detail: String? = nil {
        didSet {
            detailLabel.text = detail
        }
    }
    
    var buttonImage: UIImage? = nil {
        didSet {
            button.setTitle(nil, for: .normal)
            button.backgroundColor = nil
            button.setImage(buttonImage, for: .normal)
        }
    }
    
    func setButtonTitle(_ title: String, backgroundColor: UIColor = Color.tint, foregroundColor: UIColor = Color.primaryWhite) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(foregroundColor, for: .normal)
        button.backgroundColor = backgroundColor
        button.setImage(nil, for: .normal)
        button.clipsToBounds = true
    }
    
    var onButtonPressed: Callback? {
        didSet {
            button.isHidden = onButtonPressed == nil
        }
    }
    
    private var shouldButtonBeHidden: Bool {
        return onButtonPressed == nil
    }
    
    private let imageView = UIImageView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = Color.Label.primary
        return label
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = Color.Label.secondary
        return label
    }()
    
    private let button: CapsuleButton = {
        let button = CapsuleButton()
        return button
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        view.color = Color.tint
        return view
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(
            top: Constants.Spacing.single,
            left: Constants.Spacing.single,
            bottom: Constants.Spacing.single,
            right: Constants.Spacing.single)
        stack.spacing = Constants.Spacing.quad
        return stack
    }()
    
    init() {
        super.init(frame: .zero)
        
        addSubviews()
        addConstraints()
        
        self.button.addAction(UIAction(handler: { [weak self] action in
            guard let self = self else { return }
            
            self.onButtonPressed?()
        }), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(stack)
        stack.addArrangedSubview(imageView)
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(detailLabel)
        stack.addArrangedSubview(button)
        addSubview(activityIndicator)
    }
    
    private func addConstraints() {
        stack.apply(constraints: [
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            stack.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor).withPriority(.defaultHigh),
            stack.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 8),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stack.trailingAnchor, multiplier: 8).withPriority(.defaultHigh)
        ])
        
        stack.setCustomSpacing(Constants.Spacing.single, after: titleLabel) // Wow!
        
        button.apply(constraints: [
            button.widthAnchor.constraint(equalTo: stack.widthAnchor, multiplier: Constants.twoThirds)
        ])
        
        activityIndicator.pinToCenter(of: button)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        button.isHidden = shouldButtonBeHidden
    }
}
