import UIKit
import Combine
import FeatureFoundation

final class ListContactsViewController: UIViewController {
    
    private var viewModel: ListContactsViewModel
    private var displayState: ListContactsDisplayState
    private var cancellables = Set<AnyCancellable>()

    lazy private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 120
        tableView.register(
            ListContactsCellView.self,
            forCellReuseIdentifier: String(describing: ListContactsCellView.self)
        )
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    public init(viewModel: ListContactsViewModel) {
        self.viewModel = viewModel
        self.displayState = .emptyDisplayState()
        super.init(nibName: nil, bundle: nil)
        
        setupViews()
        binding()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad?()
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    private func binding() {
        viewModel.displayStateSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] displayState in
                self?.updateDisplayState(displayState)
            }.store(in: &cancellables)
    }
        
    private func updateDisplayState(_ displayState: ListContactsDisplayState) {
        self.displayState = displayState
        title = displayState.navigationControllerTitle
        tableView.reloadData()
    }
}

extension ListContactsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayState.contactsCellViewDisplayState.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ListContactsCellView.self), for: indexPath) as? ListContactsCellView else {
            return UITableViewCell()
        }
        
        let contactDisplayState = displayState.contactsCellViewDisplayState[indexPath.row]
        cell.fullnameLabel.text = contactDisplayState.name
        cell.contactImage.setImage(from: contactDisplayState.photoURL)
        
        return cell
    }
}
