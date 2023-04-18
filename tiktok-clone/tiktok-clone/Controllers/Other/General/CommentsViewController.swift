//
//  UserListViewController.swift
//  tiktok-clone
//
//  Created by Chima onyekwere on 3/25/23.
//

import UIKit

protocol CommentsViewControllerDelegate: AnyObject {
    func didTapCommentCloseButton(with viewController: CommentsViewController )

}

class CommentsViewController: UIViewController {
    private let post: PostModel

    weak var delegate : CommentsViewControllerDelegate?

    private var comments = [PostComment]()

    private let closeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage( UIImage(systemName: "xmark") , for: .normal)
        button.tintColor = .systemGray
        return button
    }()

    private let commentList: UITableView  = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(CommentsTableViewCell.self,
                           forCellReuseIdentifier: CommentsTableViewCell.identifier)
        return tableView
    }()

    init(post: PostModel){
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        commentList.delegate = self
        commentList.dataSource = self
        view.addSubview(commentList)
        view.addSubview(closeButton)
        fetchPostComments()
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        closeButton.frame = CGRect(x: view.width - 40, y: 16, width: 20, height: 20)
        commentList.frame = CGRect(x: 0, y: closeButton.bottom, width: view.width, height: view.height - closeButton.bottom)
    }


    @objc func didTapCloseButton() {
        delegate?.didTapCommentCloseButton(with: self)
    }

    func fetchPostComments() {
//        DatabaseManager.shared.fetchCOment
        self.comments = PostComment.mockCommets()
    }



}


extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = comments[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CommentsTableViewCell.identifier,
            for: indexPath
        ) as? CommentsTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: comment)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Go to profile of selected cell
//        let model = data[indexPath.row]
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Return an empty header view for the first section to create the spacing
        if section == 0 {
            return UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 2))
        }
        return nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 2
        }
        return 0
    }

}



