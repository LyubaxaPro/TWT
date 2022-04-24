import Foundation
import Firebase

final class DetailInteractor {
	weak var output: DetailInteractorOutput?
}

/// Класс, отвечающий за бизнес-логику экрана детализированной информации о событии
extension DetailInteractor: DetailInteractorInput {
    /// Добавляет событие в избранное
    func addToFavorites(dict: [String : Any]) {
        Auth.auth().addStateDidChangeListener { (auth, user)  in
            guard let user = user else {
                self.output?.didReceive(message: "Неизвестная ошибка!")
                return
            }
            
            let ref = Database.database(url: "https://eventtracker-3500c-default-rtdb.firebaseio.com/").reference()
            let groupsRef = ref.child("users/"+user.uid + "/favorites/")
            groupsRef.child("\(String(describing: dict["id"]))").setValue(dict)
        }
    }
    
    /// Удаляет событие из избранного
    func removeFromFavorites(id: Int?) {
        Auth.auth().addStateDidChangeListener { (auth, user)  in
            guard let user = user else {
                self.output?.didReceive(message: "Неизвестная ошибка!")
                return
            }
            
            let ref = Database.database(url: "https://eventtracker-3500c-default-rtdb.firebaseio.com/").reference()

            let groupsRef = ref.child("users/"+user.uid + "/favorites/")
            groupsRef.child("\(String(describing: id))").removeValue()
        }
    }
}
