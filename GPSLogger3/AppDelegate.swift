//
//  AppDelegate.swift
//  GPSLogger3
//
//  Created by Yu on 2024/08/08.
//

import UIKit
import CoreLocation

class AppDelegate: NSObject, UIApplicationDelegate, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        debugPrint("application")
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.requestAlwaysAuthorization()
            locationManager.allowsBackgroundLocationUpdates = true
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = 1
            locationManager.pausesLocationUpdatesAutomatically = false
            locationManager.delegate = self
            
            if launchOptions?[.location] != nil {
                locationManager.startMonitoringSignificantLocationChanges()
            }
        }
        
        return true
        
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        debugPrint(deviceToken.base64EncodedString())
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        locationManager.startMonitoringSignificantLocationChanges()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        locationManager.startMonitoringSignificantLocationChanges()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func addLog(_ log: String) -> Void {
        debugPrint("log", log)
        
        if UserDefaults.standard.object(forKey: "logs") == nil {
            UserDefaults.standard.set([], forKey: "logs")
        }
        var logs : [String] = UserDefaults.standard.object(forKey: "logs") as! [String]
        logs.append(log)
        UserDefaults.standard.set(logs, forKey: "logs")
    }
    
    func checkLogs() -> Void {
        if UserDefaults.standard.object(forKey: "logs") != nil {
            let logs : [String] = UserDefaults.standard.object(forKey: "logs") as! [String]
            print("logs:\(logs)")
        }
    }
    
    func removeLogs() -> Void {
        UserDefaults.standard.set([], forKey: "logs")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location : CLLocation = locations.last!;
        self.addLog(location.description)
    }
   
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint("error:\(error)")
    }
   
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .restricted) {
            debugPrint("restricted");
        }
        else if (status == .denied) {
            debugPrint("denied");
        }
        else if (status == .authorizedWhenInUse) {
            debugPrint("authorizedWhenInUse");
        }
        else if (status == .authorizedAlways) {
            debugPrint("authorizedAlways");
            locationManager.startUpdatingLocation();
        }
    }
}
