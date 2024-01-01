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
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        // 의존성 주입
        let observableVM = ObservableViewModel()
        let viewController = ViewController(observableVM: observableVM)
        
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
    

}

