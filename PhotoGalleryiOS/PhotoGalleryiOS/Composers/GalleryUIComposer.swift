//
//  Composers.swift
//  PhotoGalleryiOS
//
//  Created by Hashem Aboonajmi on 4/4/21.
//

import UIKit
import PhotoGalleryFeature

public final class GalleryUIComposer {
    private init() {}
    
    public static func photoGalleryComposedWith(photoLoader: PhotoLoader, photoSaver: PhotoSaver) -> PhotoGalleryViewController {
        
        let bundle = Bundle(for: PhotoGalleryViewController.self)
        let storyboard = UIStoryboard(name: "PhotoGallery", bundle: bundle)
        
        let photoGalleryController = storyboard.instantiateInitialViewController() as! PhotoGalleryViewController
        
        let presenter = PhotoGalleryPresenter(galleryView: GalleryViewAdapater(controller: photoGalleryController))
        
        _ = PhotoGalleryPresentationAdapter(photoLoader: MainQueueDispatchDecorator(decoratee: photoLoader), presenter: presenter)
        
        return photoGalleryController
    }
    
}

private final class PhotoGalleryPresentationAdapter: PhotoGalleryViewControllerDelegate {
    
    private let photoLoader: PhotoLoader
    var presenter: PhotoGalleryPresenter
    
    init(photoLoader: PhotoLoader, presenter: PhotoGalleryPresenter) {
        self.photoLoader = photoLoader
        self.presenter = presenter
    }
    
    func didRequestLoadPhotos() {
        photoLoader.load { [weak self] result in
            switch result {
            case let .success(photos):
                self?.presenter.didFinishLoadingPhotos(with: photos)
            default: break
            }
        }
    }
}

private final class GalleryViewAdapater: GalleryView {
    
    private weak var controller: PhotoGalleryViewController?
    
    init(controller: PhotoGalleryViewController) {
        self.controller = controller
    }
    
    func display(_ viewModel: GalleryViewModel) {
        
        controller?.photos = viewModel.photos.map { model in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy"
            let viewModel = PhotoViewModel(name: model.name, date: dateFormatter.string(from: model.date), image: UIImage.init(data: model.image)!)
            return viewModel
        }
    }
}


private final class MainQueueDispatchDecorator<T> {
    private let decoratee: T
    
    init(decoratee: T) {
        self.decoratee = decoratee
    }
    
    func dispatch(completion: @escaping () -> Void) {
        
        guard Thread.isMainThread  else {
            DispatchQueue.main.async {
                completion()
            }
            return
        }
        completion()
    }
}

extension MainQueueDispatchDecorator: PhotoLoader where T == PhotoLoader {
    
    func load(completion: @escaping (PhotoLoader.Result) -> Void) {
        decoratee.load { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }
}
