//
//  VideoPlayer.swift
//  YouTube
//
//  Created by Alexander on 03.01.17.
//  Copyright © 2017 Alexander. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    var player: AVPlayer?
    
    let controlsContainerView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.startAnimating()
        return indicatorView
    }()
    
    let durationLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 11)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let playingTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var videoSlider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        slider.setThumbImage(UIImage(named: "thumb"), for: .normal)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(changeSlider), for: .valueChanged)
        return slider
    }()
    
    func changeSlider() {
        if let duration = player?.currentItem?.duration {
            let seconds = CMTimeGetSeconds(duration)
            let value = Double(videoSlider.value) * seconds
            
            let seekTime  = CMTime(value: Int64(value), timescale: 1)
            
            player?.seek(to: seekTime, completionHandler: { (completedSeek) in
                
            })
        }
    }
    
    lazy var playPauseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "pause"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.isHidden = true
        
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        
        return button
    }()
    
    func isPlaying() -> Bool {
        return player!.rate != 0 && player!.error == nil
    }
    
    func pressButton() {
        if isPlaying() {
            player?.pause()
            playPauseButton.setImage(UIImage(named: "play"), for: .normal)
        } else {
            player?.play()
            playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPlayer()
        addGradient()
        
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        controlsContainerView.addSubview(playPauseButton)
        playPauseButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        playPauseButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        playPauseButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        playPauseButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        controlsContainerView.addSubview(durationLabel)
        durationLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        durationLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
        durationLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        durationLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        controlsContainerView.addSubview(playingTimeLabel)
        playingTimeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        playingTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
        playingTimeLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        playingTimeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        controlsContainerView.addSubview(videoSlider)
        videoSlider.rightAnchor.constraint(equalTo: durationLabel.leftAnchor).isActive = true
        videoSlider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        videoSlider.leftAnchor.constraint(equalTo: playingTimeLabel.rightAnchor).isActive = true
        videoSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        backgroundColor = .black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPlayer() {
        let urlString = "https://www.dropbox.com/s/e3xzqcnc08crdue/Homer%27s%20Sirtaki.mp4?dl=1"
        if let url = URL(string: urlString) {
            player = AVPlayer(url: url)
            
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player?.play()
            
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            
            let interval = CMTime(value: 1, timescale: 2)
            player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
                let seconds = CMTimeGetSeconds(progressTime)
                let secondsString = String(format: "%02d", Int(seconds.truncatingRemainder(dividingBy: 60)))
                let minutesString = String(format: "%02d", Int(seconds / 60))
                
                self.playingTimeLabel.text = "\(minutesString):\(secondsString)"
                
                if let duration = self.player?.currentItem?.duration {
                    let durationSeconds = CMTimeGetSeconds(duration)
                    
                    self.videoSlider.value = Float(seconds / durationSeconds)
                }
            })
        }
    }
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.7, 1.2]
        controlsContainerView.layer.addSublayer(gradientLayer)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            playPauseButton.isHidden = false
            
            if let duration = player?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(duration)
                
                let minutesText = String(format: "%02d", Int(seconds) / 60)
                let secondsText = Int(seconds) % 60
                durationLabel.text = "\(minutesText):\(secondsText)"
            }
        }
    }
}

class VideoLauncher: NSObject {
    
    let minimizeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "minimize"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    func showVideoPlayer() {
        if let keyWindow = UIApplication.shared.keyWindow {
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = .white
            UIApplication.shared.statusBarView?.backgroundColor = .clear
            
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            let vpView = VideoPlayerView(frame: CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: keyWindow.frame.width * 9 / 16))
            view.addSubview(vpView)
            
            view.addSubview(minimizeButton)
            minimizeButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
            minimizeButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
            minimizeButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 4).isActive = true
            minimizeButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            
            let viView = VideoInfoView(frame: CGRect(x: 0, y: keyWindow.frame.width * 9 / 16, width: keyWindow.frame.width, height: 600))
            view.addSubview(viView)
            viView.topAnchor.constraint(equalTo: vpView.bottomAnchor).isActive = true

            
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
                view.frame = keyWindow.frame
            }, completion: { (completedAnimation) in
                UIApplication.shared.setStatusBarHidden(true, with: .fade)
            })
        }
    }
}
