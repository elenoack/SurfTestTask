//
//  MainViewController.swift
//  SurfTestTask
//
//  Created by Elena Noack on 06.02.23.
//

import UIKit

// MARK: - MainPresenterOutputProtocol
protocol MainPresenterOutputProtocol: AnyObject {
    func configureView(with viewModel: [[ViewModel]],
                       and headerViewModel: [ViewModel])
}

final class MainViewController: UIViewController {

    // MARK: - Properties
    private let presenter: MainPresenterInputProtocol?
    private var cellViewModel = [[ViewModel]]()
    private var headerViewModel = [ViewModel]()

    // MARK: - Views

    private var mainView: MainView? {
        guard isViewLoaded else { return nil }
        return view as? MainView
    }

    // MARK: - Initialization
    init(presenter: MainPresenterInputProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError(Strings.initError)
    }
    
    // MARK: - View Life Cycle
    override func loadView() {
        view = MainView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.fetchData()
        setupCollectionView()
        setupPanGesture()
        handleCompletion()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animatePresentContainer()
    }
    
    // MARK: - Configuration
    func setupCollectionView() {
        mainView?.containerView.collectionView.dataSource = self
//        mainView?.containerView.collectionView.delegate = self
    }

}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return cellViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = Sections(rawValue: section) else { return 0 }
        switch section {
        case .single:
            return cellViewModel.first?.count ?? 0
        case .double:
            return getCountForDoubleSection()

        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(CollectionCell.self, for: indexPath)
        guard let section = Sections(rawValue: indexPath.section)
        else { return UICollectionViewCell() }
        switch section {
        case .single:
            let viewModel = cellViewModel.first?[indexPath.row]
            cell.configure(with: viewModel)
        case .double:
            let viewModel = cellViewModel.last?[indexPath.row]
            cell.configure(with: viewModel)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableHeader(HeaderView.self, for: indexPath)
                as? HeaderView else { return HeaderView() }
        guard let section = Sections(rawValue: indexPath.section) else { return UICollectionReusableView() }
        switch section {
        case .single:
            headerView.configure(with: headerViewModel.first)
        case .double:
            headerView.configure(with: headerViewModel.last)
        }
        return headerView
    }

}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {


}

// MARK: - Private
extension MainViewController {

    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        mainView?.containerView.addGestureRecognizer(panGesture)
    }

    private func handleCompletion() {
        ButtonsStackView.responseCompletion = { [weak self] in
            self?.showAlert(title: Strings.congratulations,
                      message: Strings.alertMessage)
        }
    }

    private func getCountForDoubleSection() -> Int {
        guard let count = cellViewModel.last?.count
        else { return 0 }
        if count % 2 == 0 && count <= 10 {
            return count
        } else {
            return 0
        }
    }

}

// MARK: - Animation
extension MainViewController {

    private func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            self.mainView?.containerViewHeightConstraint?.constant = height
            self.view.layoutIfNeeded()
        }
        mainView?.currentContainerHeight = height
    }

    func animatePresentContainer() {
        UIView.animate(withDuration: 0.3) {
            self.mainView?.containerViewBottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
    }

}

// MARK: - Actions
extension MainViewController {

    @objc
    func handlePanGesture(gesture: UIPanGestureRecognizer) {
        guard let mainView = mainView else { return }
        let translation = gesture.translation(in: view)
        let isDraggingDown = translation.y > 0
        let newHeight = mainView.currentContainerHeight - translation.y

        switch gesture.state {
        case .changed:
            if newHeight < mainView.maximumContainerHeight && newHeight > mainView.currentContainerHeight {
                mainView.containerViewHeightConstraint?.constant = newHeight
                view.layoutIfNeeded()
            }
        case .ended:
            if newHeight < mainView.defaultHeight {
                animateContainerHeight(mainView.defaultHeight)
            } else if newHeight < mainView.maximumContainerHeight && isDraggingDown {
                animateContainerHeight(mainView.defaultHeight)
            } else if newHeight > mainView.defaultHeight && !isDraggingDown {
                animateContainerHeight(mainView.maximumContainerHeight)
            }
        default:
            break
        }
    }
    
}

// MARK: - MainPresenterOutputProtocol
extension MainViewController: MainPresenterOutputProtocol {

    func configureView(with viewModel: [[ViewModel]],
                       and headerViewModel: [ViewModel]) {
        cellViewModel = viewModel
        self.headerViewModel = headerViewModel
        mainView?.containerView.collectionView.reloadData()
    }

}
