//
//  DayDetailViewModel.swift
//  Forecast_MVVM
//
//  Created by Esther on 10/18/22.
//

import Foundation

protocol DayDetailViewModelDelegate: AnyObject {
    func updateViews()
}
///start with struct but change to class if you get immutable errors later on
class DayDetailViewModel {
    
    var forecastData: TopLevelDictionary?
    var days: [Day] {
        forecastData?.days ?? []
    }
    
    weak var delegate: DayDetailViewModelDelegate?
    
    private let networkingController: NetworkingContoller
    
    // Dependency Injection from view model to this view controller because this view should not exist without its view model. The act of injecting the dependency into the INITIALIZATION of this object.
    init(delegate: DayDetailViewModelDelegate, networkingController: NetworkingContoller = NetworkingContoller()) {
        self.delegate = delegate
        self.networkingController = networkingController
        
        fetchForecastData()
    }
    
    private func fetchForecastData() {
        networkingController.fetchDays { result in
            switch result {
            case .failure(let error):
                print(error.errorDescription)
            case .success(let tld):
                self.forecastData = tld
                DispatchQueue.main.async {
                    self.delegate?.updateViews()
                }
            }
        }
    }
    
    
} // End of Class
