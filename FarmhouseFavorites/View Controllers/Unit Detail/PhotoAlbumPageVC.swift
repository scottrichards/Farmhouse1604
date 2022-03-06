//
//  PhotoAlbumPageVC.swift
//  FarmhouseFavorites
//
//  Created by Scott Richards on 2/28/22.
//

import UIKit

class PhotoAlbumPageVC: UIViewController {
    var photoTitle: String?
    var imageName: String?
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    var photo: FishermansAptEnum?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imageName = imageName {
            photoImageView.image = UIImage(named: imageName)
        }
        if let title = photoTitle {
            descriptionLabel.text = title
        }
    }
    
    func setData(image: String, title: String?) {
        photoTitle = title
        imageName = image
    }


}
