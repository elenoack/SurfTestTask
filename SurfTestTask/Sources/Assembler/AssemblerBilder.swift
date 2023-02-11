//
//  AssemblerBilder.swift
//  SurfTestTask
//
//  Created by Elena Noack on 07.02.23.
//

import UIKit

// MARK: - AssemblyBuilderProtocol
protocol AssemblyBuilderProtocol {
    func configureMainModule() -> UIViewController
}

// MARK: - AssemblyBuilder
final class AssemblerBuilder: AssemblyBuilderProtocol {

    func configureMainModule() -> UIViewController {
        let dataService = MockDataService()
        let presenter = MainPresenter(dataService: dataService)
        let view = MainViewController(presenter: presenter)
        presenter.view = view
        return view
    }

}
