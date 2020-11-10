//
//  ContentView.swift
//  UserDataMonitor
//
//  Created by Dirk Scheidt on 01.11.20.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var us: UserStorageProvider
    @State private var logLine: String = ""
    @State private var showingAlert = false
    
    var body: some View {
        
        Text("UserStorage-Log").font(.title).padding(.top, 3)

        HStack() {
            TextField("Information", text: self.$logLine, onCommit: { self.onButton(); return })
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .overlay(
                    HStack {
                        Image(systemName: "info.circle")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                            .padding(.trailing, 20)
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(.secondary)
                            .padding(.trailing, 8)
                            .opacity(logLine == "" ? 0 : 1)
                            .onTapGesture {
                                self.logLine = ""
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                        
                    }
                )
                .padding(.horizontal, 4)
            
            Button(action: {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                self.onButton()
            }) {
                Text("Add")
                    .padding([.leading, .trailing], 15)
                    .padding([.top, .bottom], 7)
                    .background(Color.green)
                    .cornerRadius(4)
            }.padding(.trailing, 4)
        }
        List() {
            
            ForEach(self.us.getSortedKeys(), id:\.self) { key in
                VStack(alignment: .leading ,spacing: 0){
                    let t = self.us.GetDisplayStringByKey(key)
                    Text(t.0)
                        .font(.footnote)
                    Text(t.1)
                        .font(.footnote)
                        .padding(.leading, 3)
                }.padding([.bottom,.top], 2)
            }.onDelete(perform: deleteItems)
        }
        
        HStack() {

            Button(action: {self.onReloadList()}) {
                Text("Reload")
                    .padding()
                    .background(Color.green)
                    .cornerRadius(4)
            }
            Button(action: {self.showingAlert = true}) {
                Text("Delete")
                    .padding()
                    .background(Color.green)
                    .cornerRadius(4)
            }.alert(isPresented: $showingAlert) {
                Alert(title: Text("Really"), message: Text("Do you want to delete the loglist?"), primaryButton: .default(Text("Delete"), action: {
                    self.onDeleteList()
                }), secondaryButton: .default(Text("Cancel")))
            }
        }.padding(4)
        
    }
    
    func onButton() {
        let _ = self.us.AppendItem(self.logLine)
        
    }
    
    func onDeleteList() {
        self.us.DeleteList()
    }
    
    func onReloadList() {
        self.us.ReloadList()
    }
    
    func deleteItems(at offsets: IndexSet) {
        for idx in offsets {
            let keys = self.us.getSortedKeys()
            let key = keys[idx]
            self.us.removeItemByKey(key)
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UserStorageProvider.share)
    }
}
