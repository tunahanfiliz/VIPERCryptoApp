//
//  presenter.swift
//  viperCryptoApp
//
//  Created by Ios Developer on 18.10.2022.
//

import Foundation
// herkesle konusan işleri hallettigimiz class,protocol
//interactor,vier,routerle baglantılı
// get mi get set mi olayı okunacak mı sadece yoksa hem okunup hem yazacak mı


enum NetworkError : Error {
    case NetworkFailed //net falan yok
    case ParsingFailed //veriler falan yanlıs
}



protocol AnyPresenter{
    var router : AnyRouter? {get set}
    var interactor : AnyInteractor? {get set}
    var view: AnyView? {get set}
    
    func interactorDidDownloadCrypto(result:Result<[Crypto],Error>) //result succes olursa cryptolar gelcek hataysa error
}

class CryptoPresenter : AnyPresenter{
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet{ //did set burdaki deger atanınca yapılacaklar demek. interactor ve presenter birbirine baglandıgında indircek
            interactor?.downloadCryptos()
        }
    }
    
    var view: AnyView?
    
    func interactorDidDownloadCrypto(result: Result<[Crypto], Error>) { //kripto indirilmiş bir şekilde buraya gelecek .bu fonksiyonda viewe gidecek kendini güncelle dicek
        switch result{
        case .success(let cryptos):   //succes ise kritoyu ver
            //view.update
            view?.update(with: cryptos)
            
        case .failure(_):
            //view.update error
            view?.update(with: "try again later")
        }
    
    }
    
    
    
}
