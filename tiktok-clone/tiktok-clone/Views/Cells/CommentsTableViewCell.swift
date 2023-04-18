//
//  CommentsTableViewCell.swift
//  tiktok-clone
//
//  Created by Chima onyekwere on 4/2/23.
//

import UIKit
import SDWebImage

protocol CommentsTableViewCellDelegate: AnyObject {
    func didTapFollowUnfollowButton(model: UserRelationship)
}
enum FollowState{
    case following
    case not_following
}

struct UserRelationship{
    
    let username: String
    let name: String
    let type: FollowState
}
class CommentsTableViewCell: UITableViewCell {
    static let identifier = "CommentsTableViewCell"

    weak var delegate: CommentsTableViewCellDelegate?

    private var model: UserRelationship?
    


    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let commentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .semibold)
//        label.text = "Joe"
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
//        label.text = "@joe"
        label.textColor = .secondaryLabel
        return label
    }()

    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(commentLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(avatarImageView)
        selectionStyle = .none
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        commentLabel.text = nil
        dateLabel.text = nil

    }
    
    public func configure(with model: PostComment) {
        commentLabel.text = model.text
        dateLabel.text = .date(with: model.date)
        guard let url = model.user.profilePictureURL else {
           return avatarImageView.image = UIImage(systemName: "person.circle")

        }
        avatarImageView.sd_setImage(with: url, completed: nil)
    }
    
    

    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        commentLabel.sizeToFit()
        dateLabel.sizeToFit()

        
        let imageSize: CGFloat = 44
        let labelWidth = contentView.width > 500 ? 220.0 : contentView.width/3.5
        let labelHeight = contentView.height/4
        avatarImageView.frame = CGRect(x: 16,
                                        y: (contentView.height-(contentView.height-8))/2,
                                        width: contentView.height-24,
                                        height: contentView.height-24)
        avatarImageView.layer.cornerRadius = avatarImageView.height/2.0

        let commentLabelHeight = min(contentView.height - dateLabel.top, commentLabel.height)
        commentLabel.frame = CGRect(x: avatarImageView.right+16,
                                 y:  (contentView.height-labelHeight)/3,
                                 width: contentView.width-8-avatarImageView.width-labelWidth,
                                 height: labelHeight)
        dateLabel.frame = CGRect(x: avatarImageView.right+16,
                                     y: commentLabel.bottom,
                                     width: contentView.width-8-avatarImageView.width-labelWidth,
                                     height: labelHeight)
        
        
    }
    
}
