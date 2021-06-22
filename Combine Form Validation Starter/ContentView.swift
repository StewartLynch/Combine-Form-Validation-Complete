//
//  ContentView.swift
//  Combine Form Validation Starter
//
//  Created by Stewart Lynch on 2021-06-15.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = LoginViewModel()
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    EntryField(sfSymbolName: "envelope", placeholder: "Email Address", prompt: viewModel.emailPrompt, field: $viewModel.email)
                    EntryField(sfSymbolName: "lock", placeholder: "Password", prompt: viewModel.passwordPrompt, field: $viewModel.password, isSecure: true)
                    EntryField(sfSymbolName: "lock", placeholder: "Confirm", prompt: viewModel.confirmPwPrompt, field: $viewModel.confirmPw, isSecure: true)
                    VStack {
                        Button {
                            withAnimation(.easeIn) {
                                viewModel.showYearSelector = true
                            }
                        } label: {
                            Text(String(viewModel.birthYear))
                        }
                        .padding(8)
                        .foregroundColor(.primary)
                        .background(Color(.secondarySystemBackground))
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray,lineWidth: 1))
                        Text(viewModel.agePrompt).font(.caption)
                    }
                    Button {
                        viewModel.login()
                    } label: {
                        Text("Sign Up")
                    }
                    .foregroundColor(.white)
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .background(Capsule().fill(Color.blue))
                    .opacity(viewModel.canSubmit ? 1 : 0.6)
                    .disabled(!viewModel.canSubmit)
                }
                .padding()
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 20)
                Spacer()
            }
            .padding()
            YearPickerView(birthYear: $viewModel.birthYear, showYearSelector: $viewModel.showYearSelector)
                .opacity(viewModel.showYearSelector ? 1 : 0)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
