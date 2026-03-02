//
//  AuthManager.swift
//  Curso iOS Firebase Reyalfre
//
//  Created by Equipo 8 on 2/3/26.
//

import FirebaseAuth
import Foundation

@Observable
class AuthManager {
    var user: User?

    init() {
        //Asigna el usuario si ya hay sesion guardada
        user = Auth.auth().currentUser
    }

    //Función para registrar un usuario nuevo
    func register(email: String, pass: String) async throws {
        let result = try await Auth.auth().createUser(
            withEmail: email,
            password: pass
        )
        print("Usurio creado")
        user = result.user
    }
    func login(email: String, pass: String) async throws {
        let result = try await Auth.auth().signIn(
            withEmail: email,
            password: pass
        )
        print("Usurio logeado")
        user = result.user
    }
    func logout(){
        try? Auth.auth().signOut()
        user = nil
    }
}
