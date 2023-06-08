//
//  ArtObject+SwiftUI.swift
//  FruitBowl
//
//  Created by timas on 2023-06-08.
//

import Foundation
import SwiftUI

extension ArtObject {
    var image: Image? {
        guard let imageData,
              let uiImage = UIImage(data: imageData) else {
            return nil
        }
        
        return Image(uiImage: uiImage)
    }
}
