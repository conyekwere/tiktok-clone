//
//  HomeViewController.swift
//  tiktok-clone
//
//  Created by Chima onyekwere on 3/25/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    let horizontalScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = true
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    let forYouPageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .vertical,
        options: [:]
    )
    let followingPageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .vertical,
        options: [:]
    )
    
    
    private var forYouPosts = PostModel.mockModels()
    private var followingPosts = PostModel.mockModels()
    
    
    let segmentedControl : UISegmentedControl = {
        
        let titles = ["Following","For You "]
        let control = UISegmentedControl(items: titles)
        control.selectedSegmentIndex = 1
        control.backgroundColor = nil
        control.selectedSegmentTintColor = .white
        return control
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(horizontalScrollView)
        setUpfeed()
        horizontalScrollView.delegate = self
        horizontalScrollView.contentOffset = CGPoint(x:view.width, y: 0)
        setUpHeaderButtons()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        horizontalScrollView.frame = view.bounds
    }
    
    private func setUpHeaderButtons(){
        segmentedControl.addTarget(self, action: #selector(didChangeSegmentedControl(_:)), for: .valueChanged)
        navigationItem.titleView = segmentedControl
        
        
    }
    
    @objc private func didChangeSegmentedControl(_ sender: UISegmentedControl){
        
        horizontalScrollView.setContentOffset(CGPoint(x:view.width * CGFloat(sender.selectedSegmentIndex), y: 0), animated: true)
    }
    private func setUpfeed(){
        horizontalScrollView.contentSize = CGSize(width: view.width * 2, height: view.height)
        
        // For You
        setUpFollowFeed()
        setUpForYouFeed()
        
        
    }
    
    
    func setUpFollowFeed(){
        
        guard let model = followingPosts.first else {
            return
        }
        let vc = PostViewController(model: model)
        vc.delegate = self
        
        followingPageViewController.setViewControllers(
            [vc],
            direction: .forward,
            animated: false,
            completion: nil
        )
        
        followingPageViewController.dataSource = self
        
        horizontalScrollView.addSubview(followingPageViewController.view)
        followingPageViewController.view.frame = CGRect(x: 0, y: 0, width: horizontalScrollView.width, height: horizontalScrollView.height)
        addChild(followingPageViewController)
        followingPageViewController.didMove(toParent: self)
    }
    
    
    func setUpForYouFeed(){
        
        guard let model = forYouPosts.first else {
            return
        }
        let vc = PostViewController(model: model)
        vc.delegate = self
        forYouPageViewController.setViewControllers(
            [vc],
            direction: .forward,
            animated: false,
            completion: nil
        )
        
        forYouPageViewController.dataSource = self
        
        horizontalScrollView.addSubview(forYouPageViewController.view)
        forYouPageViewController.view.frame =  CGRect(x: view.width, y: 0, width: horizontalScrollView.width, height: horizontalScrollView.height)
        addChild(forYouPageViewController)
        forYouPageViewController.didMove(toParent: self)
    }
    
}


extension HomeViewController : UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let fromPost = (viewController as? PostViewController)?.model else {
            return nil
        }
        
        guard let index = currentPosts.firstIndex(where: { $0.identifier == fromPost.identifier})
        else {
            return nil
        }
        
        if index == 0 {
            return nil
        }
        
        let priorIndex = index - 1
        let model = currentPosts[priorIndex]
        let vc = PostViewController(model: model)
        vc.delegate = self
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let fromPost = (viewController as? PostViewController)?.model else {
            return nil
        }
        
        guard let index = currentPosts.firstIndex(where: { $0.identifier == fromPost.identifier})
        else {
            return nil
        }
        
        guard index < (currentPosts.count - 1) else {
            return nil
        }
        
        let nextIndex = index + 1
        let model = currentPosts[nextIndex]
        let vc = PostViewController(model: model)
        vc.delegate = self
        return vc
    }
    //check what the location of the view is, is it following or for you
    var currentPosts: [PostModel]{
        
        if horizontalScrollView.contentOffset.x == 0 {
            // Follow
            return followingPosts
        }
        
        // for you
        return forYouPosts
    }
    
}

extension HomeViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // if position is set at the extreme left or  is less than a viewwidht  move button to  following
        if scrollView.contentOffset.x == 0 || scrollView.contentOffset.x <= (view.width/2) {
            segmentedControl.selectedSegmentIndex = 0
        }
        // if position of view is set larger than a view move button to for you
        else if scrollView.contentOffset.x > (view.width/2) {
            segmentedControl.selectedSegmentIndex = 1
        }
    }
    
    
}


extension HomeViewController : PostViewControllerDelegate{
    
    func  postViewController(_ vc: PostViewController,didTapCommentButtonFor post : PostModel ){
        horizontalScrollView.isScrollEnabled = false
        if horizontalScrollView.contentOffset.x == 0 {
            //following
            
            followingPageViewController.dataSource = nil
            
        }
        else { // for you
            // return nil theres nothing to swift horizontally to
            forYouPageViewController.dataSource = nil
        }
        //(parent as? UIPageViewController)?.view?.isUserInteractionEnabled = false
        let vc = CommentsViewController(post: post)
        vc.delegate = self
        addChild(vc)
        vc.didMove(toParent: self)
        view.addSubview(vc.view)
        let bottomSheet: CGRect = CGRect(x: 0, y: view.height, width: view.width, height: view.height * 0.75)
        vc.view.frame = bottomSheet
        
        //on start animate show below the fold
        UIView.animate(withDuration: 0.2){
            vc.view.frame = CGRect(x: 0, y: self.view.height - bottomSheet.height, width: bottomSheet.width, height: bottomSheet.height)
        }
        
        segmentedControl.isEnabled = false
    }
    
    func postViewController(_ vc: PostViewController, didTapProfileButtonFor post: PostModel) {
        let user = post.user
        let vc = ProfileViewController(user: user)
        navigationController?.pushViewController(vc, animated: true)
    }
}



extension HomeViewController : CommentsViewControllerDelegate {
    func didTapCommentCloseButton(with viewController: CommentsViewController) {
        //close comments wit animation
        
        let bottomSheet = viewController.view.frame
        UIView.animate(withDuration: 0.2){
            viewController.view.frame = CGRect(x: 0, y: self.view.height , width: bottomSheet.width, height: bottomSheet.height)
        } completion: { [weak self] done in
            if done {
                DispatchQueue.main.async {
                    
                    // remove comment vc as child
                    viewController.view.removeFromSuperview()
                    viewController.removeFromParent()
                    //allow horizontal and vertical scroll
                    self?.horizontalScrollView.isScrollEnabled = true
                    self?.forYouPageViewController.dataSource = self
                    self?.followingPageViewController.dataSource = self
                    self?.segmentedControl.isEnabled = true
                }
            }
            
        }
    }
}
