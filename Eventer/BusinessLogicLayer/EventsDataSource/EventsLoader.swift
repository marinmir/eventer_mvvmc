//
//  EventsLoader.swift
//  Eventer
//
//  Created by Мирошниченко Марина on 30.06.2020.
//  Copyright © 2020 Мирошниченко Марина. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol EventsLoader {
    func loadEvents(completion: @escaping ([EventType: [Event]]) -> Void)
    func loadSearchResults(searchText: String, completion: @escaping ([Event]) -> Void)
}

struct EventsResponse: Codable {
    var popular: [Event]?
    var promoted: [Event]?
    var thisWeek: [Event]?
}

class FirebaseEventsLoader: EventsLoader {

    let db = Firestore.firestore()

    func loadEvents(completion: @escaping ([EventType: [Event]]) -> Void) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }

            let docRef = self.db.collection("events").document("7pRYqY09k5LJlRdBAdcJ")

            docRef.getDocument { (document, error) in

                let result = Result {
                    try document?.data(as: EventsResponse.self)
                }
                switch result {
                case .success(let response):
                    var events = [EventType: [Event]]()

                    if let popular = response?.popular {
                        events[.popular] = popular
                    }

                    if let promoted = response?.promoted {
                        events[.promoted] = promoted
                    }

                    if let thisWeek = response?.thisWeek {
                        events[.thisWeek] = thisWeek
                    }

                    completion(events)

                case .failure(let error):
                    print("Error decoding city: \(error)")
                }
            }

        }
    }

    func loadSearchResults(searchText: String, completion: @escaping ([Event]) -> Void) {
//        DispatchQueue.global(qos: .background).async { [weak self] in
//            guard let self = self else { return }
//            
//            let lowercasedQuery = searchText.lowercased()
//            
//            self.db.collection("events")
//                .whereField("title".lowercased(), isGreaterThanOrEqualTo: lowercasedQuery)
//                .getDocuments() { (querySnapshot, err) in
//                    if let err = err {
//                        print("Error getting documents: \(err)")
//                    } else {
//                        for document in querySnapshot!.documents {
//                            print("\(document.documentID) => \(document.data())")
//                        }
//                    }
//            }
//            
//        }
    }
}

// class EventsLoaderMock: EventsLoader {
//    func loadSearchResults(searchText: String, completion: @escaping ([Event]) -> Void) {
//        DispatchQueue.global(qos: .background).async {
//            let visitors = Visitors(images: [UIImage(named: "EventDefault") ?? UIImage(),
//                                             UIImage(named: "EventDefault") ?? UIImage()],
//                                    count: 101)
//            let titleImage = UIImage(named: "EventDefault")
//
//            let resultArray = [Event(id: 1,
//                                     title: "GO Home",
//                                     place: "Home",
//                                     dateTime: Calendar.current.date(byAdding: .month, value: 9, to: Date())!,
//                                     cost: 30,
//                                     description: "go and have a relax",
//                                     titleImage: titleImage,
//                                     visitors: visitors),
//                               Event(id: 2,
//                                     title: "Work",
//                                     place: "In office",
//                                     dateTime: Date(),
//                                     cost: 50,
//                                     description: "work hard",
//                                     titleImage: titleImage,
//                                     visitors: visitors),
//                               Event(id: 3,
//                                     title: "Rest",
//                                     place: "Home",
//                                     dateTime: Date(),
//                                     cost: 60,
//                                     description: "have a relax at home",
//                                     titleImage: titleImage,
//                                     visitors: visitors),
//                               Event(id: 4,
//                                     title: "Hard Work",
//                                     place: "Home",
//                                     dateTime: Date(),
//                                     cost: 60,
//                                     description: "working at home",
//                                     titleImage: titleImage,
//                                     visitors: visitors)]
//
//            let lowercasedQuery = searchText.lowercased()
//            let results = resultArray.filter { $0.title.lowercased().contains(lowercasedQuery) }
//            completion(results)
//        }
//    }
//
//    func loadEvents(completion: @escaping ([EventType:[Event]]) -> Void) {
//        DispatchQueue.global(qos: .background).async {
//            let visitors = Visitors(images: [UIImage(named: "EventDefault") ?? UIImage(),
//                                             UIImage(named: "EventDefault") ?? UIImage()],
//                                    count: 101)
//            let titleImage = UIImage(named: "EventDefault")
//
//            let events1 = [Event(id: 1,
//                                 title: "GO Home",
//                                 place: "Home",
//                                 dateTime: Calendar.current.date(byAdding: .month, value: 9, to: Date())!,
//                                 cost: 30,
//                                 description: "something is written here",
//                                 titleImage: titleImage,
//                                 visitors: visitors)]
//            let events2 = [Event(id: 2,
//                                 title: "Work",
//                                 place: "In office",
//                                 dateTime: Date(),
//                                 cost: 50,
//                                 description: "work hard",
//                                 titleImage: titleImage,
//                                 visitors: visitors),
//                           Event(id: 3,
//                                 title: "Rest",
//                                 place: "Home",
//                                 dateTime: Date(),
//                                 cost: 60,
//                                 description: "have a relax at home",
//                                 titleImage: titleImage,
//                                 visitors: visitors)]
//
//            completion([.promoted : events1, .thisWeek : events2])
//        }
//    }
//
// }
