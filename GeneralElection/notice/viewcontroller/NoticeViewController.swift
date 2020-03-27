//
//  NoticeViewController.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/07.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import ImageSlideshow
import youtube_ios_player_helper

class NoticeViewController: BaseViewControllerWithViewModel<NoticeViewModel> {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var voteMethodViewContainer: UIView!
    @IBOutlet weak var voteMethodView: UIView!
    
    @IBOutlet weak var electionVideoView: UIView!
    @IBOutlet weak var youtubePlayerView: YTPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        setTransparentNavigationController()
        setShadowViewUnderNavigationController()
        
        setVoteMethodView()
        setElectionVideoView()
    }
    
    func setVoteMethodView() {
        let slideShow = ImageSlideshow(frame: voteMethodView.frame)
        slideShow.setImageInputs(viewModel!.votingImageSources)
        voteMethodView.addSubViewWithFullAutoLayout(subview: slideShow)
        
        let pageIndicator = UIPageControl()
        pageIndicator.currentPageIndicatorTintColor = UIColor.defaultColor
        pageIndicator.pageIndicatorTintColor = UIColor.lightGray
        slideShow.pageIndicator = pageIndicator
        slideShow.pageIndicatorPosition = PageIndicatorPosition(horizontal: .center, vertical: .under)
        slideShow.circular = false
        slideShow.zoomEnabled = true
    }
    
    func setElectionVideoView() {
        let playerVars: [AnyHashable : Any] = [
            "playsinline": 1
        ]
        youtubePlayerView.load(withVideoId: "swt1LrfFxL8", playerVars: playerVars)
    }
}

