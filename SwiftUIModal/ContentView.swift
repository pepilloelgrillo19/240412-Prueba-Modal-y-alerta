//
//  ContentView.swift
//  SwiftUIModal
//
//  Created by Simon Ng on 19/8/2020.
//

import SwiftUI

struct ContentView: View {
    
    //Para que se muestre (true) o no (false) la vista
    //Solo se necesita si tenemos el desempaquetado de nulos
    //@State var showDetailView = false
    
    //Para saber que artículo ha seleccionado el usuario
    @State var selectedArticle: Article?
    
    var body: some View {
        NavigationView {
            List(articles) { article in
                ArticleRow(article: article)
                //Activa la variable para mostrar el modal, 
                    .onTapGesture {
                        //Ya no es necesario, por la forma alternativa de sheet
                        //self.showDetailView = true
                        self.selectedArticle = article
                           }
            }
            //Forma más ligera de código, que permite la misma función
            //que el código inferior, y sin desempaquetado de nulos
            //Básicamente abre el modal cuando se selecciona algo
            .sheet(item: self.$selectedArticle) { article in
                ArticleDetailView(article: article)
            //El siguiente código cambia de comportamiento Modal a pantalla completa
            //desactivando los gestos
            /*
            .fullScreenCover(item: self.$selectedArticle) { article in ArticleDetailView(article: article)
             */
            
            
            }
            
            /*
             Se puede alternar este código, o mejor el superiro
             
            //Es el método para que se muestre el modal
            .sheet(isPresented: self.$showDetailView) {
                //Actua como un desempaquetado de nulos, para ver si contiene algo
                if let selectedArticle = self.selectedArticle {
                    //Esto selecciona el artículo, y abre el modal
                    ArticleDetailView(article: selectedArticle)
                }
            }
            */

            .navigationBarTitle("Your Reading")
        }
        //Para que no se vea en forma de dos columnas por aplicar el método .sheet
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ArticleRow: View {
    var article: Article
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(article.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(5)
            
            Text(article.title)
                .font(.system(.title, design: .rounded))
                .fontWeight(.black)
                .lineLimit(3)
                .padding(.bottom, 0)
            
            Text("By \(article.author)".uppercased())
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.bottom, 0)
                
            HStack(spacing: 3) {
                ForEach(1...(article.rating), id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundColor(.yellow)
                }
                
                
            }
            
            Text(article.excerpt)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
        }
    }
}
