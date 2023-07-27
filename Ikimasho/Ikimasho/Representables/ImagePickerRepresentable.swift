//
//  ImagePickerRepresentable.swift
//  Ikimasho
//
//  Created by Kel_Jellysh on 26/07/2023.
//

import PhotosUI
import SwiftUI

struct ImagePickerRepresentable: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presented
    let image: (UIImage) -> Void

    init(image: @escaping(UIImage) -> Void) {
        self.image = image
    }

    func makeUIViewController(context: Context) -> some UIViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        print("updated")
    }

    func makeCoordinator() -> PHPickerCoordinator {
        PHPickerCoordinator {
            self.presented.wrappedValue.dismiss()
        } imageTaken: { image in
            self.image(image)
        }
    }



}
