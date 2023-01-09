//
//  UIImage.swift
//  cosa
//
//  Created by Olli Toivanen on 9.11.2022.
//

import Foundation
import SwiftUI

///Width is the new width-resolution for the image
extension UIImage {
    func aspectFittedToWidth(_ newWidth: CGFloat) -> UIImage {
        let scale = newWidth / self.size.width
        print("original, \(self.size.width)")
        print("scale, \(scale)")

        let newHeight = self.size.height * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        print("new size, \(newSize)")

        let renderer = UIGraphicsImageRenderer(size: newSize)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
