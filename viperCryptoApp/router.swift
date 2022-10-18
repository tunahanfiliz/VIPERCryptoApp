//
//  router.swift
//  viperCryptoApp
//
//  Created by Ios Developer on 18.10.2022.
//

import Foundation
import UIKit
//ilk açldıgında hangi view gozukecek neler olacak tarzı diğer yerleri kontrol etmek
//class,protocol, entrypoint


typealias EntryPoint = AnyView & UIViewController // sağdaki degerleri direkt yazınca hatalar çıkıyordu bööyle yaptık

protocol AnyRouter {
    
    var entry : EntryPoint? {get}
    static func startExecution()-> AnyRouter    //static deme sebebimiz diger dosyalarda ulaşabilsin
    
}
class CryptoRouter : AnyRouter{
    var entry : EntryPoint?
    
    static func startExecution() -> AnyRouter {
        let router = CryptoRouter()
        
        var view : AnyView = CryptoViewController()
        var presenter : AnyPresenter = CryptoPresenter()
        var interactor : AnyInteractor = CryptoInteractor()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.router = router              //birbirleriyle baglandılar
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        router.entry = view as? EntryPoint    //giriş noktası
        //bunu kendi içinde tanımladık ama scene delegateye uygulama ilk açıldıgında gösterilecek ekrana tanımlamadık oraya git
        
        return router
    }
    
    
}
