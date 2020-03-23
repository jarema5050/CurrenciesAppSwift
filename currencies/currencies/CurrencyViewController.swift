//
//  ViewController.swift
//  currencies
//
//  Created by Jedrzej Sokolowski on 17/03/2020.
//  Copyright © 2020 JJ. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {
    
    private let spinner = SpinnerViewController()
    private var endDate : Date?
    private var startDate : Date?
    private var endpoint : Endpoints
    private var code : String
    private var response : CurrencyHistory?
    private var formView : FormView
    private var tableView = UITableView()
    
    private let rateCell = "rateCell"
    init(code: String, endpoint: Endpoints) {
        self.endpoint = endpoint
        self.code = code
        self.formView = FormView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(formView)
        setupFormView()
        view.backgroundColor = .white
        navigationItem.title = code
        setupTableView()
        
        tableView.isHidden = true
        configureTableView()
        //tableView.backgroundColor = .gray
        // Do any additional setup after loading the view.
    }
    func configureTableView() {
        //view.addSubview(tableView)
        tableView.rowHeight = 60
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: rateCell)
    }
    func setupFormView(){
        
        formView.delegate = self
        
        formView.translatesAutoresizingMaskIntoConstraints = false
        formView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        formView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        formView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        formView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
    }
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
    }
    func getEndpoint(startDate: String, endDate: String, parentEndpoint: Endpoints, code: String) -> String {
        var char = ""
        switch parentEndpoint {
        case Endpoints.TableA:
            char = "A"
        case Endpoints.TableB:
            char = "B"
        default:
            char = "C"
        }
        
        return "http://api.nbp.pl/api/exchangerates/rates/\(char)/\(code)/\(startDate)/\(endDate)/"
        
        
    }
    
    fileprivate func fetchData(path: String) {
        Service.getTableData(completion:{ response in
            self.response = response as! CurrencyHistory
            let queue = DispatchQueue(label: "Concurrent queue", attributes: .concurrent)
            DispatchQueue.main.sync {
                queue.sync {
                    //self.collectionView.reloadData()
                    //self.createSpinnerView()
                    self.removeSpinner()
                    self.tableView.isHidden = false
                    self.setNavigationItemTitle()
                    self.setupHeaderView()
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
            }
        }, errorHandling: { () in
            let queue = DispatchQueue(label: "Concurrent queue", attributes: .concurrent)
            DispatchQueue.main.sync {
                
                queue.sync {
                    self.removeSpinner()
                    let alert = UIAlertController(title: "Brak internetu", message: "Sprawdź połączenie sieciowe i odśwież przeciągając widok w dół.", preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

                    self.present(alert, animated: true)
                }
            }
            
        },decode:
            {(data) in
        do {
            let response = try JSONDecoder().decode(CurrencyHistory.self, from: data)
            return response
        }
        catch let error as NSError
        {
            print(error.localizedDescription)
            let queue = DispatchQueue(label: "Concurrent queue", attributes: .concurrent)
            DispatchQueue.main.sync {
                queue.sync {
                    self.removeSpinner()
                    let alert = UIAlertController(title: "Wystąpił błąd", message: "Nie odnaleziono żądanych danych.", preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

                    self.present(alert, animated: true)
                }
            }
            return nil
                }}, path: path)
        
    }
    
    fileprivate func setNavigationItemTitle(){
        if let response = response {
            navigationItem.title = response.currency
        }
        
    }
    
    func moveSpinner() {

        // add the spinner view controller
        addChild(spinner)
        spinner.view.frame = view.frame
        view.addSubview(spinner.view)
        spinner.didMove(toParent: self)
    }
    
    func removeSpinner(){
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 1.0))
        spinner.willMove(toParent: nil)
        spinner.view.removeFromSuperview()
        spinner.removeFromParent()
    }
    func setupHeaderView(){
        let headerView = UIView()
        headerView.backgroundColor = AppColors.lightGrey
        view.addSubview(headerView)

        let stackView : UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.alignment = .fill
            stackView.distribution = .equalSpacing
            return stackView
        }()
        
        headerView.addSubview(stackView)
        
        let dateLabel : UILabel = {
            let label = UILabel()
            label.text = "Data"
            label.textColor = .gray
            return label
        }()
        
        stackView.addArrangedSubview(dateLabel)
        
        
        
        if let table = response?.table {
            let rateLabel : UILabel
            
            if table == "C"{
                rateLabel = {
                    let label = UILabel()
                    label.text = "KUPNO"
                    label.textColor = .gray
                    return label
                }()
                
                let additionalRateLabel : UILabel = {
                    let label = UILabel()
                    label.text = "SPRZEDAŻ"
                    label.textColor = .gray
                    return label
                }()
                
                stackView.addArrangedSubview(additionalRateLabel)
            }
            else {
                rateLabel = {
                    let label = UILabel()
                    label.text = "ŚREDNI"
                    label.textColor = .gray
                    return label
                }()
                
            }
            stackView.addArrangedSubview(rateLabel)
        }
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.bottomAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: tableView.widthAnchor).isActive = true
        headerView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: tableView.widthAnchor, multiplier: 0.9).isActive = true
        stackView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor).isActive = true
    }
    
}

extension CurrencyViewController : DateChangeable {
    func passDates(startDate: String, endDate: String) {
        let endpoint = getEndpoint(startDate: startDate, endDate: endDate, parentEndpoint: self.endpoint, code: self.code)
        
        moveSpinner()
        fetchData(path: endpoint)
    }
}

extension CurrencyViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response?.rates.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: rateCell) as! TableViewCell
        if let rate = response?.rates[indexPath.row] {
            if let mid = rate.mid {
                cell.setProperties(date: rate.effectiveDate, rate: String(mid), additionalRate: nil)
            }
            else {
                cell.setProperties(date: rate.effectiveDate, rate: String(rate.bid!), additionalRate: String(rate.ask!))
            }
        }
        return cell
    }
    
}
