import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let navAreaSelectionVC = NavAreaSelectionViewController()
        let navigationController = UINavigationController(rootViewController: navAreaSelectionVC)
        
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.tintColor = .systemBlue
        navigationController.navigationBar.barTintColor = .systemGray6
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

