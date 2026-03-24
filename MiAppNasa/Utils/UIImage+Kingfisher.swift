//
//  UIImage+Kingfisher.swift
//  MiAppNasa
//
//  Created by Cinthia Villegas on 23/03/26.
//

import UIKit
import Kingfisher

extension UIImageView {
    func getImageFromURL(urlToShow: String) {
        let url = URL(string: urlToShow)
        self.kf.setImage(with: url)
    }
}
