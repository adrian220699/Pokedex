//
//  SceneDelegate.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/12/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        
        let container = DependencyContainer()

        // MARK: - Pokemon Feature

        let pokemonVC = container.makePokemonViewController()
        
        //MARK: - Berry Feature
        
        let berryVC = container.makeBerryViewController()
        
        //MARK: - Item Feature
        
        let itemVC = container.makeItemViewController()
        
        //MARK: - Region Feature
        
        let regionVC = container.makeRegionViewController()
       

        // MARK: - Main Tab Bar

        let tabBar =
            MainTabBarController(
                pokemonViewController: pokemonVC,
                berriesViewController: berryVC,
                itemsViewController:  itemVC,
                regionsViewController: regionVC
                
            )
        
        // MARK: - Root

        window.rootViewController = tabBar
        window.makeKeyAndVisible()

        self.window = window
    }
}
