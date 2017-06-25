//  Copyright © 2017 Derk Gommers. All rights reserved.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        guard let viewController = ArticleListRouter().viewController() else {
            return false
        }

        applyTheme()

        window = UIWindow()
        window?.rootViewController = UINavigationController(rootViewController: viewController)
        window?.makeKeyAndVisible()

        return true
    }

    func applyTheme() {
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.barTintColor = .darkOrange

        let whiteForeground = [NSForegroundColorAttributeName: UIColor.white]
        navigationBarAppearance.titleTextAttributes = whiteForeground
    }
}

extension UIColor {
    static var darkOrange: UIColor {
        return UIColor(red: 0.9, green: 0.3, blue: 0, alpha: 1)
    }
}
