//
//  ViewController.swift
//  YouTubeKaCopy
//
//  Created by Shivam Aditya on 04/12/18.
//  Copyright © 2018 Shivam Aditya. All rights reserved.
//

import UIKit
import AVKit

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
//    var videos: [Video] = {
//        var srkChannel = Channel()
//        srkChannel.name = "SRK"
//        srkChannel.profileImageName = "srk-zoomed"
//
//        var srkChannel2 = Channel()
//        srkChannel2.name = "SRK2"
//        srkChannel2.profileImageName = "srk"
//
//        var mereNaamTuVideo = Video()
//        mereNaamTuVideo.title = "ZERO: Mere Naam Tu"
//        mereNaamTuVideo.thumbnailImageName = "MereNaamTu"
//        mereNaamTuVideo.channel = srkChannel
//
//        var mereNaamMainVideo = Video()
//        mereNaamMainVideo.title = "0: Mere Naam Main"
//        mereNaamMainVideo.thumbnailImageName = "kakashi1"
//        mereNaamMainVideo.channel = srkChannel2
//
//        return [mereNaamTuVideo, mereNaamMainVideo]
//    }()
    
    var results : YoutubeSearchModel? = nil
    
    let menuBar : MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationItem.title = "YoutubeKaCopy/Home"
        navigationController?.navigationBar.isTranslucent = false
        UINavigationBar.appearance().tintColor = .white
        
        setTitle()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: videoCellIdentifier)
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        setupMenuBar()
        setupNavBarButtons()
        
        YTDataService().getYTSearchData { (ytSearchModel) in
            self.results = ytSearchModel
            print(ytSearchModel)
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func setupNavBarButtons(){
        //search button
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        //searchBarButtonItem.tintColor = .white
        
        //more button
        let moreImage = UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal)
        let moreBarButtonItem = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems = [moreBarButtonItem, searchBarButtonItem]
    }
    
    @objc func handleSearch() -> Void {
        print("search tapped")
    }
    
    @objc func handleMore() -> Void {
        print("more tapped")
    }
    
    private func setupMenuBar() -> Void {
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }
    
    fileprivate func setTitle() {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return 5
        //return videos.count
        if let itemsCount = results?.items?.count{
            return itemsCount
        }
        else{
            return 1
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: videoCellIdentifier, for: indexPath) as! VideoCell
        
        //cell.video = videos[indexPath.row]
        if let itemsCount = results?.items?.count {
            if(itemsCount>1){
                cell.video = results?.items?[indexPath.row]
            }
            else{
                //else cases where items come but are nil
            }
        }
        else{
            //else cases where items are nil
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = ((view.frame.width - 32) * 9/16) + 117// 16 + height image + 8 + 44 + 16 (new)+ 16 + 1 //96
        return CGSize(width: view.frame.width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let itemsCount = results?.items?.count{
            let selectedVideoItem = results?.items?[indexPath.row]
            
            if let selectedVideoItemId = selectedVideoItem?.id?.videoId {
                showLoader()
                YTDataService().getYTStreamingUrl(videoId: selectedVideoItemId) { (urlString) in
                    if let videoURL = urlString {
                        self.hideLoader()
                        let player = AVPlayer(url: URL(string: videoURL)!)
                        
                        //let playerViewController = AVPlayerViewController()
                        //playerViewController.player = player
                        let playerViewController = PlayerViewController()
                        
                        playerViewController.videoPlaybackURL = "https://bloomtv.pc.cdn.bitgravity.com/December-2018/13122018195239_bigstory630.mp4"
                        //playerViewController.videoPlaybackURL = videoURL
                        
                        self.navigationController?.pushViewController(playerViewController, animated: true)
                        
//                        self.present(playerViewController, animated: true) {
//                            player.play()
//                        }
                    }
                    else{
                        self.hideLoader()
                    }
                }
            }
        }
        else{
            //no items to tap kispe kiya??
        }
    }
    
    func showLoader() -> Void {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func hideLoader() -> Void {
        dismiss(animated: false, completion: nil)
    }
}

