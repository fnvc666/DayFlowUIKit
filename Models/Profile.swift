//
//  Profile.swift
//  ToDoListWithDesign
//
//
import Foundation
import UIKit

struct Profile: Codable {
    var name: String?
    var imageData: Data?
    
    var image: UIImage? {
        get {
            guard let imageData = imageData else { return nil}
            return UIImage(data: imageData)
        }
        set {
            imageData = newValue?.jpegData(compressionQuality: 0.8)
        }
    }
}
