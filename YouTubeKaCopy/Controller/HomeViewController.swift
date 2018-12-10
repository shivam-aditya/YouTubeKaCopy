//
//  ViewController.swift
//  YouTubeKaCopy
//
//  Created by Shivam Aditya on 04/12/18.
//  Copyright © 2018 Shivam Aditya. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var videos: [Video] = {
        var srkChannel = Channel()
        srkChannel.name = "SRK"
        srkChannel.profileImageName = "srk-zoomed"
        
        var srkChannel2 = Channel()
        srkChannel2.name = "SRK2"
        srkChannel2.profileImageName = "srk"
        
        var mereNaamTuVideo = Video()
        mereNaamTuVideo.title = "ZERO: Mere Naam Tu"
        mereNaamTuVideo.thumbnailImageName = "MereNaamTu"
        mereNaamTuVideo.channel = srkChannel
        
        var mereNaamMainVideo = Video()
        mereNaamMainVideo.title = "0: Mere Naam Main"
        mereNaamMainVideo.thumbnailImageName = "kakashi1"
        mereNaamMainVideo.channel = srkChannel2

        return [mereNaamTuVideo, mereNaamMainVideo]
    }()
    
    let menuBar : MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationItem.title = "YoutubeKaCopy/Home"
        navigationController?.navigationBar.isTranslucent = false
        
        setTitle()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: videoCellIdentifier)
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        setupMenuBar()
        setupNavBarButtons()
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
        return videos.count
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: videoCellIdentifier, for: indexPath) as! VideoCell
        
        cell.video = videos[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = ((view.frame.width - 16 - 16) * 9/16) + 84// 16 + 68
        return CGSize(width: view.frame.width, height: height)
    }
}

