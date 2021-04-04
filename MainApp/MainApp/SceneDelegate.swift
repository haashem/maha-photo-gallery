//
//  SceneDelegate.swift
//  MainApp
//
//  Created by Hashem Aboonajmi on 4/4/21.
//

import UIKit
import PhotoGalleryiOS
import PhotoGalleryCache

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        navigationController = UINavigationController(rootViewController: createPhotoGalleryScene())
        window.rootViewController = navigationController
        self.window = window
        self.window?.makeKeyAndVisible()
    }
    
    func createPhotoGalleryScene() -> PhotoGalleryViewController {
        
        let storeBundle = Bundle(for: CoreDataGalleryStore.self)
        
        let localPhotoGallery = LocalGallery(store: try! CoreDataGalleryStore(storeURL: storeURL(), bundle: storeBundle))
        
        let photoGalleryVC = GalleryUIComposer.photoGalleryComposedWith(photoLoader: localPhotoGallery, photoSaver: localPhotoGallery)
        return photoGalleryVC
    }
    
    private func storeURL() -> URL {
        return cacheDirectory().appendingPathComponent("\(type(of: self)).store")
    }
    
    private func cacheDirectory() -> URL {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }

}

