//
//  ExploreViewController.swift
//  tiktok-clone
//
//  Created by Chima onyekwere on 3/25/23.
//

import UIKit




class ExploreViewController: UIViewController {

    private let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search..."
        bar.layer.cornerRadius = 8
        bar.layer.masksToBounds = true
        return bar
    }()
    

    private var sections = [ExploreSection]()
    
    private var collectionView: UICollectionView?
    
    // why is the collectionView optional ?
    // we will configure collectionview in function setUpCollectionView

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureModels()
        setUpSearchBar()
        setUpCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    
    func setUpSearchBar(){
        navigationItem.titleView = searchBar
        searchBar.delegate = self
    }
    
    func setUpCollectionView(){
        let layout = UICollectionViewCompositionalLayout { section, _ -> NSCollectionLayoutSection? in
            //return NSCollectionLayoutSection
            // return self.layout(for: section)
            
            return self.layout(for: section )
        }
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        view.addSubview(collectionView)
        
//        collectionView.backgroundColor = .systemBackground
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemFill
        view.addSubview(collectionView)

        self.collectionView = collectionView
    }
    
    func layout(for section : Int ) -> NSCollectionLayoutSection {
        let sectionType = sections[section].type
        
        switch sectionType {
        case .banners:
            // Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4 )
            
            // Group
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension: .absolute(200)
                ),
                subitems: [item]
            )
            
            
            // Section Layout
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .groupPaging
            // Return
            return sectionLayout

        case .users:
            // Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4 )
            
            // Group
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(200),
                    heightDimension: .absolute(200)
                ),
                subitems: [item]
            )
            
            
            // Section Layout
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .groupPaging
            // Return
            return sectionLayout
        case .trendingHashtags:
            // Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4 )
            
            // Group
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(60)
                ),
                subitems: [item]
            )
            
            
            // Section Layout
            let sectionLayout = NSCollectionLayoutSection(group: verticalGroup)
            // Return
            return sectionLayout
        case .popular:
            // Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4 )
            
            // Group
            
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(110),
                    heightDimension: .absolute(200)
                ),
                subitems: [item]
            )
            
            
            // Section Layout
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .continuous
            // Return
            return sectionLayout
        case .trendingPosts, .new, .recommended:
            // Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4 )
            
            // Group
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(100),
                    heightDimension: .absolute(240)
                ),
                subitem: item,
                count: 2
            )
            
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(100),
                    heightDimension: .absolute(240)
                ),
                subitems: [verticalGroup]
            )
            
            
            // Section Layout
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .continuous
            // Return
            return sectionLayout
        }
        
    
        
    }
    
    func configureModels(){
        var cells = [ExploreCell]()
        for _ in 0...1000 {
            let cell = ExploreCell.banner(
                viewModel: ExploreBannerViewModel(
                    image: nil,
                    title: "Foo",
                    handler: {
                
            }))
            cells.append(cell
            )
        }
        // Featured
        sections.append(
            ExploreSection(
                type: .banners,
                cells: cells
            )
        )

        
        var posts = [ExploreCell]()
        for _ in 0...29 {
            let post = ExploreCell.post(
                viewModel: ExplorePostViewModel(
                    thumbnailImage: nil,
                    caption:"Foo",
                    handler: {
            }))
            posts.append(post)
        }
        
        
        // Trending Videos
        sections.append(
            ExploreSection(
                type: .trendingPosts,
                cells: posts
            )
        )
        // Popular Creators
        sections.append(
            ExploreSection(
                type: .users,
                cells: [
                    .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, username: "Foo", followerCount: 50, handler: {})),
                    .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, username: "Foo", followerCount: 50, handler: {})),
                    .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, username: "Foo", followerCount: 50, handler: {})),
                    .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, username: "Foo", followerCount: 50, handler: {})),
                    
                ]
            )
        )
        // Hashtags
        sections.append(
            ExploreSection(
                type: .trendingHashtags,
                cells: [
                    .hastag(viewModel: ExploreHashtagViewModel(text: "", icon: nil, count: 0, handler: {
                    })),
                    .hastag(viewModel: ExploreHashtagViewModel(text: "", icon: nil, count: 0, handler: {
                    })),
                    .hastag(viewModel: ExploreHashtagViewModel(text: "", icon: nil, count: 0, handler: {
                    })),
                    .hastag(viewModel: ExploreHashtagViewModel(text: "", icon: nil, count: 0, handler: {
                    }))
                ]
            )
        )
        
        // Recommended
        sections.append(
            ExploreSection(
                type: .recommended,
                cells: [
                    .post(
                        viewModel: ExplorePostViewModel(
                            thumbnailImage: nil,
                            caption:"Foo",
                            handler: {
                    })),
                    .post(
                        viewModel: ExplorePostViewModel(
                            thumbnailImage: nil,
                            caption:"Foo",
                            handler: {
                    })),
                    .post(
                        viewModel: ExplorePostViewModel(
                            thumbnailImage: nil,
                            caption:"Foo",
                            handler: {
                    })),
                    .post(
                        viewModel: ExplorePostViewModel(
                            thumbnailImage: nil,
                            caption:"Foo",
                            handler: {
                    }))
                ]
            )
        )
        
        // Popular
        sections.append(
            ExploreSection(
                type: .popular,
                cells: [
                    .post(
                        viewModel: ExplorePostViewModel(
                            thumbnailImage: nil,
                            caption:"Foo",
                            handler: {
                    })),
                    .post(
                        viewModel: ExplorePostViewModel(
                            thumbnailImage: nil,
                            caption:"Foo",
                            handler: {
                    })),
                    .post(
                        viewModel: ExplorePostViewModel(
                            thumbnailImage: nil,
                            caption:"Foo",
                            handler: {
                    })),
                    .post(
                        viewModel: ExplorePostViewModel(
                            thumbnailImage: nil,
                            caption:"Foo",
                            handler: {
                    }))
                ]
            )
        )
        
        // Recently Posted
        sections.append(
            ExploreSection(
                type: .new,
                cells: [
                    .post(
                        viewModel: ExplorePostViewModel(
                            thumbnailImage: nil,
                            caption:"Foo",
                            handler: {
                    })),
                    .post(
                        viewModel: ExplorePostViewModel(
                            thumbnailImage: nil,
                            caption:"Foo",
                            handler: {
                    })),
                    .post(
                        viewModel: ExplorePostViewModel(
                            thumbnailImage: nil,
                            caption:"Foo",
                            handler: {
                    })),
                    .post(
                        viewModel: ExplorePostViewModel(
                            thumbnailImage: nil,
                            caption:"Foo",
                            handler: {
                    }))
                ]
            )
        )
    }
}


extension  ExploreViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = sections[indexPath.section].cells[indexPath.row]
        
        switch model {
            
        case .banner(viewModel: let viewModel):
            break
        case .post(viewModel: let viewModel):
            break
        case .hastag(viewModel: let viewModel):
            break
        case .user(viewModel: let viewModel):
            break
        }
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cell",
            for: indexPath
        )
        cell.backgroundColor = .systemRed
        return cell
    }
    
    
    
}


extension  ExploreViewController: UISearchBarDelegate {
    
    
}
