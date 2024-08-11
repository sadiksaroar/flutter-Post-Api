import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restpisadik/model/models.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<PostModel> postList = [];

  Future<List<PostModel>> getPostApi() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      postList.clear();
      for (var i in data) {
        postList.add(PostModel.fromJson(i as Map<String, dynamic>));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hey Api'),
      ),
      body: Column(
        children: [
          // Your UI elements go here
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
              builder: (context, snapshot){
                if(!snapshot.hasData){
                  return Text("loading");
                }else {
                  return ListView.builder(
                    itemCount: postList.length,
                    itemBuilder: (context, index){
                      //  Text(postList[index].title.toString())
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text('Title:', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                               Text(postList[index].title.toString()),

                               SizedBox(height: 20,),

                               Text('Description:', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                               Text(postList[index].title.toString()),
                            
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
