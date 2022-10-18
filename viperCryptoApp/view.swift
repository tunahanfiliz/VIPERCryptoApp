 //
//  view.swift
//  viperCryptoApp
//
//  Created by Ios Developer on 18.10.2022.
//

import Foundation
import UIKit
// view --> presenterle konusacak ..
// class , protocol. protocol testler için avantaj .
// viewcontroller

protocol AnyView{
    var presenter : AnyPresenter? {get set}
    
    func update(with cryptos: [Crypto])
    func update(with error: String)  // ya kripto vericek ya error
}

class CryptoViewController : UIViewController, AnyView,UITableViewDataSource,UITableViewDelegate{
    var presenter: AnyPresenter?
    
    //cryptolar aşagıda update olduktan sonra gösterilmesi gerekiyor ondann bu diziyi oluşturduk
    var cryptos : [Crypto] = []
    
    private let tableView : UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true //ilk veri inerken boş tableview göstermek istemedigimiz için görünmez yapabiliriz
        return table
    }()
    
    private let messageLabel : UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.text = "downloading..."
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        view.addSubview(tableView) //oluşturdugumuz görünümler bu sekilde eklenir.
        
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews() // boyutu nerde olcak ekranda nerde buluncak belirtmemiz gerekiyor
        tableView.frame = view.bounds // ekranımız ne kadarsa tableviewda o kadar olacak
        messageLabel.frame = CGRect(x: view.frame.width/2 - 100, y: view.frame.height/2 - 25, width: 200, height: 50)    // TAM ORTADA BULUNSUN İSTİYORUM. x genişligin tam ortasında demek -100 demek yuksekliign tam ortasına denk getircek 200 çünkğ.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        var content = cell.defaultContentConfiguration()       //cell.label falan yapmanın bir yöntemi content yani içerik oluşturmak. bu default ayarlayıcı yukarda aşagıda ne gösterilsin diyeb iliyor
        content.text = cryptos[indexPath.row].currency
        content.secondaryText = cryptos[indexPath.row].price
        //contenti celle bagla
        cell.contentConfiguration = content
        cell.backgroundColor = .yellow
        return cell
    }
    
    
    
    
    
    func update(with cryptos: [Crypto]) { //kriptolar geldikten sonra o listenin içine koyalim dispatch...
        DispatchQueue.main.async {
            self.cryptos = cryptos
            self.messageLabel.isHidden = true // kriptolar geldi dowlading yazısı kalksın
            self.tableView.reloadData() //veriler geldi güncellensin
            self.tableView.isHidden = false // verilerim gösterilsin
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.cryptos = []
            self.tableView.isHidden = true
            self.messageLabel.text = error
            self.messageLabel.isHidden = false
        }
    }
    
    
}
