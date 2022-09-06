//
//  HomeCoordinator.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/21/22.
//

import UIKit

class HomeCoordinator: NSObject, Coordinator {
    var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    private let injector: Injector
    private let aboutViewController: AboutViewController
    private let venuesViewCotroller: VenuesViewController
    
    
    init(
        navigationController: UINavigationController,
        injector: Injector
    ) {
        self.navigationController = navigationController
        self.injector = injector
        
        let venuesViewModel = VenuesViewModel(venuesRepository: injector.venuesRepository)
        venuesViewCotroller = VenuesViewController(venuesViewModel: venuesViewModel)
        
        aboutViewController = AboutViewController()
        
        super.init()
    }
    
    func start() {
        venuesViewCotroller.onAboutSegmentSelected = { [weak self] in
            guard let self = self else { return }
            
            self.navigationController.viewControllers = [self.aboutViewController]
        }
        
        aboutViewController.onVenuesSegmentSelected = { [weak self] in
            guard let self = self else { return }
            
            self.navigationController.viewControllers = [self.venuesViewCotroller]
        }
        
        navigationController.viewControllers = [venuesViewCotroller]
    }
}
