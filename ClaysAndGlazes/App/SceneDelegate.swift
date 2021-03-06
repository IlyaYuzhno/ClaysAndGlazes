//
//  SceneDelegate.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 29.03.2021.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        // MARK: - Start the App
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene

        let storageService = ClaysGlazeLocalStorageService()
        
        // Creating VC for Tab Bar
        let claysListController = ClaysTableViewController(storageService: storageService)
        let glazesListController = ChooseGlazeTableViewController(storageService: storageService)
        let materialsListController = MaterialsListMainViewController()
        let glazesRecipesController = GlazesRecipesMainViewController()

        // Setup TabBar Controller
        let tabBarController = UITabBarController()
        tabBarController.tabBar.barTintColor = .SearchBarColor

        // Adding VCs to TabBar
        claysListController.tabBarItem = UITabBarItem(title: "Массы", image: UIImage(named: "clayGrayIcon")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "clayIconBlue")?.withRenderingMode(.alwaysOriginal))

        glazesListController.tabBarItem = UITabBarItem(title: "Глазури", image: UIImage(named: "glazeBrushGrayIcon")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "glazeBrushBlue")?.withRenderingMode(.alwaysOriginal))

        materialsListController.tabBarItem = UITabBarItem(title: "Материалы", image: UIImage(systemName: "list.bullet.rectangle"), selectedImage: UIImage(systemName: "list.bullet.rectangle"))

        glazesRecipesController.tabBarItem = UITabBarItem(title: "Рецепты", image: UIImage(systemName: "list.number"), selectedImage: UIImage(systemName: "list.number"))

        let controllers = [claysListController, glazesListController, materialsListController, glazesRecipesController]

        tabBarController.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    @available(iOS 13.0, *)
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    @available(iOS 13.0, *)
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    @available(iOS 13.0, *)
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    @available(iOS 13.0, *)
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    @available(iOS 13.0, *)
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

