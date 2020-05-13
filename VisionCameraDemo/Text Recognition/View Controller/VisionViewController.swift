//
//  VisionViewController.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/05/11.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit
import Combine

/// A class that controls and displays results from OCR text recognition.
final class VisionViewController: CameraViewController {

    // MARK:- Properties

    private(set) lazy var textRecognitionManager = VisionTextRecognitionManager()

    private(set) lazy var boundingBoxTransformManager: BoundingBoxTransformManager = VisionBoundingBoxTransformManager()

    private(set) lazy var textRecognitionResultsView = TextRecognitionResultsView()

    /// An array to keep references to all `AnyCancellable` view model subscribers.
    private var textRecognitionManagerSubscriptions = [AnyCancellable]()

    // MARK:- View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        textRecognitionResultsView.embed(in: cameraView, belowSubview: cameraGridView)
        captureSessionManager?.setSampleBufferDelegate(textRecognitionManager)
        addTextRecognitionManagerSubscribers()
    }

    // MARK:- Methods

    private func addTextRecognitionManagerSubscribers() {
        guard let preview = cameraView.preview else {
            return
        }

        textRecognitionManager.$textBoundingBoxFrames
            .map { (boxFrames) -> [TextBoundingBox] in
                return boxFrames.map { [unowned self] boxFrame in
                    // Convert the frame provided by the `Vision` framework into the preview layer’s coordinate system.
                    let previewLayerFrame = preview.layerRectConverted(fromMetadataOutputRect: boxFrame.applying(self.boundingBoxTransformManager.portraitTransform))

                    // Convert the frame from the preview layer’s coordinate system into the `textRecognitionResultsView` coordinate system.
                    let resultsViewFrame = self.textRecognitionResultsView.convert(previewLayerFrame, from: self.cameraView)

                    // Create and return a new text bounding box. Scale the frame up so it doesn't cover the text.
                    return CAShapeLayer.makeForTextBoundingBox(frame: resultsViewFrame.scaledAndCentered(1.15))
                }
            }
            .sink { [unowned self] boxes in
                self.textRecognitionResultsView.add(Set(boxes))
            }
            .store(in: &textRecognitionManagerSubscriptions)
    }

}
