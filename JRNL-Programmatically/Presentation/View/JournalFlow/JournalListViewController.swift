//
//  JournalListViewController.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/9/24.
//

import UIKit
import Combine

final class JournalListViewController: UIViewController {
    // MARK: - Components
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    private let viewModel: JournalListViewModel
    private var disposableBag = Set<AnyCancellable>()
    
    init(viewModel: JournalListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(JournalTableCell.self, forCellReuseIdentifier: JournalTableCell.identifier)
        
        configureUI()
        configureNavigationItems()
        
        viewModel.viewDidLoad()
        bind()
    }
    
    // MARK: - Methods
    func bind() {
        viewModel
            .$journals
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &disposableBag)
    }
    
    private func configureUI() {
        view.addSubview(tableView)
        
        view.backgroundColor = .white
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let global = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: global.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: global.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: global.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: global.bottomAnchor)
        ])
    }
    
    private func configureNavigationItems() {
        navigationItem.title = "Journal"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addJournal)
        )
    }
    
    @objc private func addJournal() {
        @Injected(AddJournalViewUseCaseKey.self) var useCase: AddJournalViewUseCase
        let viewController = AddJournalViewController(
            viewModel: AddJournalViewModel(
                useCase: useCase
            )
        )
        let navigationController = UINavigationController(rootViewController: viewController)
        present(navigationController, animated: true)
    }
}

extension JournalListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.journals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: JournalTableCell.identifier,
            for: indexPath
        ) as? JournalTableCell else {
            return UITableViewCell()
        }
        cell.setup(with: viewModel.journals[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
}

extension JournalListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let journal = viewModel.journals[indexPath.row]
        let viewController = JournalDetailTableViewController(
            viewModel: JournalDetailTableViewModel(journal: journal)
        )
        show(viewController, sender: self)
    }
}
