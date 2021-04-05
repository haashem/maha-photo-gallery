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
    
    public static func photoGalleryComposedWith(photoLoader: PhotoLoader, photoSaver: PhotoSaver, photoSelection: @escaping (Photo) -> Void = { _ in }) -> PhotoGalleryViewController {
        
        let bundle = Bundle(for: PhotoGalleryViewController.self)
        let storyboard = UIStoryboard(name: "PhotoGallery", bundle: bundle)
        
        let photoGalleryController = storyboard.instantiateInitialViewController() as! PhotoGalleryViewController
        
        let presenter = PhotoGalleryPresenter(galleryView: GalleryViewAdapater(controller: photoGalleryController))
        
        let presentationAdapter = PhotoGalleryPresentationAdapter(photoLoader: MainQueueDispatchDecorator(decoratee: photoLoader), photoSaver: MainQueueDispatchDecorator(decoratee: photoSaver), presenter: presenter, onPhotoSelection: photoSelection)
        
        photoGalleryController.delegate = presentationAdapter
        
        return photoGalleryController
    }
    
    public static func photoDetailsComposedWith(_ photo: Photo) -> PhotoDetailsViewController {
        let bundle = Bundle(for: PhotoGalleryViewController.self)
        let storyboard = UIStoryboard(name: "PhotoGallery", bundle: bundle)
        
        let photoDetailsVC = storyboard.instantiateViewController(identifier: String(describing: PhotoDetailsViewController.self)) as! PhotoDetailsViewController
        
        let viewModel = photo.viewModel()
        photoDetailsVC.viewModel = viewModel
        return photoDetailsVC
    }
}

private final class PhotoGalleryPresentationAdapter: PhotoGalleryViewControllerDelegate {
    
    private let photoLoader: PhotoLoader
    private let photoSaver: PhotoSaver
    var presenter: PhotoGalleryPresenter
    var onPhotoSelection: (Photo) -> Void
    private var photos: [Photo] = []
    
    init(photoLoader: PhotoLoader, photoSaver: PhotoSaver, presenter: PhotoGalleryPresenter, onPhotoSelection: @escaping (Photo) -> Void) {
        self.photoLoader = photoLoader
        self.photoSaver = photoSaver
        self.presenter = presenter
        self.onPhotoSelection = onPhotoSelection
    }
    
    func didRequestLoadPhotos() {
        photoLoader.load { [weak self] result in
            switch result {
            case let .success(photos):
                self?.photos = photos
                self?.presenter.didFinishLoadingPhotos(with: photos)
            default: break
            }
        }
    }
    
    func didRequestSaveImage(image: UIImage, with name: String) {
        let photo = Photo(name: name, date: Date(), image: image.pngData()!)
        photoSaver.save(photo) { [weak self] result in
            switch result {
            case .success():
                self?.presenter.didFinishLoadingPhotos(with: [photo])
            default: break
            }
        }
    }
    
    
    func didSelectImage(at index: Int) {
        onPhotoSelection(photos[index])
    }
    
}

private final class GalleryViewAdapater: GalleryView {
    
    private weak var controller: PhotoGalleryViewController?
    
    init(controller: PhotoGalleryViewController) {
        self.controller = controller
    }
    
    func display(_ viewModel: GalleryViewModel) {
        
        controller?.appened(viewModel.photos.map { model in
            
            return model.viewModel()
        })
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

extension MainQueueDispatchDecorator: PhotoSaver where T == PhotoSaver {
    
    func save(_ photo: Photo, completion: @escaping (SaveResult) -> Void) {
        decoratee.save(photo) { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }
}

private extension Photo {
    func viewModel() -> PhotoViewModel<UIImage> {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return PhotoViewModel(name: name, date: dateFormatter.string(from: date), image: UIImage.init(data: image)!)
        
    }
}
