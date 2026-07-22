//
//  NativeAdObservable.swift
//
//  Created on 2026-07-22.
//

import Foundation
import Observation
import GoogleMobileAds

@MainActor @Observable public final class NativeAdObservable: NSObject {
    
    private let TEST_AD_UNIT = "ca-app-pub-3940256099942544/3986624511"
    
    public var nativeAd: NativeAd?
    private var adLoader: AdLoader?
    private var ads: [NativeAd] = []
    
    public func start() {
        MobileAds.shared.start()
    }
    
    public func load() {
        self.adLoader = AdLoader(adUnitID: TEST_AD_UNIT, rootViewController: nil, adTypes: [.native], options: nil)
        self.adLoader?.delegate = self
        self.adLoader?.load(Request())
    }
    
    func nextAd() -> NativeAd? {
        guard !ads.isEmpty else { return nil }
        
        let ad = ads.removeFirst()
        self.adLoader?.load(Request())
        return ad
    }
}

extension NativeAdObservable: NativeAdLoaderDelegate {
    
    public func adLoader(_ adLoader: AdLoader, didReceive nativeAd: NativeAd) {
        self.nativeAd = nativeAd
        print("###")
        print(nativeAd.description)
        print(nativeAd.advertiser)
        print(nativeAd.body)
        print(nativeAd.headline)
    }
    
    public func adLoader(_ adLoader: AdLoader, didFailToReceiveAdWithError error: Error) {
        print("###")
        print(error.localizedDescription)
        print(error as NSError)
    }
}

