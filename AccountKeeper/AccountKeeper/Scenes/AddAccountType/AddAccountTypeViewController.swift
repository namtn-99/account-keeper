//
//  AddAccountTypeViewController.swift
//  AccountKeeper
//
//  Created by NamTrinh on 06/07/2023.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable
import Then
import AVFoundation
import Photos

final class AddAccountTypeViewController: UIViewController, Bindable {
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var layerView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    // MARK: - IBOutlets
    
    // MARK: - Properties
    
    var viewModel: AddAccountTypeViewModel!
    var disposeBag = DisposeBag()
    var imagePicker = UIImagePickerController()
    private let icon = PublishSubject<UIImage?>()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    deinit {
        logDeinit()
    }
    
    // MARK: - Methods
    
    private func configView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        titleLabel.text = L10n.NewAccountType.title
        saveButton.setTitle(L10n.save, for: .normal)
        imageView.do {
            $0.layer.cornerRadius = 16
            $0.isUserInteractionEnabled = true
            $0.addGestureRecognizer(tap)
        }
        
        layerView.do {
            $0.layer.cornerRadius = 16
            $0.layer.borderWidth = 4
            $0.clipsToBounds = true
        }
        
        nameTextField.attributedPlaceholder = NSAttributedString(
            string: L10n.Placeholder.name,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        
        saveButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
//                if let image = self.imageView.image {
//                    self.saveImage(image)
//                }
            })
            .disposed(by: disposeBag)
        
//        if let image = getSavedImage(named: "image.jpg") {
//            imageView.image = image
//        }
    }
    
    @objc
    func selectImage() {
        showSelectType()
    }
    
    func bindViewModel() {
        let input = AddAccountTypeViewModel.Input(
            backTrigger: backButton.rx.tap.asDriver(),
            name: nameTextField.rx.text.orEmpty.asDriver(),
            icon: icon.asDriverOnErrorJustComplete()
        )
        let output = viewModel.transform(input, disposeBag: disposeBag)
    }
}

// MARK: - Binders
extension AddAccountTypeViewController {
    
}

// MARK: - StoryboardSceneBased
extension AddAccountTypeViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.addAccountType
}

// MARK: - UIImagePickerControllerDelegate
extension AddAccountTypeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var newImage: UIImage
        
        if let possibleImage = info[.editedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[.originalImage] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }
        
        imageView.image = newImage
        dismiss(animated: true)
    }
}

// MARK: Private functions
extension AddAccountTypeViewController {
    private func saveImage(_ image: UIImage) {
        do {
            let documentsDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileName = UUID().uuidString
            let fileURL = documentsDirectory.appendingPathComponent(fileName)
            if let data = image.jpegData(compressionQuality:  1),
                !FileManager.default.fileExists(atPath: fileURL.path) {
                try data.write(to: fileURL)
            }
        } catch {
            print("error:", error)
        }
    }
    
    private func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }
    
    private func showSelectType() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: L10n.Action.cancel, style: .cancel)
        let galary = UIAlertAction(title: L10n.photoGalary,
                                   style: .default,
                                         handler: { [weak self] _ in
            self?.openGalary()
        })
        let camera = UIAlertAction(title: L10n.camera, style: .default) { [weak self] _ in
            self?.openCamera()
        }
        alert.addAction(cancelAction)
        alert.addAction(galary)
        alert.addAction(camera)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func openGalary() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    private func openCamera() {
        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
            let vc = UIImagePickerController()
            vc.sourceType = .camera
            vc.allowsEditing = true
            vc.delegate = self
            present(vc, animated: true)
        } else {
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { [weak self] (granted: Bool) -> Void in
               if granted == true {
                   // User granted
               } else {
                   DispatchQueue.main.async {
                       self?.showNavigateToSettings(title: L10n.NewAccountType.RequestPremission.Camera.title,
                                                    message: L10n.NewAccountType.RequestPremission.Camera.message)
                   }
               }
           })
        }
    }
}
