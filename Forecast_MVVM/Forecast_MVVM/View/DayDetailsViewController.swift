//
//  DayDetailsViewController.swift
//  Forecast_MVVM
//
//  Created by Karl Pfister on 2/13/22.
//

import UIKit

class DayDetailsViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var dayForcastTableView: UITableView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentHighLabel: UILabel!
    @IBOutlet weak var currentLowLabel: UILabel!
    @IBOutlet weak var currentDescriptionLabel: UILabel!
    
    //MARK: - Properties
    // I don't think I need these
    //    var forcastData: TopLevelDictionary?
    //    var days: [Day] = []
    
    private var viewModel: DayDetailViewModel!
    
    //MARK: - View Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Assign Delegate from View Model
        self.viewModel = DayDetailViewModel(delegate: self)
        // Conform to the TBVS Protocols
        dayForcastTableView.dataSource = self
        
    }
}


//MARK: - Extenstions
extension DayDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.forecastData?.days.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath) as? DayForcastTableViewCell else {return UITableViewCell()}
        let day = viewModel.days[indexPath.row]
        cell.updateViews(day: day)
        return cell
    }
}
extension DayDetailsViewController: DayDetailViewModelDelegate {
    func updateViews() {
        let currentDay = viewModel.days[0]
        cityNameLabel.text = viewModel.forecastData?.cityName ?? "No City Found"
        currentDescriptionLabel.text = currentDay.weather.description
        currentTempLabel.text = "\(currentDay.temp)F"
        currentLowLabel.text = "\(currentDay.lowTemp)F"
        currentHighLabel.text = "\(currentDay.highTemp)F"
        dayForcastTableView.reloadData()
    }
}

