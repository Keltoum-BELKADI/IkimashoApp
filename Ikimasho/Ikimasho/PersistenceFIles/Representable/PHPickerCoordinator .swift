//
//  PHPickerCoordinator .swift
//  Ikimasho
//
//  Created by Kel_Jellysh on 26/07/2023.
//

import Foundation
import PhotosUI

class PHPickerCoordinator: NSObject, PHPickerViewControllerDelegate {
    let dismiss: () -> Void
    let imageTaken: (UIImage) -> Void

    init(dismiss: @escaping () -> Void, imageTaken: @escaping(UIImage) -> Void) {
        self.dismiss = dismiss
        self.imageTaken = imageTaken
    }

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        for result in results {
            if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                result.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                    if let new = image {
                        DispatchQueue.main.async {
                            self.imageTaken(new as! UIImage)
                        }
                    }
                }
            }
        }
        self.dismiss()
    }
}
