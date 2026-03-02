//
//  ContentView.swift
//  Curso iOS Firebase Reyalfre
//
//  Created by Equipo 8 on 2/3/26.
//

import SwiftUI
import FirebaseAuth
struct ContentView: View {
    @State private var manager = AuthManager()
    var body: some View {
        Group {
            if let user = manager.user {
              //  VistaPrincipal(authManager: manager)
                VistaGastos(idUsuario: user.uid)
            } else {
                VistaLogin(authManager: manager)
            }
        }
    }
}

#Preview {
    ContentView()
}
