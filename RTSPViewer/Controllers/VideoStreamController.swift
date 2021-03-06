//
//  VideoStreamController.swift
//  RTSPViewer
//
//  Created by mani on 2020-01-26.
//  Copyright © 2020 mani. All rights reserved.
//

import UIKit

class VideoStreamController: UIViewController {
    @IBOutlet weak var videoView: VideoView!
    var videoStreamURL: URL? {
        willSet {
            if let url = newValue {
                if let videoView = videoView {
                    videoView.loadVideo(from: url)
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = videoStreamURL else { return }

        videoView.textLabel.font = UIFont.systemFont(ofSize: 40.0)

        title = url.host

        navigationController?.setNavigationBarHidden(true, animated: false)

        videoView.loadVideo(from: url)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
}

extension VideoStreamController {
    // MARK: Device Orientation

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override var shouldAutorotate: Bool {
        return true
    }
}

extension VideoStreamController {
// MARK: IBActions

    @IBAction func close(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func handleTap(gesture: UITapGestureRecognizer) {
        if let hidden = navigationController?.isNavigationBarHidden {
            navigationController?.setNavigationBarHidden(!hidden, animated: true)
        }
    }
}
