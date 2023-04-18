//
//  UserListViewController.swift
//  tiktok-clone
//
//  Created by Chima onyekwere on 3/25/23.
//

import AVFoundation
import UIKit


protocol PostViewControllerDelegate: AnyObject {
    func postViewController(_ vc: PostViewController,didTapCommentButtonFor post : PostModel )
    
    func postViewController(_ vc: PostViewController,didTapProfileButtonFor post : PostModel )
    
}
class PostViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let  colors: [UIColor] = [
            .red, .green, .black, .orange, .blue, .white, .systemPink
        ]
        
        view.backgroundColor = colors.randomElement()
        configureVideo()
        setUpButtons()
        setUpDoubleTapToLike()
        
        view.addSubview(profileButton)
        view.addSubview(captionLabel)

        profileButton.addTarget(self, action: #selector(didTapPostProfile), for: .touchUpInside)
    
    }
    
    
    
    weak var delegate: PostViewControllerDelegate?
    var model: PostModel
    
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    private let commentButton:UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "bubble.left.fill"), for: .normal)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()

    private let shareButton:UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "arrowshape.turn.up.forward.fill"), for: .normal)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    private let profileButton:UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "textimg"), for: .normal)
        button.tintColor = .white
        button.layer.masksToBounds = true
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    private let captionLabel:UILabel = {
        let label = UILabel()
        label.textColor = . white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22)
        label.text = "It was only a matter of time #code #coding #programming #techtok #tech"
        return label
    }()
    
    var player: AVPlayer?

    private var playerDidFinishObserver: NSObjectProtocol?
    
    // MARK: - Init
    
    init(model: PostModel){
        
        self.model = model
        super.init(nibName: nil, bundle: nil)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let size: CGFloat = 35
        let yStart: CGFloat = view.height - (size * 4)  - view.safeAreaInsets.bottom -  (tabBarController?.tabBar.height ?? 0 )
        for(index,button) in [likeButton,commentButton,shareButton].enumerated(){
            button.frame = CGRect(x: view.width - size - 20 , y: yStart + (CGFloat(index) * 10) + (CGFloat(index) * size), width: size, height: size - 3)
        }
        captionLabel.sizeToFit()
        let labelSize = captionLabel.sizeThatFits(CGSize(width: view.width - size - 12 , height: view.height))
        captionLabel.frame = CGRect(
            x: 10,
            y: view.height - 10 -  view.safeAreaInsets.bottom - labelSize.height - (tabBarController?.tabBar.height ?? 0),
            width: view.width - size - 24,
            height: labelSize.height)
        
        profileButton.frame = CGRect(
            x: likeButton.left - 10,
            y: likeButton.top - 10 - (size + 20) ,
            width: size + 20 ,
            height: size + 20)
        
        profileButton.layer.cornerRadius = (size + 20)/2
    }
 
    
    

    private func configureVideo(){
        //guard is to unwrap optional. because this could equate to zero
        guard let path = Bundle.main.path(forResource: "videoPost", ofType: "mp4") else {
            return
        }
        
        let url = URL(fileURLWithPath: path)
        player = AVPlayer(url: url)
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resizeAspectFill

        playerLayer.frame = view.bounds
        
        view.layer.addSublayer(playerLayer)
        
        player?.volume = 0
        player?.play()
        
        guard let playerControl = player else  {
            return
        }
        
        // unwrap optional with playerControl
        
        playerDidFinishObserver = NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: playerControl.currentItem,
            queue: .main
        ) { _ in
            // At the end of player video set player
            playerControl.seek(to: .zero)
            playerControl.play()
            
        }
    }
    

    
    @objc private func didTapPostProfile(){
       
        delegate?.postViewController(self, didTapProfileButtonFor: model)
    }
    
    
    func setUpButtons(){
        view.addSubview(likeButton)
        view.addSubview(commentButton)
        view.addSubview(shareButton)
        likeButton.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(didTapComment), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)
    }
    
    
    @objc private func didTapLike(){
       
        model.isLikedByCurrentUser = !model.isLikedByCurrentUser
        
        likeButton.tintColor = model.isLikedByCurrentUser ? .systemRed : .white
    }
    
    @objc private func didTapComment(){
        // Present comment tray place functionality inside home view controller so that you can disable scroll to other post and horizonatal post
        delegate?.postViewController(self, didTapCommentButtonFor: model)
        
        
        var scrollToPost = (parent as? UIPageViewController)?.view?.isUserInteractionEnabled
       // scrollToPost = !scrollToPost!
        scrollToPost = false
       
    }
    
    @objc private func didTapShare(){
       
        guard let url = URL(string: "https://www/tiktok.com") else {
            return
        }
        
        let vc = UIActivityViewController(
            activityItems: [url],
            applicationActivities: []
        )
        present(vc,animated: true)
    }
        
    func setUpDoubleTapToLike(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(didDoubleTap(_:)))
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
    }
    
    @objc private func didDoubleTap(_ gesture: UITapGestureRecognizer){
        if !model.isLikedByCurrentUser{
            model.isLikedByCurrentUser = true
        }
        
        
        
        
        let touchPoint = gesture.location(in: view)
        let imageView = UIImageView(image: UIImage(systemName: "heart.fill"))
        //imageView.tintColor = .systemRed
        imageView.frame = CGRect (x: 0, y: 0, width: 75, height: 75)
        imageView.center = touchPoint
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0
        
        
        
        
        // Create a CAGradientLayer with a red gradient
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.systemPink.cgColor, UIColor.white.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = imageView.bounds

        // Create a UIImage from the original image
        guard let originalImage = imageView.image else { return }
        UIGraphicsBeginImageContextWithOptions(originalImage.size, false, originalImage.scale)
        originalImage.draw(in: CGRect(x: 0, y: 0, width: originalImage.size.width, height: originalImage.size.height))
        guard let tintedImage = UIGraphicsGetImageFromCurrentImageContext() else { return }
        UIGraphicsEndImageContext()

        // Apply the gradient tint color to the UIImage
        UIGraphicsBeginImageContextWithOptions(originalImage.size, false, originalImage.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.translateBy(x: 0, y: originalImage.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.clip(to: CGRect(x: 0, y: 0, width: originalImage.size.width, height: originalImage.size.height), mask: tintedImage.cgImage!)
        gradientLayer.render(in: context)
        guard let gradientImage = UIGraphicsGetImageFromCurrentImageContext() else { return }
        UIGraphicsEndImageContext()
        
        let transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        
        
        // Set the tinted image to the image view
        imageView.image = gradientImage
        view.addSubview(imageView)
        
        UIView.animate(withDuration: 0.2){
            imageView.alpha = 1
        } completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                    UIView.animate(withDuration: 0.5){
                        imageView.alpha = 0
                        imageView.transform = transform
                    } completion: { done in
                        if done {
                            imageView.removeFromSuperview()
                        }
                    }
                }
            }
        }
        
    }
    
}
