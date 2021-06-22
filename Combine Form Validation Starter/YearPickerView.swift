//
//  YearPickerView.swift
//  Combine Form Validation Starter
//
//  Created by Stewart Lynch on 2021-06-20.
//

import SwiftUI

struct YearPickerView: View {
    @Binding var birthYear: Int
    @Binding var showYearSelector: Bool
    var body: some View {
        ZStack {
            Color(.black).opacity(0.4)
                .ignoresSafeArea()
            VStack {
                VStack {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 10) {
                            ForEach(((Constants.currentYear - 100)...Constants.currentYear).reversed(), id: \.self) { year in
                                Button {
                                    birthYear = year
                                    withAnimation(.easeIn) {
                                        showYearSelector = false
                                    }
                                } label: {
                                    Text(String(year))
                                        .foregroundColor(.primary)
                                }
                            }
                        }
                    }
                    .frame(height: 200)
                }.padding()
                .frame(width: 100)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 20)
                Spacer()
            }
        }
    }
}

struct YearPickerView_Previews: PreviewProvider {
    static var previews: some View {
        YearPickerView(birthYear: .constant(1993), showYearSelector: .constant(true))
    }
}
