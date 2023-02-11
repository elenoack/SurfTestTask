//
//  SceneDelegate.swift
//  SurfTestTask
//
//  Created by Elena Noack on 06.02.23.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let assembly = AssemblerBuilder()

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let rootViewController = assembly.configureMainModule()
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        self.window = window
    }

}
