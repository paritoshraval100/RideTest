//
//  VehicleViewController.swift
//  RideTest
//
//  Created by Paritosh_raval on 21/07/21.
//

import UIKit
import MapKit

class VehicleViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let vehicleViewModel = VehicleViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        vehicleViewModel.delegate = self
        vehicleViewModel.getVehicleData()
    }
    
    // MARK: - Map and CollectionView set up
    
    func showMap() {
        
        // Setup MapView
        mapView.delegate = self
        let coords = vehicleViewModel.getLocationArray()
        for coord in coords{
            mapView.addAnnotation(coord);
        }
        
        // Setup region based onnn San Francisco
        let regionRadius: CLLocationDistance = 100000
        let coordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
                                                  latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func showAnnotation() {
        
        // Open Annotation
        
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint),
           let artwork = vehicleViewModel.getAnnotationFor(indexPath: visibleIndexPath, annotations: mapView.annotations)  {
            mapView.selectAnnotation(artwork, animated: true)
        }
    }
    
    func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.alwaysBounceHorizontal = true
        collectionView.reloadData()
    }
    
}

// MARK: - MKMapView Delegate Methods

extension VehicleViewController: MKMapViewDelegate {
    
    func mapView(
        _ mapView: MKMapView,
        viewFor annotation: MKAnnotation
    ) -> MKAnnotationView? {
        guard let annotation = annotation as? VehicleAnnotation else {
            return nil
        }
        let identifier = "artwork"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(
            withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(
                annotation: annotation,
                reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .roundedRect)
        }
        view.tag = annotation.id
        return view
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        // Scroll detail screen baesd on Annotation selection
        let indexPath = vehicleViewModel.getIndexPathFor(annotationView: view)
        let rect = self.collectionView.layoutAttributesForItem(at:indexPath)?.frame
        self.collectionView.scrollRectToVisible(rect!, animated: true)
    }
    
}

// MARK: - UICollectionView Datasource methods

extension VehicleViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vehicleViewModel.vehicles.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "DetailCell",
            for: indexPath
        ) as! DetailCell
        let vehicle = vehicleViewModel.getVehicle(for: indexPath)
        cell.update(vehicle: vehicle)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width,
                      height: collectionView.bounds.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        // open Annotation based on Detail view.
        showAnnotation()
    }
}
              
// MARK: - VehicleViewModelDelegate Methods

extension VehicleViewController: VehicleViewModelDelegate {
    func vehiclesFound() {
        showMap()
        setUpCollectionView()
        showAnnotation()
    }
    
    func noVehiclesFound() {
        print("No Vehicles Found")
    }
}
