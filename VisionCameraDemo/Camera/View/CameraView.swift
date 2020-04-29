//
//  CameraView.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/15.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit
import AVFoundation

final class CameraView: UIView {

    // MARK:- Properties

    /// Returns the class used to create the layer for `CameraView` instances.
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }

    /// The layer that displays video as it’s captured.
    var preview: AVCaptureVideoPreviewLayer? {
        return layer as? AVCaptureVideoPreviewLayer
    }

    var session: AVCaptureSession? {
        get {
            return preview?.session
        }
        set {
            preview?.session = newValue
        }
    }

    // MARK:- Initialization

    init(frame: CGRect = .zero, session: AVCaptureSession?) {
        super.init(frame: frame)
        self.session = session
        preview?.videoGravity = .resizeAspectFill
        preview?.connection?.safeSetVideoOrientation(.portrait)
        preview?.connection?.safeSetVideoStabilizationMode(.auto)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
