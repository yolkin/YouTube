//
//  VideoLauncher.swift
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
        
        backgroundColor = .black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPlayer() {
        let urlString = "https://r4---sn-4g5e6n7k.googlevideo.com/videoplayback?requiressl=yes&mn=sn-4g5e6n7k&mm=31&ipbits=0&mv=m&mt=1483444636&ms=au&ei=aJJrWIXoHoKMNNDKgKgG&expire=1483466440&ip=46.53.183.4&key=yt6&lmt=1471379947191087&dur=295.566&itag=22&id=o-AH4PVTr1eZrQboM_xwhvbQDGcY3RJ3CU9RzEnJMHkWG2&mime=video%2Fmp4&upn=NTGWEisu-bg&sparams=dur%2Cei%2Cid%2Cinitcwndbps%2Cip%2Cipbits%2Citag%2Clmt%2Cmime%2Cmm%2Cmn%2Cms%2Cmv%2Cnh%2Cpl%2Cratebypass%2Crequiressl%2Csource%2Cupn%2Cexpire&initcwndbps=687500&pl=22&source=youtube&ratebypass=yes&nh=IgpwcjAyLmZyYTE1KgkxMjcuMC4wLjE&signature=654F64BDC319298AD7B9AFA86916540E22A26A66.5EF124D7001A4D476204B99429A746B564A6CEAA&title=Drake%20-%20Hotline%20Bling"
        if let url = URL(string: urlString) {
            player = AVPlayer(url: url)
            
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player?.play()
            
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            playPauseButton.isHidden = false
        }
    }
}

class VideoLauncher: NSObject {
    
    func showVideoPlayer() {
        if let keyWindow = UIApplication.shared.keyWindow {
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = .white
            UIApplication.shared.statusBarView?.backgroundColor = .clear
            
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            let vpView = VideoPlayerView(frame: CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: keyWindow.frame.width * 9 / 16))
            view.addSubview(vpView)
            
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
                view.frame = keyWindow.frame
            }, completion: { (completedAnimation) in
                UIApplication.shared.setStatusBarHidden(true, with: .fade)
            })
        }
    }
}
