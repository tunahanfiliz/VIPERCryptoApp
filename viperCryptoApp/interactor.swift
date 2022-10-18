//
//  interactor.swift
//  viperCryptoApp
//
//  Created by Ios Developer on 18.10.2022.
//

import Foundation
//class, protocol . esas işler olcak
//presenterle konuscak. indirecegimiz verileride burda kullancaz.
//kriptolar burda incek
protocol AnyInteractor{
    var presenter : AnyPresenter? {get set}
    
    func downloadCryptos()
}

class CryptoInteractor: AnyInteractor{
    var presenter: AnyPresenter?
    
    func downloadCryptos() {
        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json") else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self]data, response, error in  //weak self zayıf referans denir . görünüm değiştiginde hafızada kalabılıyor verinin gitmesini saglar.
            
            guard let data = data, error == nil else{
                self?.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.NetworkFailed))
                return
            }
            do{
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                // presenterle konustur
                self?.presenter?.interactorDidDownloadCrypto(result: .success(cryptos))
                
            }catch{ // jsonda kodlar yanlıs geliyo olabilir belki oyuzsden parsingfail
                self?.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.ParsingFailed))
            }
            
            
            
            
        }
        task.resume()
    }
    
    
}
