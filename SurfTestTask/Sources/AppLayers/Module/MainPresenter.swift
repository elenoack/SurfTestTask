//
//  MainPresenter.swift
//  SurfTestTask
//
//  Created by Elena Noack on 08.02.23.
//

import Foundation

// MARK: - MainPresenterInputProtocol
protocol MainPresenterInputProtocol: AnyObject {
    func fetchData()
}

// MARK: - MainPresenter
final class MainPresenter: MainPresenterInputProtocol {

    // MARK: - Properties
    weak var view: MainPresenterOutputProtocol?
    private let dataManager: DataManagerProtocol

    //MARK: - Initialization
    init(dataManager: DataManagerProtocol) {
        self.dataManager = dataManager
    }

}

// MARK: - MainPresenterInputProtocol
extension MainPresenter {

    func fetchData() {
       let model = dataManager.createModels()
           prepareDataToConfigure(responce: .init(result: model))
   }

}

// MARK: - Private
extension MainPresenter {

    private func prepareDataToConfigure(responce: SurfDTO.GetContent.Response) {
        var cellViewModels = [[ViewModel]]()
        responce.result.forEach {
            let cellViewModel: [ViewModel] = $0.direction.map {
                return CollectionViewCellModel(content: $0.rawValue)
            }
            cellViewModels.append(cellViewModel)
        }
        let headerViewModel: [ViewModel] = responce.result.map {
            return CollectionViewHeaderModel(description: $0.description)
        }
        view?.configureView(with: cellViewModels,
                            and: headerViewModel)
    }

}
