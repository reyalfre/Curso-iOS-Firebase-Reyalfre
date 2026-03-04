//
//  ContentView.swift
//  Curso iOS Firebase Reyalfre
//
//  Created by Equipo 8 on 2/3/26.
//

import FirebaseAuth
import SwiftUI

struct ContentView: View {
    @State private var manager = AuthManager()
    var body: some View {
        Group {
            if manager.user != nil {
                //  VistaPrincipal(authManager: manager)
                //   VistaGastos(idUsuario: user.uid)
                VistaGastos(authManager: manager)
            } else {
                VistaLogin(authManager: manager)
            }
        }
    }
}

#Preview {
    ContentView()
}
