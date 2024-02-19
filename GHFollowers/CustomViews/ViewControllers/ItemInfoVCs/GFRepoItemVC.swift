//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Noalino on 10/01/2024.
//

import UIKit

protocol GFItemInfoVCDelegate: AnyObject {
    func didTapGitHubProfile(for user: User)
}

class GFRepoItemVC: GFItemInfoVC {

    weak var delegate: GFItemInfoVCDelegate!

    init(user: User, delegate: GFItemInfoVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }

    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(color: .systemPurple, title: "GitHub Profile", systemImageName: "person")
    }

    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
}
