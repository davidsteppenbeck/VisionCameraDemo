//
//  PhotoCaptureDelegate.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/22.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit
import AVFoundation

/// An object that confroms to protocol `AVCapturePhotoCaptureDelegate` and handles saving images in the Photos app.
final class PhotoCaptureDelegate: NSObject, AVCapturePhotoCaptureDelegate {

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        DispatchQueue.global().async {
            guard let data = photo.fileDataRepresentation(), let image = UIImage(data: data) else { return }
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
    }

}
