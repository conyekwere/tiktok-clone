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
       
        
        collectionView.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: "cell")
        collectionView.register(
            ExplorePostCollectionViewCell.self,
            forCellWithReuseIdentifier: ExplorePostCollectionViewCell.identifier)
        collectionView.register(
            ExploreBannerCollectionViewCell.self,
            forCellWithReuseIdentifier: ExploreBannerCollectionViewCell.identifier)
        collectionView.register(
            ExploreHashtagCollectionViewCell.self,
            forCellWithReuseIdentifier: ExploreHashtagCollectionViewCell.identifier)
        collectionView.register(
            ExploreUserCollectionViewCell.self,
            forCellWithReuseIdentifier: ExploreUserCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)

        self.collectionView = collectionView
    }
    
    
    private func configureModels(){
        
        // Banner
        
        var cells = [ExploreCell]()
        for _ in 0...1000 {
            let cell = ExploreCell.banner(
                viewModel: ExploreBannerViewModel(
                    image: UIImage(named: "textimg"),
                    title: "Foo",
                    handler: {
                
            }))
            cells.append(cell)
        }
        
        // Banner
        sections.append(
            ExploreSection(
                type: .banners,
                cells: ExploreManager.shared.getExploreBanners().compactMap({
                    return ExploreCell.banner(viewModel: $0)
                })
            )
        )

        
        var posts = [ExploreCell]()
        for _ in 0...40 {
            let post = ExploreCell.post(
                viewModel: ExplorePostViewModel(
                    thumbnailImage: UIImage(named: "textimg"),
                    caption:"This was a cool post and an long caption",
                    handler: {
            }))
            posts.append(post)
        }
        
        
        // Trending post
        sections.append(
            ExploreSection(
                type: .trendingPosts,
                cells: posts
            )
        )
        // Users
        sections.append(
            ExploreSection(
                type: .users,
                cells: [
                    .user(viewModel: ExploreUserViewModel(profilePicture: nil, username: "John Paher", followerCuunt: 50, handler: {})),
                    .user(viewModel: ExploreUserViewModel(profilePicture: nil, username: "Karl Reans", followerCuunt: 50, handler: {})),
                    .user(viewModel: ExploreUserViewModel(profilePicture: nil, username: "Fabio Swinet", followerCuunt: 50, handler: {})),
                    .user(viewModel: ExploreUserViewModel(profilePicture: nil, username: "Reggie Brown", followerCuunt: 50, handler: {})),
                    
                ]
            )
        )
        // Hashtags
        sections.append(
            ExploreSection(
                type: .trendingHashtags,
                cells: [
                    .hastag(viewModel: ExploreHashtagViewModel(text: "#technolgy", icon: UIImage(systemName: "bell"), count: 1, handler: {
                    })),
                    .hastag(viewModel: ExploreHashtagViewModel(text: "#startups", icon: UIImage(systemName: "bell"), count: 1, handler: {
                    })),
                    .hastag(viewModel: ExploreHashtagViewModel(text: "#big Tech", icon: UIImage(systemName: "bell"), count: 1, handler: {
                    })),
                    .hastag(viewModel: ExploreHashtagViewModel(text: "#media", icon: UIImage(systemName: "bell"), count: 1, handler: {
                    }))
                ]
            )
        )
        
        // recommended
        sections.append(
            ExploreSection(
                type: .recommended,
                cells: posts
            )
        )
        
        // Popular
        sections.append(
            ExploreSection(
                type: .popular,
                cells: posts
            )
        )
        
        // new recent
        sections.append(
            ExploreSection(
                type: .new,
                cells: posts
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
                // this is a gaurd because we are optionally assigning ExploreViewController
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreBannerCollectionViewCell.identifier, for: indexPath) as?
                ExploreBannerCollectionViewCell else {
                    return collectionView.dequeueReusableCell(
                        withReuseIdentifier: "cell",
                        for: indexPath
                    )
                }
            cell.configure(with: viewModel)
            return cell
        case .post(viewModel: let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExplorePostCollectionViewCell.identifier, for: indexPath) as?
                    ExplorePostCollectionViewCell else {
                        return collectionView.dequeueReusableCell(
                            withReuseIdentifier: "cell",
                            for: indexPath
                        )
                    }
            cell.configure(with: viewModel)
            return cell
        case .hastag(viewModel: let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreHashtagCollectionViewCell.identifier, for: indexPath) as? ExploreHashtagCollectionViewCell else {
                    return collectionView.dequeueReusableCell(
                        withReuseIdentifier: "cell",
                        for: indexPath
                    )
            }
            cell.configure(with: viewModel)
            return cell
        case .user(viewModel: let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreUserCollectionViewCell.identifier, for: indexPath) as?
                    ExploreUserCollectionViewCell else {
                        return collectionView.dequeueReusableCell(
                            withReuseIdentifier: "cell",
                            for: indexPath
                        )
                    }
            cell.configure(with: viewModel)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        HapticsManager.shared.vibrateForSelection()
        
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
    }
    
    
}


extension  ExploreViewController: UISearchBarDelegate {
    
    
}



// MARK - Section Layouts

extension ExploreViewController{
    
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
                    widthDimension: .absolute(150),
                    heightDimension: .absolute(200)
                ),
                subitems: [item]
            )
            
            
            // Section Layout
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .continuous
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
                    heightDimension: .absolute(300)
                ),
                subitem: item,
                count: 2
            )
            
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(100),
                    heightDimension: .absolute(300)
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
}
