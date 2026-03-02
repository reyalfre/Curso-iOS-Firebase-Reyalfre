//
//  VistaPrincipal.swift
//  Curso iOS Firebase Reyalfre
//
//  Created by Equipo 8 on 2/3/26.
//

import FirebaseAuth
import SwiftUI

struct VistaPrincipal: View {
    var authManager: AuthManager
    var body: some View {
        Text("Estás dentro!. ID: \(authManager.user?.uid ?? "No hay usuario")")

        Button("Cerrar sesión") {
            authManager.logout()
        }
        .buttonStyle(.borderedProminent)
        .tint(.red)
    }
}
