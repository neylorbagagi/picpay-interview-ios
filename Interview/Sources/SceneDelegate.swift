import UIKit
import ListContacts

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            
            window.rootViewController = UINavigationController(
                rootViewController: ListContacts().build()
            )
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
