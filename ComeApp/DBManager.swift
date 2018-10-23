//
//  DBManager.swift
//  ComeApp
//
//  Created by kobi on 30/08/2017.
//  Copyright © 2017 Kobi Kanetti. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class DBManager: NSObject {

    static let manager = DBManager()
    
    let dbRef : DatabaseReference
    let storageRef : StorageReference

    override init() {
        dbRef = Database.database().reference()
        storageRef = Storage.storage().reference()
        super.init()
    }
    
    var didRegister : Bool{
        get{
            return Auth.auth().currentUser != nil
        }
    }
    
    var userName : String?{
        get{
            return Auth.auth().currentUser?.displayName
        }
    }
    
    var userId : String?{
        get{
            return Auth.auth().currentUser?.uid
        }
    }
    
    func signUp(with name : String, callBack : @escaping (Error?) -> Void){
        Auth.auth().signInAnonymously { (user, error) in
            
            if error != nil{
                callBack(error)
                return
            }
            let request = user?.createProfileChangeRequest()
            request?.displayName = name
            request?.commitChanges(completion: { (err) in
                
                callBack(nil)
            })
        }
    }
    
    func createItem(condition : String, description : String, address : String, image : UIImage){
        
        guard let uid = Auth.auth().currentUser?.uid else{
            return
        }
        
        let dict : [String:Any] = [
            "uid":uid,
            "address":address,
            "condition":condition,
            "description":description,
            "date": Date().timeIntervalSince1970
        ]
        
        let newItemDBRef = dbRef.child("items").childByAutoId()
        newItemDBRef.setValue(dict)
        
        let imageName = UUID().uuidString
        let imageStorageRef = storageRef.child(newItemDBRef.key).child(imageName + ".jpg")
        
        let data = UIImageJPEGRepresentation(image, 0.7)!
        
        imageStorageRef.putData(data, metadata: nil) { (meta, error) in
            guard let url = meta?.downloadURL() else{
                //download failed, do something
                return
            }
            
            newItemDBRef.child("image_url").setValue(url.absoluteString)
        }
        
    }
    
    typealias ItemsCallback = ([Item]) -> Void
    
    func observeAllItems(_ callback : @escaping ItemsCallback){
        
        let ref = dbRef.child("items")
        ref.removeAllObservers()
        
        ref.queryLimited(toLast: 50).observe(.value, with: { (snapshot) in
            guard let val = snapshot.value as? [String:[String:Any]] else{
                return
            }
            
            let arr = val.flatMap({
                Item(key: $0.key, value: $0.value)
            })
            
            callback(arr)
        })
        
        
    }
    
}








