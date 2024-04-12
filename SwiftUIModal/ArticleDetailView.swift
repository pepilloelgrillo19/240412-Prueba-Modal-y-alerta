//
//  ArticleDetailView.swift
//  SwiftUIModal
//
//  Created by Simon Ng on 19/8/2020.
//

import SwiftUI

struct ArticleDetailView: View {
    
    //Variable necesaria para añadir un botón de cierre
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showAlert = false
    
    //Variables para animar el corazón
    @State var size: CGFloat = 0.3
    var repeatingAnimation: Animation {
            Animation
                .easeInOut(duration: 2) //.easeIn, .easyOut, .linear, etc...
                .repeatForever()
        }
    
    var article: Article
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(article.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Group {
                    Text(article.title)
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.black)
                        .lineLimit(3)
                        
                    Text("By \(article.author)".uppercased())
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.bottom, 0)
                .padding(.horizontal)
                Text(article.content)
                    .font(.body)
                    .padding()
                    .lineLimit(1000)
                    .multilineTextAlignment(.leading)
            }
        }
        //Para mostrar el botón de cierre, y darle la acción
        .overlay(
            HStack {
                Spacer()
                VStack {
                    Button(action: {
                        //Cambiamos la acción de cierre por el cambio de la variable
                        //para que la cierre con la alerta
                        self.showAlert = true
                        //Es la acción de cierre del modal
                        //Ahora que hay alerta, ella es la que gestionará el cambio
                        //self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "heart.fill")
                            .font(.largeTitle)
                            .foregroundColor(.red)
                            .scaleEffect(size)
                            .onAppear() {
                                withAnimation(self.repeatingAnimation) { self.size = 1.4 }
                            }
                        /*Image(systemName: "chevron.down.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)*/
                    }
                    )
                    .padding(.trailing, 20)
                    .padding(.top, 40)
                    Spacer()
                }
            }
        ).alert(isPresented: $showAlert) {
            Alert(title: Text("Reminder"), message: Text("Are you sure you are finished reading the article?"), primaryButton: .default(Text("Yes"), action: { self.presentationMode.wrappedValue.dismiss() }), secondaryButton: .cancel(Text("No")))
        }
        .edgesIgnoringSafeArea(.top)
            }
    }


struct ArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetailView(article: articles[0])
    }
}
