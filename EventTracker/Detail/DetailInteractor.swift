import Foundation
import Firebase

final class DetailInteractor {
	weak var output: DetailInteractorOutput?
}

extension DetailInteractor: DetailInteractorInput {    
    func addToFavorites(dict: [String : Any]) {
        Auth.auth().addStateDidChangeListener { (auth, user)  in
            guard let user = user else {
                self.output?.didReceive(message: "Неизвестная ошибка!")
                return
            }
            
            let ref = Database.database(url: "https://leisure-d8615-default-rtdb.firebaseio.com/").reference()
            let groupsRef = ref.child("users/"+user.uid + "/favorites/")
            groupsRef.child("\(String(describing: dict["id"]))").setValue(dict)
        }
    }
    
    func removeFromFavorites(id: Int?) {
        Auth.auth().addStateDidChangeListener { (auth, user)  in
            guard let user = user else {
                self.output?.didReceive(message: "Неизвестная ошибка!")
                return
            }
            
            let ref = Database.database(url: "https://leisure-d8615-default-rtdb.firebaseio.com/").reference()

            let groupsRef = ref.child("users/"+user.uid + "/favorites/")
            groupsRef.child("\(String(describing: id))").removeValue()
        }
    }
}
