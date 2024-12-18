//
//  QuotesListViewController.swift
//  BeeWell
//
//  Created by Furkan Doğan on 18.12.2024.
//

import UIKit

class QuotesListViewController: UIViewController {
    
    let viewModel: QuotesListViewModel
    
    lazy var quotesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.register(QuoteCell.self, forCellReuseIdentifier: QuoteCell.identifier)
        return tableView
    }()
    
    init(viewModel: QuotesListViewModel = QuotesListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.addSubscribers()
        viewModel.getQuotes()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(quotesTableView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        quotesTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
    }
}

extension QuotesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getQuoteCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = quotesTableView.dequeueReusableCell(withIdentifier: QuoteCell.identifier,
                                                             for: indexPath) as? QuoteCell else {
            return UITableViewCell()
        }
        let quote = viewModel.quote(by: indexPath.row)
        cell.configureCell(with: quote)
        return cell
    }
    
    
}
