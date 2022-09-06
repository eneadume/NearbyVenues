//
//  AppCoordinator.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/21/22.
//

import UIKit
import CoreData

class AppCoordinator: NSObject, Coordinator {
    let window: UIWindow

    var childCoordinators: [Coordinator] = []
    private let injector: Injector
    private let networkStatusMonitor: NetworkMonitor
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NearbyVenues")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    
    init(window: UIWindow) {
        self.window = window
        self.networkStatusMonitor = NetworkMonitor.shared
    
        // Don't initialize this anywhere else, ever.
        self.injector = Injector(persistentContainer: persistentContainer)
    }
    
    func start() {
        showLaunchScreen()
        startMainCoordinator()
        networkStatusMonitor.startMonitoring()
    }
    
    private func showLaunchScreen() {
        window.makeKeyAndVisible()
        //we need to show launchscreen until we put rootViewController to avoid blackScreen during app launch
        let viewController: UIViewController = {
            guard
                let launchScreenStoryboardName = Bundle.main.object(forInfoDictionaryKey: Constants.UILaunchStoryboardNameKey) as? String,
                let viewController = UIStoryboard(name: launchScreenStoryboardName, bundle: nil).instantiateInitialViewController()
            else {
                return UIViewController()
            }
            return viewController
        }()
        window.rootViewController = viewController
    }
    
    private func startMainCoordinator() {
        let navigationController = UINavigationController()
        let homeCoordinator = HomeCoordinator(navigationController: navigationController, injector: injector)
        homeCoordinator.start()
        window.rootViewController = navigationController
        addChild(coordinator: homeCoordinator)
    }
    
    // MARK: - Core Data Saving support

    private func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}



extension AppCoordinator {

    func applicationDidEnterBackground() {
        networkStatusMonitor.stopMonitoring()
        
        // Save changes in the application's managed object context when the application transitions to the background.
        self.saveContext()
    }

    func applicationWillEnterForeground() {
        networkStatusMonitor.startMonitoring()
    }
}
