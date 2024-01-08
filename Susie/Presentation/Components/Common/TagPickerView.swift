//
//  TagPickerView.swift
//  Susie
//
//  Created by Patryk Maciąg on 19/10/2023.
//

import SwiftUI

struct TagPickerView<Enum: Tag>: View where Enum: Hashable, Enum.AllCases: RandomAccessCollection, Enum.RawValue == Int32 {
    @Binding var `enum`: Enum
    let onSelect: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(Enum.allCases, id: \.rawValue) { `case` in
                Button(action: {
                    `enum` = `case`
                    onSelect()
                }, label: {
                    HStack {
                        VStack(alignment: .leading) {
                            TagView(text: `case`.description, color: `case`.color, enlarged: true)
                            Text(verbatim: `case`.description)
                                .font(.caption)
                        }
                        Spacer()
                    }
                })
                .padding(.bottom, 1)
                Divider()
            }
        }
        .padding()
    }
    
    init(`enum`: Binding<Enum>, onSelect: @escaping () -> Void) {
        self.onSelect = onSelect
        `_enum` = `enum`
    }
}
