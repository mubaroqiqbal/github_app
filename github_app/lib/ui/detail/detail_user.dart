import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailUser extends StatefulWidget{

  User userData;

  DetailUser(this.userData);

  @override
  _DetailUser createState() => _DetailUser(userData);

}

class _DetailUser extends State<DetailUser>{

  final User userData;

  _DetailUser(this.userData);

  @override
  void initState() {
    super.initState();
    debugPrint(jsonEncode(userData));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(
        centerTitle: false,
        elevation: 0.0,
        titleSpacing: 0.0,
        backgroundColor: Color.fromRGBO(41, 171, 226 , 1),
        title: Text(userData.login??""),
        iconTheme: new IconThemeData(color: Colors.white),
        leading: IconButton(icon:Icon(Icons.arrow_back_ios),
          onPressed:() => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 75,
                            width: 75,
                            child: CircleAvatar(
                              child: userData.avatarUrl!=null?
                              Image.network(userData.avatarUrl) :
                              Container(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(userData.publicReposCount!=null?userData.publicReposCount.toString():"0", style: TextStyle(fontWeight: FontWeight.bold),),
                                Text("Repo"),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(userData.publicReposCount!=null?userData.publicReposCount.toString():"0", style: TextStyle(fontWeight: FontWeight.bold),),
                                Text("Following"),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(userData.publicReposCount!=null?userData.publicReposCount.toString():"0", style: TextStyle(fontWeight: FontWeight.bold),),
                                Text("Followers"),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      userData.bio!=null?
                      Row(
                        children: [
                          Text(userData.bio)
                        ],
                      ) : Container(),
                      GestureDetector(
                        onTap: () async {
                          if (await canLaunch(userData.htmlUrl)) {
                            await launch(userData.htmlUrl);
                          } else {
                            throw 'Could not launch $userData.htmlUrl';
                          }
                        },
                        child: Text("VISIT", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent),),
                      )
                    ],
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}