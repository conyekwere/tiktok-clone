//
//  ExploreBannerCollectionViewCell.swift
//  tiktok-clone
//
//  Created by Chima onyekwere on 4/18/23.
//

import UIKit

class ExploreBannerCollectionViewCell: UICollectionViewCell {
    static let identifier = "ExploreBannerCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.font  = .systemFont(ofSize: 24, weight: .semibold)
        return label
        
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.addSubview(label)
        contentView.addSubview(imageView)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        label.sizeToFit()
        label.frame = CGRect(x: 10, y: contentView.height - 5 - label.height, width: label.width, height: label.height)
        imageView.frame = contentView.bounds
        //imageView.frame = CGRect(x: 0, y: 0, width: contentView.width, height: contentView.height)
        
        contentView.bringSubviewToFront(label)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        label.text = nil
    }
    
    func configure(with viewModel: ExploreBannerViewModel){
        label.text = viewModel.title
        imageView.image = viewModel.image
    }
}
