//
//  videoThubnail.swift
//  Flat.kz
//
//  Created by Bakdaulet Myrzakerov on 5/12/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation

func thumbnailForVideoAtURL(url: URL) -> UIImage? {
    let asset = AVAsset(url: url)
    let assetImageGenerator = AVAssetImageGenerator(asset: asset)

    var time = asset.duration
    time.value = min(time.value, 2)

    do {
        let imageRef = try assetImageGenerator.copyCGImage(at: time, actualTime: nil)
        return UIImage(cgImage: imageRef)
    } catch {
        print("error")
        return nil
    }
}

