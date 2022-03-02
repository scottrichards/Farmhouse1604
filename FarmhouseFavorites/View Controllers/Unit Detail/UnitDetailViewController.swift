//
//  UnitDetailViewController.swift
//  FarmhouseFavorites
//
//  Created by Scott Richards on 2/28/22.
//

import UIKit

enum FishermansAptEnum: Int, CaseIterable {
    case exterior = 0
    case sunsetPortrait
    case bar
    case dining
    case living
    
    var description: String? {
        switch self {
        case .exterior:
            return nil
        case .sunsetPortrait:
            return "Beautiful sunsets"
        case .bar:
            return "Happy Hours"
        case .dining:
            return "Enjoy great meals"
        case .living:
            return "Kick back and put up your feet"
        }
    }
    
    var imageName: String {
        switch self {
        case .exterior:
            return "Photo Exterior-2"
        case .sunsetPortrait:
            return "Photo Fishermans Sunset Portrait"
        case .bar:
            return "Photo Fishermans Bar"
        case .dining:
            return "Photo Fishermans Dining"
        case .living:
            return "Photo Fishermans Living"
        }
    }
    
    
//    var index: Int {
//        switch self {
//        case .pageZero:
//            return 0
//        case .pageOne:
//            return 1
//        case .pageTwo:
//            return 2
//        case .pageThree:
//            return 3
//        }
//    }
}


class UnitDetailViewController: UIPageViewController {
    private var photos: [FishermansAptEnum] = FishermansAptEnum.allCases
    private var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        setupPageController()
    }
    
    private func setupPageController() {
        dataSource = self
        delegate = self
        let proxy = UIPageControl.appearance()
        proxy.pageIndicatorTintColor = UIColor.darkGray.withAlphaComponent(0.6)
        proxy.currentPageIndicatorTintColor = UIColor.darkGray
        self.view.backgroundColor = .white
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        // for now avoid setting brightnesss in Single Color Mode
        
        if let photoAlbumVC = storyBoard.instantiateViewController(withIdentifier: "PhotoAlbumPageVC") as? PhotoAlbumPageVC {
            photoAlbumVC.setData(image: photos[currentIndex].imageName, title: photos[currentIndex].description)
            photoAlbumVC.photo = photos[currentIndex]
            setViewControllers([photoAlbumVC], direction: .forward, animated: true, completion: nil)
        }
    }

}


extension UnitDetailViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? PhotoAlbumPageVC, let photo = currentVC.photo else {
            return nil
        }
        var index = photo.rawValue
        
        if index == 0 {
            return nil
        }
        
        index -= 1
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if let photoAlbumVC = storyBoard.instantiateViewController(withIdentifier: "PhotoAlbumPageVC") as? PhotoAlbumPageVC {
            photoAlbumVC.setData(image: photos[index].imageName, title: photos[index].description)
            photoAlbumVC.photo = photos[currentIndex]
            return photoAlbumVC
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? PhotoAlbumPageVC, let photo = currentVC.photo else {
            return nil
        }

        var index = photo.rawValue
        
        if index >= self.photos.count - 1 {
            return nil
        }
        
        index += 1
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if let photoAlbumVC = storyBoard.instantiateViewController(withIdentifier: "PhotoAlbumPageVC") as? PhotoAlbumPageVC {
            photoAlbumVC.setData(image: photos[index].imageName, title: photos[index].description)
            photoAlbumVC.photo = photos[index]
            return photoAlbumVC
        }
        
        return nil
    }
}

extension UnitDetailViewController: UIPageViewControllerDelegate {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        print ("photo Count: \(self.photos.count)")
        return self.photos.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        print("presentationIndex: \(self.currentIndex)")
        return self.currentIndex
    }
}

