//
//  MainViewController.swift
//  SurfTestTask
//
//  Created by Elena Noack on 06.02.23.
//

import UIKit

// MARK: - MainPresenterOutputProtocol
protocol MainPresenterOutputProtocol: AnyObject {
    func configureView(with singleCellViewModel: [ViewModel],
                       with doubleCellViewModel: [ViewModel],
                       and headerViewModel: [ViewModel])
    func setNumberOfSections(number: Int)
}

final class MainViewController: UIViewController {

    // MARK: - Properties
    private let presenter: MainPresenterInputProtocol?
    private var singleCellViewModel = [ViewModel]()
    private var doubleCellViewModel = [ViewModel]()
    private var headerViewModel = [ViewModel]()
    private var numberOfSections = 0

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
        mainView?.containerView.collectionView.delegate = self
    }

}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = Sections(rawValue: section) else { return 0 }
        switch section {
        case .single:
            return singleCellViewModel.count
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
            let viewModel = singleCellViewModel[indexPath.row]
            cell.configure(with: viewModel)
        case .double:
            let viewModel = doubleCellViewModel[indexPath.row]
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
        let viewModel = headerViewModel[indexPath.section]
        switch section {
        case .single:
            headerView.configure(with: viewModel)
        case .double:
            headerView.configure(with: viewModel)
        }
        return headerView
    }

}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard let section = Sections(rawValue: indexPath.section)
        else { return }
        switch section {
        case .single:
            collectionView.performBatchUpdates({
                let selectCell = singleCellViewModel[indexPath.item]
                singleCellViewModel.remove(at: indexPath.item)
                singleCellViewModel.insert(selectCell, at: 0)
                self.mainView?.containerView.collectionView.moveItem(
                    at: indexPath,
                    to: [0, 0]
                )
            })
        case .double:
            collectionView.performBatchUpdates({
                let selectCell = doubleCellViewModel[indexPath.item]
                doubleCellViewModel.remove(at: indexPath.item)
                doubleCellViewModel.insert(selectCell, at: 0)
                self.mainView?.containerView.collectionView.moveItem(
                    at: indexPath,
                    to: [1, 0]
                )
            })
        }
    }

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
        let count = doubleCellViewModel.count
        guard count % 2 == 0 && count <= 10 else { return 0 }
            return count
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

    func setNumberOfSections(number: Int) {
        numberOfSections = number
    }

    func configureView(with singleCellViewModel: [ViewModel],
                       with doubleCellViewModel: [ViewModel],
                       and headerViewModel: [ViewModel]) {
        self.singleCellViewModel = singleCellViewModel
        self.doubleCellViewModel = doubleCellViewModel
        mainView?.containerView.countOfDoubleVM = doubleCellViewModel.count
        self.headerViewModel = headerViewModel
        DispatchQueue.main.async {
            self.mainView?.containerView.collectionView.reloadData()
        }
    }

}
