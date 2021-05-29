//
//  CreateEventViewController.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import CoreLocation
import UIKit

final class CreateEventViewController: UIViewController, UINavigationControllerDelegate {

    // MARK: - Private properties

    private let viewModel: CreateEventViewModelBindable

    // MARK: - Initializers

    init(viewModel: CreateEventViewModelBindable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    override func loadView() {
        let view = CreateEventView()
        view.bind(to: viewModel)

        self.view = view
        
        view.onImagePickerNeeded = {
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.mediaTypes = ["public.image"]
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onBackgroundTap))

        view.addGestureRecognizer(tapRecognizer)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func onAcceptedLocation(_ location: PickedPinViewModel) {
        viewModel.location.onNext(location)
    }
    
    @objc private func onBackgroundTap() {
        view.endEditing(true)
    }
}

extension CreateEventViewController: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
                    return
                }
        (view as? CreateEventView)?.updateImage(image)
        viewModel.image.onNext(image)
        picker.dismiss(animated: true, completion: nil)
    }
}
