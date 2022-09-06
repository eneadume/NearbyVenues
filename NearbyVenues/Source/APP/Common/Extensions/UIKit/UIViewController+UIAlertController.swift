//
//  UIViewController+UIAlertController.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/21/22.
//

import UIKit

extension UIViewController {

    func presentActionSheet(_ actionSheet: UIAlertController) {
        if let popoverController = actionSheet.popoverPresentationController {
          popoverController.sourceView = self.view
          popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
          popoverController.permittedArrowDirections = []
        }
        present(actionSheet, animated: true, completion: nil)
    }
}
