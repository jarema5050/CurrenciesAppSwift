//
//  ViewController.swift
//  currencies
//
//  Created by Jedrzej Sokolowski on 17/03/2020.
//  Copyright © 2020 JJ. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {
    
    private let decode : (Data) -> Any? = { (data) in
        do {
            let response = try JSONDecoder().decode(CurrencyHistory.self, from: data)
            return response
        }
        catch let error as NSError
        {
            print(error.localizedDescription)
            return nil
        }
    }
    
    
    private let spinner = SpinnerViewController()
    private var endDate : Date?
    private var startDate : Date?
    private var endpoint : Endpoints
    private var code : String
    private var response : CurrencyHistory?
    private var formView : FormView
    
    init(code: String, endpoint: Endpoints) {
        //print("Hello in new controller!")
        //let refreshControl = UIRefreshControl()
        //refreshControl.addTarget(self, action: #selector(didPullToRefresh), forControlEvents: .valueChanged)
        //view.addSubview(refreshControl)
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
        // Do any additional setup after loading the view.
    }
    func setupFormView(){
        
        formView.delegate = self
        
        formView.translatesAutoresizingMaskIntoConstraints = false
        formView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        formView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        formView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        formView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
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
                    print(response)
                    self.setNavigationItemTitle()
                }
            }
        }, errorHandling: { () in
            let queue = DispatchQueue(label: "Concurrent queue", attributes: .concurrent)
            DispatchQueue.main.sync {
                
                queue.sync {
                    let alert = UIAlertController(title: "Brak internetu", message: "Sprawdź połączenie sieciowe i odśwież przeciągając widok w dół.", preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

                    self.present(alert, animated: true)
                }
            }
            
        },decode: decode, path: path)
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
    
}
extension CurrencyViewController : DateChangeable {
    func passDates(startDate: String, endDate: String) {
        let endpoint = getEndpoint(startDate: startDate, endDate: endDate, parentEndpoint: self.endpoint, code: self.code)
        
        moveSpinner()
        fetchData(path: endpoint)
    }
}
