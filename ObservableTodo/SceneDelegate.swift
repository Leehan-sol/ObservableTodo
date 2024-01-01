//
//  SceneDelegate.swift
//  ObservableTodo
//
//  Created by hansol on 2024/01/01.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let naviVC = UINavigationController(rootViewController: MainViewController())

        window?.rootViewController = naviVC
        window?.makeKeyAndVisible()
    }
    
    
}

