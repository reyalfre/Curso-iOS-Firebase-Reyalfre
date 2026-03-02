//
//  VistaLogin.swift
//  Curso iOS Firebase Reyalfre
//
//  Created by Equipo 8 on 2/3/26.
//

import SwiftUI

struct VistaLogin: View {
    @Bindable var authManager: AuthManager

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var seEstaRegistrando = false
    @State private var logeando = false
    @State private var mensajeError: String?
    var body: some View {
        VStack(spacing: 20) {
            Text(seEstaRegistrando ? "Crear cuenta" : "Bienvenido/a")
                .font(.largeTitle)
                .bold()
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
            SecureField("Contraseña", text: $password)
                .textFieldStyle(.roundedBorder)
            if let mensajeError {
                Text(mensajeError)
                    .foregroundStyle(.red)
                    .font(.caption)
            }
            Button {
                logeando = true
                Task {
                    await autenticar()
                }
            } label: {
                Text(seEstaRegistrando ? "Registrarse" : "Iniciar sesión")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(email.isEmpty || password.isEmpty || logeando)
            .opacity(email.isEmpty || password.isEmpty || logeando ? 0.5 : 1.0)

            Button {
                seEstaRegistrando.toggle()
                mensajeError = nil
            } label: {
                Text(
                    seEstaRegistrando
                        ? "¿Ya tienes cuenta?"
                        : "¿No tienes cuenta? ¡Regístrate!"
                )
                .foregroundStyle(Color.blue)
            }
        }
        .padding()
    }
    func autenticar() async {
        do {
            if seEstaRegistrando {
                try await authManager.register(email: email, pass: password)
            } else {
                try await authManager.login(email: email, pass: password)
            }
            logeando = false
        } catch {
            mensajeError = error.localizedDescription
            logeando = false
        }

    }
}
/*
#Preview {
    VistaLogin()
}
*/
