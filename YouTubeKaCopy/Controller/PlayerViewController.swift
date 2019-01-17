//
//  PlayerViewController.swift
//  YouTubeKaCopy
//
//  Created by Shivam Aditya on 13/12/18.
//  Copyright © 2018 Shivam Aditya. All rights reserved.
//

import AVFoundation
import GoogleInteractiveMediaAds
import UIKit

class PlayerViewController: UIViewController, IMAAdsLoaderDelegate, IMAAdsManagerDelegate {
    
    static var kTestAppContentUrl_MP4 = "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8"//"http://rmcdn.2mdn.net/Demo/html5/output.mp4"
    
    var videoPlaybackURL = ""
    
    //@IBOutlet weak var playButton: UIButton!
    //@IBOutlet weak var videoView: UIView!
    
    let videoView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    var contentPlayer: AVPlayer?
    var playerLayer: AVPlayerLayer?
    
    var contentPlayhead: IMAAVPlayerContentPlayhead?
    var adsLoader: IMAAdsLoader!
    var adsManager: IMAAdsManager!
    
    let kTestAppAdTagUrl =
        "https://pubads.g.doubleclick.net/gampad/ads?sz=640x480&" +
            "iu=/124319096/external/single_ad_samples&ciu_szs=300x250&impl=s&gdfp_req=1&env=vp&" +
            "output=vast&unviewed_position_start=1&" +
    "cust_params=deployment%3Ddevsite%26sample_ct%3Dlinear&correlator="; //pre ad

//    let kTestAppAdTagUrl =
//        "https://pubads.g.doubleclick.net/gampad/ads?sz=640x480&" +
//            "iu=/124319096/external/ad_rule_samples&ciu_szs=300x250&ad_rule=1&impl=s&gdfp_req=1&env=vp&" +
//            "output=vmap&unviewed_position_start=1&" +
//            "cust_params=deployment%3Ddevsite%26sample_ar%3Dpostonly&cmsid=496&vid=short_onecue&" +
//    "correlator="; //post ad
    
//    let kTestAppAdTagUrl =
//        "https://pubads.g.doubleclick.net/gampad/ads?sz=640x480&iu=/124319096/external/ad_rule_samples&ciu_szs=300x250&ad_rule=1&impl=s&gdfp_req=1&env=vp&output=vmap&unviewed_position_start=1&cust_params=deployment%3Ddevsite%26sample_ar%3Dpremidpostpod&cmsid=496&vid=short_onecue&correlator="; //all ads

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpContentPlayer()
        setUpAdsLoader()
        
        requestAds()
        setupViews()
    }
    
    func setupViews() -> Void {
        view.addSubview(videoView)
        
        //horizontal constraints
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: videoView)
        //addConstraintsWithFormat(format: "H:|[v0]|", views: videoView)
        
        //vertical constraints
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: videoView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        playerLayer?.frame = self.videoView.layer.bounds
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        contentPlayer?.pause()
    }
    
//    @IBAction func onPlayButtonTouch(_ sender: AnyObject) {
//        //contentPlayer.play()
//        requestAds()
//        playButton.isHidden = true
//    }
    
    func setUpContentPlayer() {
        // Load AVPlayer with path to our content.
        guard let contentURL = URL(string: videoPlaybackURL) else {
            print("ERROR: please use a valid URL for the content URL")
            return
        }
        contentPlayer = AVPlayer(url: contentURL)
        
        // Create a player layer for the player.
        playerLayer = AVPlayerLayer(player: contentPlayer)
        
        // Size, position, and display the AVPlayer.
        playerLayer?.frame = videoView.layer.bounds
        videoView.layer.addSublayer(playerLayer!)
        
        // Set up our content playhead and contentComplete callback.
        contentPlayhead = IMAAVPlayerContentPlayhead(avPlayer: contentPlayer)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(PlayerViewController.contentDidFinishPlaying(_:)),
            name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
            object: contentPlayer?.currentItem);
    }
    
    @objc func contentDidFinishPlaying(_ notification: Notification) {
        // Make sure we don't call contentComplete as a result of an ad completing.
        if (notification.object as! AVPlayerItem) == contentPlayer?.currentItem {
            adsLoader.contentComplete()
        }
    }
    
    func setUpAdsLoader() {
        adsLoader = IMAAdsLoader(settings: nil)
        adsLoader.delegate = self
    }
    
    func requestAds() {
        // Create ad display container for ad rendering.
        let adDisplayContainer = IMAAdDisplayContainer(adContainer: videoView, companionSlots: nil)
        // Create an ad request with our ad tag, display container, and optional user context.
        let request = IMAAdsRequest(
            adTagUrl: kTestAppAdTagUrl,
            adDisplayContainer: adDisplayContainer,
            contentPlayhead: contentPlayhead,
            userContext: nil)
        
        adsLoader.requestAds(with: request)
    }
    
    // MARK: - IMAAdsLoaderDelegate
    
    func adsLoader(_ loader: IMAAdsLoader!, adsLoadedWith adsLoadedData: IMAAdsLoadedData!) {
        // Grab the instance of the IMAAdsManager and set ourselves as the delegate.
        adsManager = adsLoadedData.adsManager
        adsManager.delegate = self
        
        // Create ads rendering settings and tell the SDK to use the in-app browser.
        let adsRenderingSettings = IMAAdsRenderingSettings()
        adsRenderingSettings.webOpenerPresentingController = self
        
        // Initialize the ads manager.
        adsManager.initialize(with: adsRenderingSettings)
    }
    
    func adsLoader(_ loader: IMAAdsLoader!, failedWith adErrorData: IMAAdLoadingErrorData!) {
        print("Error loading ads: \(adErrorData.adError.message)")
        contentPlayer?.play()
    }
    
    // MARK: - IMAAdsManagerDelegate
    
    func adsManager(_ adsManager: IMAAdsManager!, didReceive event: IMAAdEvent!) {
        if event.type == IMAAdEventType.LOADED {
            // When the SDK notifies us that ads have been loaded, play them.
            adsManager.start()
        }
    }
    
    func adsManager(_ adsManager: IMAAdsManager!, didReceive error: IMAAdError!) {
        // Something went wrong with the ads manager after ads were loaded. Log the error and play the
        // content.
        print("AdsManager error: \(error.message)")
        contentPlayer?.play()
    }
    
    func adsManagerDidRequestContentPause(_ adsManager: IMAAdsManager!) {
        // The SDK is going to play ads, so pause the content.
        contentPlayer?.pause()
    }
    
    func adsManagerDidRequestContentResume(_ adsManager: IMAAdsManager!) {
        // The SDK is done playing ads (at least for now), so resume the content.
        contentPlayer?.play()
    }
}

