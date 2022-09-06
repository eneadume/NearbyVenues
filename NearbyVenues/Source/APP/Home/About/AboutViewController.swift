//
//  AboutViewController.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/21/22.
//

import UIKit

class AboutViewController: UIViewController {
    
    var onVenuesSegmentSelected: Callback?
    
    var navSegmentControl: UISegmentedControl = {
        let venuesSegmentTitle = Localizable.venuesSegmentControlTitle
        let aboutSegmentTitle = Localizable.aboutSegmentControlTitle
        return UISegmentedControl(items: [venuesSegmentTitle, aboutSegmentTitle])
    }()
    let aboutLabel: UILabel = {
        let label = UILabel()
        label.text = Localizable.aboutScreenText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(aboutLabel)
        aboutLabel.pinToCenter(of: self.view)
        navSegmentControl.addTarget(self, action: #selector(segmentedControlValueChanged(sender:)), for: .valueChanged)
        self.navigationItem.titleView = navSegmentControl
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navSegmentControl.selectedSegmentIndex = 1
    }
    
    // MARK: - Actions
    
    @objc private func segmentedControlValueChanged(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            onVenuesSegmentSelected?()
        }
    }
}
