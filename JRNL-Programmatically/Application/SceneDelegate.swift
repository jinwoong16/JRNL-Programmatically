//
//  SceneDelegate.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/9/24.
//

import UIKit
import SwiftData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene

        AppAppearance.setupAppearance()
        resolveContainer()
        resolveService()
        resolveUseCase()
        
        let rootViewController = RootTabBarController()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        @Injected(SwiftDataContainerKey.self) var container: SwiftDataContainer
    }
    
    

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    private func resolveContainer() {
        DIContainer.shared.register {
            Module(JournalFileContainerKey.self) { JournalFileContainer() }
            Module(SwiftDataContainerKey.self) {
                do {
                    let container = try ModelContainer(
                        for: Journal.self,
                        configurations: ModelConfiguration()
                    )
                    return SwiftDataContainer(modelContainer: container)
                } catch {
                    fatalError("Could not be reachable to DataBase")
                }
            }
        }
    }
    
    private func resolveService() {
        DIContainer.shared.register {
//            Module(JournalRepositoryKey.self) {
//                @Injected(JournalFileContainerKey.self) var container: JournalFileContainer
//                return JournalRepository(container: container)
//            }
            Module(JournalRepositoryKey.self) {
                @Injected(SwiftDataContainerKey.self) var container: SwiftDataContainer
                return JournalRepository(container: container)
            }
        }
    }
    
    private func resolveUseCase() {
        DIContainer.shared.register {
            Module(JournalListViewUseCaseKey.self) {
                @Injected(JournalRepositoryKey.self) var repository: JournalRepository
                return DefaultJournalListViewUseCase(journalRepository: repository)
            }
            Module(AddJournalViewUseCaseKey.self) {
                @Injected(JournalRepositoryKey.self) var repository: JournalRepository
                return DefaultAddJournalViewUseCase(journalRepository: repository)
            }
            Module(MapViewUseCaseKey.self) {
                @Injected(JournalRepositoryKey.self) var repository: JournalRepository
                return DefaultMapViewUseCase(journalRepository: repository)
            }
        }
    }
}
