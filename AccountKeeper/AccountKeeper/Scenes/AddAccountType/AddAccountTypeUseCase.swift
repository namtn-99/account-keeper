//
//  AddAccountTypeUseCase.swift
//  AccountKeeper
//
//  Created by NamTrinh on 06/07/2023.
//

import RxSwift

protocol AddAccountTypeUseCaseType {
   // func isExistType() -> Observable<Bool>
    func saveImage(_ image: UIImage, path: String)
    func getSavedImage(named: String) -> UIImage?
}

struct AddAccountTypeUseCase: AddAccountTypeUseCaseType {
    
//    func isExistType() -> Observable<Bool> {
//
//    }
    func saveImage(_ image: UIImage, path: String) {
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
    
    func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }
}
