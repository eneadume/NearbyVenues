//
//  Coordinator.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/21/22.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
}

// MARK: - Children handling
extension Coordinator {

    func addChild(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func removeChild(coordinator: Coordinator) {
        coordinator.removeAllChildren()
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }

    func removeAllChildren() {
        childCoordinators.forEach { $0.removeAllChildren() }
        childCoordinators.removeAll()
    }
}

// MARK: - Alerts
extension Coordinator {

    func presentConfirmationAlertController(
        presenterViewController: UIViewController,
        title: String? = nil,
        message: String? = nil,
        preferredStyle: UIAlertController.Style = .alert,
        confirmActionTitle: String? = Localizable.commonActionYes,
        cancelActionTitle: String? = Localizable.commonActionNo,
        confirmedHandler: @escaping Callback
    ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        alertController.addAction(UIAlertAction(title: confirmActionTitle, style: .default, handler: { _ in
            confirmedHandler()
        }))
        alertController.addAction(UIAlertAction(title: cancelActionTitle, style: .cancel, handler: nil))
        presenterViewController.presentActionSheet(alertController)
    }
}

