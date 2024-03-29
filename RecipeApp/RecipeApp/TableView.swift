//
//  TableView.swift
//  RecipeApp
//
//  Created by DCS on 05/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//
import UIKit
class TableView: UIViewController {
    private var cityState = [Int]()
    
    private let myTableView = UITableView()
    
    private var cityArray = ["Kofta","Potato Dumplings","Bangkok Beef","Vaifala","Thai Coconut Custard", "Fresh Fruit Tart", "Tuyo Fried Rice", "Fresh Lumpia", "Cheese Sticks", "Fresh Fruit Tart", "Frose"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Menu"
        view.addSubview(myTableView)
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        myTableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.height - view.safeAreaInsets.top)
    }
}

extension TableView: UITableViewDataSource, UITableViewDelegate {
    
    private func setupTableView() {
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(CityCell.self, forCellReuseIdentifier: "CityCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! CityCell
        
        cell.setupCityCellWith(title: cityArray[indexPath.row], index: indexPath.row, and: (cityState.contains(indexPath.row) ? true : false))
        //cell.myButton.addTarget(self, action: #selector(openCityDetails), for: .touchUpInside)
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CityCell
        if !cityState.contains(indexPath.row) {
            cityState.append(indexPath.row)
            //cell.animateCell(at: indexPath.row)
        }
        openCityDetails(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            myTableView.beginUpdates()
            cityArray.remove(at: indexPath.row)
            myTableView.deleteRows(at: [indexPath], with: .fade)
            myTableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    @objc private func openCityDetails(_ sender:Int) {
        navigationController?.pushViewController(WebViewController(search: cityArray[sender]), animated: true)
    }
   

}
