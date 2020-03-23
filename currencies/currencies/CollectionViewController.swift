//
//  CollectionViewController.swift
//  currencies
//
//  Created by Jedrzej Sokolowski on 17/03/2020.
//  Copyright © 2020 JJ. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let reuseIdentifier = "Cell"
    private let reuseIdentifierHeader = "Header"
    private let refreshControl = UIRefreshControl()
    var currentEndpoint = Endpoints.TableA
    
    var response : Response?
    
    private let decode : (Data) -> Any? = { (data) in
        do {
            let response = try JSONDecoder().decode([Response].self, from: data)
            return response[0]
        }
        catch let error as NSError
        {
            print(error.localizedDescription)
            return nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        refreshControl.beginRefreshing()
        self.setupCollectionView()
        
        self.fetchData(path: currentEndpoint.rawValue)
        
        // Do any additional setup after loading the view.
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        return response?.rates.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        
        if let response = response {
            let rate = response.rates[indexPath.row]
            if let mid = rate.mid {
                print(mid)
                cell.setButton(mid: String(mid), bid: nil, ask: nil, date: response.effectiveDate, code: rate.code, name: rate.currency)
            }
            else{
                cell.setButton(mid: nil, bid: String(rate.bid!), ask: String(rate.ask!), date: response.effectiveDate, code: rate.code, name: rate.currency)
            }
        }
       
        cell.delegate = self
        
        // Configure the cell
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
    UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:(view.frame.width-36) * 0.5, height: (view.frame.width-6) * 0.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdentifierHeader, for: indexPath) as! HeaderView
        
        header.delegate = self
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }

}

extension CollectionViewController {
    
    fileprivate func fetchData(path: String) {
        Service.getTableData(completion:{ response in
            self.response = response as! Response
            let queue = DispatchQueue(label: "Concurrent queue", attributes: .concurrent)
            DispatchQueue.main.sync {
                queue.sync {
                    self.collectionView.reloadData()
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
        
        self.refreshControl.endRefreshing()
    }
    
    func setupCollectionView(){
        
        setupRefreshControl()
        registerReusableCells()
        collectionView.backgroundColor = .white
    }
    
    private func registerReusableCells(){
        self.collectionView!.register(CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: reuseIdentifierHeader)
        self.collectionView.contentInset = UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15);
    }
    private func setupRefreshControl(){
        collectionView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        refreshControl.tintColor = AppColors.lightGreen
        refreshControl.attributedTitle = NSAttributedString(string: "Pobieranie danych...", attributes: nil)
        refreshControl.transform = CGAffineTransform(scaleX: 1.75, y: 1.75);
    }
    
    @objc private func refreshData(_ sender: Any) {
        fetchData(path: currentEndpoint.rawValue)
    }
}

extension CollectionViewController : Selectable {
    
    func chooseCurrency(code: String) {
        navigationController?.pushViewController(CurrencyViewController(code: code, endpoint: currentEndpoint), animated: false)
    }
    
    func changeDataSource(endpoint: Endpoints) {
        fetchData(path: endpoint.rawValue)
        currentEndpoint = endpoint
    }   
}
