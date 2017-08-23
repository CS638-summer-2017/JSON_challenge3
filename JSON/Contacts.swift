//
//  Contacts.swift
//  FirstJSON
//
//  Created by Eric J Knapp on 8/7/17.
//  Copyright © 2017 Eric J Knapp. All rights reserved.
//

import Foundation

struct Contact: Codable, CustomStringConvertible {
    var firstName: String
    var lastName: String
    var email: String
    var cell: String
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    var description: String {
        return "\(firstName) \(lastName)"
    }
    
    var formattedJSON: String {
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        guard let json = try? encoder.encode(self) else {
            print("Can't create JSON for contact")
            return ""
        }
        
        return String(data: json, encoding: .utf8) ?? ""
    }
}

class Contacts {
    var contacts: [Contact]
    
    init() {
        contacts = []
        loadContacts()
        save()
        
        print(contacts)
    }
    
    func contact(at indexPath: IndexPath) -> Contact {
        if indexPath.row >= contacts.count {
            return contacts[0]
        }
        
        return contacts[indexPath.row]
    }
    
    var count: Int {
        return contacts.count
    }
    
    func loadContacts() {
        
        if isFirstLaunch() {
            print("First launch, loading bundled JSON.")
            contacts = loadBundledJSON()
            save()
            //return loadBundledJSON()
        } else {
            print("Loading contacts from app directory.")
            contacts = loadSavedContacts()
//            return loadSavedContacts()
            //return loadBundledJSON()
        }
    }
    
    func loadBundledJSON() -> [Contact] {
        let url = Bundle.main.url(forResource: "small-contacts", withExtension: "json")
        
        guard let jsonData = try? Data(contentsOf: url!) else {
            return []
        }
        
        let jsonDecoder = JSONDecoder()
        let contactsArray = try? jsonDecoder.decode([Contact].self, from: jsonData)
        
        return contactsArray ?? []
    }
    
    func loadSavedContacts() -> [Contact] {
        print("In loadSavedContacts")
        
        guard let contactsURL = applicationDirectory().appendingPathComponent("contacts.plist") else {
            print("Can't create URl to app dir.")
            return []
        }
        
        guard let contactsData = try? Data.init(contentsOf: contactsURL) else {
            print("Couldn't load data from app dir.")
            return []
        }
        
        let contactsDecoder = PropertyListDecoder()
        let contactsArray = try? contactsDecoder.decode([Contact].self, from: contactsData)

        return contactsArray ?? []
    }
    
    func save() {
        print("In save()")
        guard let saveURL = applicationDirectory().appendingPathComponent("contacts.plist") else {
            print("Could not get the URL for the data save.")
            return
        }
        
        print(saveURL)
        
        let plistEncoder = PropertyListEncoder()
        
        let contactsData = try? plistEncoder.encode(contacts.self)
        
        print(contactsData ?? "No data")
        
        do {
            try contactsData?.write(to: saveURL)
        } catch {
            print(error)
        }
    }
    
    
    
    
    
    
}
