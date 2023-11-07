//
//  URL+.swift
//  AccountKeeper
//
//  Created by NamTrinh on 12/07/2023.
//

import UIKit

extension URL {
    func loadImage(_ image: inout UIImage?) {
        if let data = try? Data(contentsOf: self), let loaded = UIImage(data: data) {
            image = loaded
        } else {
            image = nil
        }
    }
    func saveImage(_ image: UIImage?) {
        if let image = image {
            if let data = image.jpegData(compressionQuality: 1.0) {
                try? data.write(to: self)
            }
        } else {
            try? FileManager.default.removeItem(at: self)
        }
    }
}
