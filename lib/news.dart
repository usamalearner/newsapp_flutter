import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class News extends StatefulWidget {
  // const News({ Key? key }) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  getNews() async {
    var news = [];
    dynamic response =
        
        await http.get(
            "http://api.mediastack.com/v1/news?access_key=092ecb6c768e9b74f907545f627a7b2b&countries=pk");
    dynamic jsonData = jsonDecode(response.body);

    dynamic result = jsonData["data"];
    // print(result);
    // for (var i in jsonData) {
    //   NewsModel khabar = NewsModel(
    //       i["data"]['author'], i["data"]['title'], i["data"]['category']);

    //   news.add(khabar);
    // }
 
    print(news);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
         appBar: AppBar(
            backgroundColor: Colors.red[700],
            title: Center(child: Text("HEADLINE NEWS")),
          ),
          drawer: Drawer(
            
          child: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://images.pexels.com/photos/5797908/pexels-photo-5797908.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
                  fit: BoxFit.fitHeight)),
            child: ListView(
              
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.cyan,
                    image: DecorationImage(
                    image: NetworkImage(
                        "https://images.pexels.com/photos/5357363/pexels-photo-5357363.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
                    fit: BoxFit.fitWidth)
                  ),
                  
                  child: Text(""),
                ),
                GestureDetector(
                  onTap: () {}, child : ListTile(
                    tileColor: Colors.pink[100],
                    title: Text("Name"),subtitle: Text("Usama"),),
                ),
                ListTile(
                  tileColor: Colors.pink[200],
                  title: Text('Email'),subtitle: Text("Usama@gmail.com"),
                ),
                ListTile(
                  tileColor: Colors.pinkAccent,
                  title: Text('Phone'),subtitle: Text("03122063585"),
                )
              ],
            ),
          ),
        ),
        body: DecoratedBox(
           decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://images.pexels.com/photos/3825880/pexels-photo-3825880.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"),
                  fit: BoxFit.cover)),
          child: Container(
            child: FutureBuilder(
              future: getNews(),
              builder: (context, AsyncSnapshot snapshot) {
                print(snapshot.data);
                if (snapshot.data == null) {
                  return Container(
                    child: Center(child: Text("loading News",style: TextStyle( fontSize: 36,color: Colors.red,fontWeight: FontWeight.bold,),),),
                  );
                } else if (snapshot.data != null) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      if ((snapshot.data[i]["author"] != null) & (snapshot.data[i]["source"] != null) & (snapshot.data[i]["title"] != null) &  (snapshot.data[i]["published_at"] != null)  & (snapshot.data[i]["description"]!= null)) {
                        return Container(
                          margin: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                             
                             Text("Title : "+snapshot.data[i]["title"],style: TextStyle( fontSize: 16,color: Colors.red,fontWeight: FontWeight.bold,decoration: TextDecoration.underline),),
                             Text("Author : "+snapshot.data[i]["author"],style: TextStyle( fontSize: 18,color: Colors.blue,fontWeight: FontWeight.bold,),),
                             Text("Source : "+snapshot.data[i]["source"],style: TextStyle( fontSize: 18,color: Colors.orange,fontWeight: FontWeight.bold,decoration: TextDecoration.underline),),
                              Text("Published At : "+snapshot.data[i]["published_at"],style: TextStyle( fontSize: 16,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                               Container(
                                 color: Colors.cyan,
                                 margin: const EdgeInsets.all(10.0),
                                 child: Text("Description : "+snapshot.data[i]["description"],style: TextStyle(color:Colors.black,),)),
                                SizedBox(
                                 height: 5,
                               ),
                                Text("==========================",style: TextStyle(color: Colors.amber),),
                               SizedBox(
                                 height: 10,
                               )
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                  // return Container(
                  //   child: Text("has data"),
                  // );
                } else {
                  return Container(
                    child: Text("Loading..."),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class NewsModel {
  String author;
  String title;
  String category;

  NewsModel(this.author, this.title, this.category);
}
