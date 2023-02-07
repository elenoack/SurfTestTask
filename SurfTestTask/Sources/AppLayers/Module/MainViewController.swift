//
//  MainViewController.swift
//  SurfTestTask
//
//  Created by Elena Noack on 06.02.23.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Views
    private let model = DataManger.shared.createModels()
    
    private var mainView: MainView? {
        guard isViewLoaded else { return nil }
        return view as? MainView
    }
    
    // MARK: - View Life Cycle
    override func loadView() {
        view = MainView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupView()
        setupPanGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateShowDimmedView()
        animatePresentContainer()
    }
    
    // MARK: - Configuration
    func setupCollectionView() {
        mainView?.containerView.collectionView.dataSource = self
        mainView?.containerView.collectionView.delegate = self
    }
    
    func setupView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleCloseAction))
        mainView?.backgroundImage.addGestureRecognizer(tapGesture)
    }
    
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = Sections(rawValue: section) else { return 0 }
        switch section {
        case .single:
            return model.first?.direction.count ?? 0
        case .double:
            return model.last?.direction.count ?? 0

        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(CollectionCell.self, for: indexPath)
        guard let section = Sections(rawValue: indexPath.section)
        else { return UICollectionViewCell() }


        switch section {
        case .single:
            let item = model.first?.direction[indexPath.row]
            cell.dataLabel.text = item?.rawValue
        case .double:
            let item = model.last?.direction[indexPath.row]
            cell.dataLabel.text = item?.rawValue
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        //        let headerView = collectionView.dequeueReusableHeader(HeaderView.self, for: indexPath)
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.id, for: indexPath) as? HeaderView else {
            return HeaderView() }
        guard let section = Sections(rawValue: indexPath.section) else { return UICollectionReusableView() }
        
        let item = model[indexPath.row]
        switch section {
        case .single:
            print(item.description)
            headerView.titleLabel.text = item.description
        case .double:
            headerView.titleLabel.text = item.description
        }
        return headerView
    }
    
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(CollectionCell.self, for: indexPath)
//        cell.backgroundColor = Constants.Colors.darkGrey
//        self.view.layoutIfNeeded()

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
    
    
    func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            self.mainView?.containerViewHeightConstraint?.constant = height
            self.view.layoutIfNeeded()
        }
        mainView?.currentContainerHeight = height
    }
    
    // MARK: Present and dismiss animation
    func animatePresentContainer() {
        // update bottom constraint in animation block
        UIView.animate(withDuration: 0.3) {
            self.mainView?.containerViewBottomConstraint?.constant = 0
            // call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
    }
    
    func animateShowDimmedView() {
        
        UIView.animate(withDuration: 0.4) {
            //            self.backgroundImage.alpha = self.maxDimmedAlpha
        }
    }
    
    func animateDismissView() {
        // hide blur view
        
        UIView.animate(withDuration: 0.4) {
        } completion: { _ in
            // once done, dismiss without animation
            self.dismiss(animated: false)
        }
        // hide main view by updating bottom constraint in animation block
        UIView.animate(withDuration: 0.3) {
            self.mainView?.containerViewBottomConstraint?.constant = self.mainView!.defaultHeight
            // call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - Actions
extension MainViewController {
    
    @objc
    func handleCloseAction() {
        animateDismissView()
    }
    
    @objc
    func handlePanGesture(gesture: UIPanGestureRecognizer) {
        guard let mainView = mainView else { return }
        let translation = gesture.translation(in: view)
        // Drag to top will be minus value and vice versa
        print("Pan gesture y offset: \(translation.y)")
        
        // Get drag direction
        let isDraggingDown = translation.y > 0
        print("Dragging direction: \(isDraggingDown ? "going down" : "going up")")
        
        // New height is based on value of dragging plus current container height
        let newHeight = mainView.currentContainerHeight - translation.y
        
        // Handle based on gesture state
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
