//
//  Untitled.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/18/26.
//

import UIKit

final class MainTabBarController: UITabBarController {

    // MARK: - Init

    init(
        pokemonViewController: UIViewController,
        berriesViewController: UIViewController,
        itemsViewController : UIViewController,
        regionsViewController : UIViewController
   
    ) {

        super.init(
            nibName: nil,
            bundle: nil
        )

        // Pokemon

        let pokemonNav =
            UINavigationController(
                rootViewController:
                    pokemonViewController
            )

        pokemonNav.tabBarItem =
            UITabBarItem(
                title: "Pokemon",
                image: UIImage(
                    systemName: "bolt.fill"
                ),
                tag: 0
            )

        // Berries

        let berriesNav =
            UINavigationController(
                rootViewController:
                    berriesViewController
            )

        berriesNav.tabBarItem =
            UITabBarItem(
                title: "Berries",
                image: UIImage(
                    systemName: "leaf.fill"
                ),
                tag: 1
            )

        // Items

        let itemsNav =
            UINavigationController(
                rootViewController:
                    itemsViewController
            )

        itemsNav.tabBarItem =
            UITabBarItem(
                title: "Items",
                image: UIImage(
                    systemName: "bag.fill"
                ),
                tag: 2
            )

        // Regions

        let regionsNav =
            UINavigationController(
                rootViewController:
                    regionsViewController
            )

        regionsNav.tabBarItem =
            UITabBarItem(
                title: "Regions",
                image: UIImage(
                    systemName: "globe"
                ),
                tag: 3
            )

        // Set Tabs

        viewControllers = [
            pokemonNav,
            berriesNav,
            itemsNav,
            regionsNav
        ]
    }

    required init?(coder: NSCoder) {
        fatalError(
            "init(coder:) has not been implemented"
        )
    }
}
