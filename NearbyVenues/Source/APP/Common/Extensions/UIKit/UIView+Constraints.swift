//
//  UIView+Constraints.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/22/22.
//

import UIKit


extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, paddingTop: CGFloat, bottom: NSLayoutYAxisAnchor?, paddingBottom: CGFloat, left: NSLayoutXAxisAnchor?, paddingLeft: CGFloat, right: NSLayoutXAxisAnchor?, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        var constraint = AnchoredConstraints()
        if let top = top {
            constraint.top = topAnchor.constraint(equalTo: top, constant: paddingTop)
            constraint.top?.isActive = true
        }
        if let bottom = bottom {
            constraint.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom)
            constraint.bottom?.isActive = true
        }
        if let right = right {
            constraint.trailing = trailingAnchor.constraint(equalTo: right, constant: -paddingRight)
            constraint.trailing?.isActive = true
        }
        if let left = left {
            constraint.leading = leadingAnchor.constraint(equalTo: left, constant: paddingLeft)
            constraint.leading?.isActive = true
        }
        if width != 0 {
            constraint.width = widthAnchor.constraint(equalToConstant: width)
            constraint.width?.isActive = true
        }
        if height != 0 {
            constraint.height = heightAnchor.constraint(equalToConstant: height)
            constraint.height?.isActive = true
        }
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height].forEach{ $0?.isActive = true }
        
    }
    
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        var constraints: AnchoredConstraints = AnchoredConstraints()
        if let superviewTopAnchor = superview?.topAnchor {
            constraints.top = topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top)
            constraints.top?.isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            constraints.bottom = bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom)
            constraints.bottom?.isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            constraints.leading = leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left)
            constraints.leading?.isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            constraints.trailing = trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right)
            constraints.trailing?.isActive = true
        }
    }
    
    func centerInSuperview(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func centerXInSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superViewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superViewCenterXAnchor).isActive = true
        }
    }
    
    func centerYInSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let centerY = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }
    
    func constrainWidth(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint: NSLayoutConstraint
        constraint = widthAnchor.constraint(equalToConstant: constant)
        constraint.isActive = true
    }
    
    func constrainHeight(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint: NSLayoutConstraint
        constraint = heightAnchor.constraint(equalToConstant: constant)
        constraint.isActive = true
    }
    
    
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        } else {
            return self.topAnchor
        }
    }
    
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return self.safeAreaLayoutGuide.leftAnchor
        }else {
            return self.leftAnchor
        }
    }
    
    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return self.safeAreaLayoutGuide.rightAnchor
        }else {
            return self.rightAnchor
        }
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        } else {
            return self.bottomAnchor
        }
    }
    
    enum LayoutEdge {
        case leading
        case top
        case trailing
        case bottom
    }
    
    enum LayoutDimension {
        case width
        case height
    }
    
    func apply(constraints: [NSLayoutConstraint]) {
        guard superview != nil else {
            assert(false, "\(self) must have a superview for constraints to be added")
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
    
    func pinEdgesToSuperView(withConstant constant: CGFloat) {
        pinEdgesToSuperView(withInsets: UIEdgeInsets(
            top: constant,
            left: constant,
            bottom: constant,
            right: constant
        ))
    }
    
    func pinEdgesToSuperView(excludingEdge: LayoutEdge? = nil, withInsets insets: UIEdgeInsets = .zero) {
        if excludingEdge != .leading {
            pinEdgeToSuperView(.leading, withInset: insets.left)
        }
        if excludingEdge != .top {
            pinEdgeToSuperView(.top, withInset: insets.top)
        }
        if excludingEdge != .trailing {
            pinEdgeToSuperView(.trailing, withInset: insets.right)
        }
        if excludingEdge != .bottom {
            pinEdgeToSuperView(.bottom, withInset: insets.bottom)
        }
    }
    
    func pinEdgeToSuperView(_ edge: LayoutEdge, withInset inset: CGFloat = 0) {
        guard let view = superview else {
            assert(false, "\(self) must have a superview for constraints to be added")
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraint: NSLayoutConstraint
        
        switch edge {
        case .leading:
            constraint = leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset)
        case .top:
            constraint = topAnchor.constraint(equalTo: view.topAnchor, constant: inset)
        case .trailing:
            constraint = view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: inset)
        case .bottom:
            constraint = view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: inset)
        }
        
        NSLayoutConstraint.activate([constraint])
    }
    
    func pinToCenter(of view: UIView, xOffset: CGFloat = 0.0, yOffset: CGFloat = 0.0) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: xOffset),
            centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yOffset)
        ])
    }
}
