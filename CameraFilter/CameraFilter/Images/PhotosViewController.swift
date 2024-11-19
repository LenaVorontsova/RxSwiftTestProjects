//
//  ImagesViewController.swift
//  CameraFilter
//
//  Created by Елена Воронцова on 08.11.2024.
//

import UIKit
import Photos
import RxSwift

final class PhotosViewController: UIViewController {
    private lazy var mainView = PhotosView(delegate: self)
    
    private let selectedPhotoSubject = PublishSubject<UIImage>()
    var selectedPhoto: Observable<UIImage> {
        return selectedPhotoSubject.asObservable()
    }
    
    private var images = [PHAsset]()
    
    override func loadView() {
        super.loadView()
        
        self.view = self.mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupViews()
        
        populatePhotos()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
    }
    
    private func setupViews() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(PhotoCollectionViewCell.self,
                                         forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
    }
    
    private func populatePhotos() {
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            if status == .authorized {
                let assets = PHAsset.fetchAssets(with: .image, options: nil)
                assets.enumerateObjects { (object, count, stop) in
                    self?.images.append(object)
                }
                self?.images.reverse()
                
                DispatchQueue.main.async {
                    self?.mainView.collectionView.reloadData()
                }
            } else {
                print("Access to photo library was denied.")
            }
        }
    }
}

extension PhotosViewController: PhotosDelegate { }

extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotoCollectionViewCell.identifier,
            for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let asset = images[indexPath.item]
        let manager = PHImageManager.default()
        manager.requestImage(for: asset,
                             targetSize: CGSize(width: UIScreen.main.bounds.width, height: 120),
                             contentMode: .aspectFill,
                             options: nil) { image, _ in
            if let image = image {
                DispatchQueue.main.async {
                    cell.setImage(image: image)
                }
            } else {
                print("Failed to load image for asset \(asset)")
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 30) / 2
        return CGSize(width: width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedAsset = images[indexPath.item]
        PHImageManager.default().requestImage(for: selectedAsset,
                                              targetSize: CGSize(width: UIScreen.main.bounds.width, height: 120),
                                              contentMode: .aspectFill,
                                              options: nil) { [weak self] image, info in
            guard let info = info else { return }
            
            let isDegradedImage = info["PHImageResultIsDegradedKey"] as! Bool
            
            if !isDegradedImage {
                if let image = image {
                    self?.selectedPhotoSubject.onNext(image)
                    self?.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}
