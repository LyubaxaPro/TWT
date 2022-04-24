import Foundation
import Firebase

protocol DetailManagerDescription: AnyObject {
    func isInFavorites(id: Int?, complition: @escaping (Bool) -> Void)
}

/// Класс, отвечающий за доступ к данным Firebase для экрана детализированной информации о событии
final class DetailManager: DetailManagerDescription {
    
    static let shared: DetailManagerDescription = DetailManager()
    
    private init() {}
    
    /// Предоставляет данные о том, есть ли событие в избранном
    func isInFavorites(id: Int?, complition: @escaping (Bool) -> Void) {
        Auth.auth().addStateDidChangeListener { (auth, user)  in
            guard let user = user else {
                complition(false)
                return
            }

            let ref = Database.database(url: "https://eventtracker-3500c-default-rtdb.firebaseio.com/").reference()

            let groupsRef = ref.child("users/"+user.uid + "/favorites/" + "\(String(describing: id))")

            groupsRef.observeSingleEvent(of: .value){
                (snapshot) in
                let name = snapshot.value as? [String: Any]
                if (name != nil) {
                    complition(true)
                    return
                } else {
                    complition(false)
                    return
                }
            }
        }
    }

}
