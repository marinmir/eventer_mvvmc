//
//  ProfileViewController.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class ProfileViewController: UIViewController {

    // MARK: - Private properties

    private var sections = [ProfileSectionViewModel]()
    private let viewModel: ProfileViewModelBindable
    private let disposeBag = DisposeBag()

    // MARK: - Initializers

    init(viewModel: ProfileViewModelBindable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    override func loadView() {
        super.loadView()

        let view = ProfileView()
        view.bind(to: viewModel)

        self.view = view
        
        view.dataSource = self
        view.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.sections.drive(onNext: { sections in
            self.sections = sections
        }).disposed(by: disposeBag)
        
        viewModel.onViewDidLoad()
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .avatar:
            return 1
        case .items(let items):
            return items.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .avatar(let avatarViewModel):
            let cell = ProfileAvatarCell()
            
            cell.configure(with: avatarViewModel)
            
            return cell
        case .items(let items):
            let cell = ProfileActionCell()
            
            cell.configure(with: items[indexPath.row])
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        switch indexPath.section {
        case 0:
            break
        case 1:
            switch indexPath.row {
            case 0:
                viewModel.onActionTapped(.organized)
            case 1:
                viewModel.onActionTapped(.participateIn)
            case 2:
                viewModel.onActionTapped(.recommended)
            default:
                break
            }
        case 2:
            switch indexPath.row {
            case 0:
                viewModel.onActionTapped(.termsOfUse)
            case 1:
                viewModel.onActionTapped(.about)
            default:
                break
            }
        default:
            break
        }
    }
}
