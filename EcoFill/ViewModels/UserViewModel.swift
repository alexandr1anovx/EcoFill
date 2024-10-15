import Foundation
import FirebaseFirestore
import FirebaseAuth

@MainActor
final class UserViewModel: ObservableObject {
    
    @Published var alertItem: AlertItem?
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var selectedCity: City = .mykolaiv
    var isEmailVerified = false
    
    private let usersCollection = Firestore.firestore().collection("users")
    
    init() {
        self.userSession = Auth.auth().currentUser
        Task {
            await fetchUser()
        }
    }
    
    func signUp(
        withInitials initials: String,
        email: String,
        password: String,
        city: City
    ) async {
        do {
            let result = try await Auth.auth().createUser(
                withEmail: email,
                password: password
            )
            self.userSession = result.user
            try await result.user.sendEmailVerification()
            
            let user = User(
                id: result.user.uid,
                city: city.rawValue,
                email: email,
                initials: initials
            )
            let encodedUser = try Firestore.Encoder().encode(user)
            let document = usersCollection.document(user.id)
            try await document.setData(encodedUser)
            await fetchUser()
        } catch {
            alertItem = RegistrationAlertContext.userExists
        }
    }
    
    func signIn(withEmail email: String, password: String) async {
        do {
            let result = try await Auth.auth().signIn(
                withEmail: email,
                password: password
            )
            self.userSession = result.user
            await fetchUser()
        } catch {
            alertItem = RegistrationAlertContext.userDoesNotExists
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
        } catch {
            alertItem = ProfileAlertContext.unableToSignOut
        }
    }
    
    func deleteUser(with password: String) async {
        guard let user = userSession else { return }
        guard let email = user.email else { return }
        
        let credential = EmailAuthProvider.credential(
            withEmail: email,
            password: password
        )
        do {
            try await user.reauthenticate(with: credential)
            try await user.delete()
            alertItem = ProfileAlertContext.successfullAccountDeletion
            userSession = nil
        } catch {
            alertItem = ProfileAlertContext.unsuccessfullAccountDeletion
        }
    }
    
    func updateEmail(to newEmail: String, with password: String) async {
        guard let user = userSession else { return }
        guard let currentEmail = user.email else { return }
        
        let credentials = EmailAuthProvider.credential(
            withEmail: currentEmail,
            password: password
        )
        do {
            try await user.reauthenticate(with: credentials)
            try await user.sendEmailVerification(beforeUpdatingEmail: newEmail)
            alertItem = ProfileAlertContext.confirmationLinkSent
            let document = usersCollection.document(user.uid)
            try await document.updateData(["email": newEmail])
            await fetchUser()
        } catch {
            alertItem = ProfileAlertContext.unsuccessfullEmailUpdate
        }
    }
    
    func checkEmailVerificationStatus() {
        guard let user = userSession else { return }
        isEmailVerified = user.isEmailVerified
    }
    
    private func fetchUser() async {
        guard let uid = userSession?.uid else { return }
        guard let snapshot = try? await usersCollection.document(uid).getDocument() else {
            return
        }
        // decode the fetched document into a User object
        self.currentUser = try? snapshot.data(as: User.self)
    }
}
