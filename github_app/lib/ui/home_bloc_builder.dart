import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_app/cubit/home_cubit.dart';
import 'package:github_app/data/data_repository.dart';
import 'package:github_app/ui/detail/detail_user.dart';
import 'package:github_app/ui/detail/error_list.dart';
import 'package:intl/intl.dart';

class HomeBlocBuilder{

  static final homeCubit = HomeCubit(DataRepository.getRepository());

  static HomeBlocBuilder instance(){
    HomeBlocBuilder instance = HomeBlocBuilder();
    return instance;
  }

  Widget buildResult(){
    return BlocBuilder(
        cubit: homeCubit,
        builder: (BuildContext context, HomeState state){
          if(state is HomeLoadedUsers){
            return Column(
              children: List.generate(state.responseUsers.length, (index) =>
                  GestureDetector(
                    onTap: (){
                      _onWidgetDidBuild((){
                        Navigator.of(context).push(MaterialPageRoute(builder: (builder) => DetailUser(state.responseUsers[index])));
                      });
                      homeCubit.finish();
                    },
                    child: Container(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: state.responseUsers[index].avatarUrl!=null?
                          Image.network(state.responseUsers[index].avatarUrl) :
                          Container(
                            color: Colors.grey,
                          ),
                        ),
                        title: Text(state.responseUsers[index].login??"-"),
                        subtitle: Text(state.responseUsers[index].bio??""),
                      ),
                    ),
                  )
              ),
            );
          }

          if(state is HomeLoadedRepositories){
            return Column(
              children: List.generate(state.responseRepositories.length, (index) =>
                  GestureDetector(
                    onTap: (){

                    },
                    child: Container(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: state.responseRepositories[index].owner.avatarUrl!=null?
                          Image.network(state.responseRepositories[index].owner.avatarUrl) :
                          Container(
                            color: Colors.grey,
                          ),
                        ),
                        title: Text(state.responseRepositories[index].name??"-"),
                        subtitle: Text(state.responseRepositories[index].createdAt!=null?DateFormat('dd MMM yyyy - HH:mm', "id_ID").format(state.responseRepositories[index].createdAt) :"-"),
                        trailing: Column(
                          children: [
                            Text.rich(
                              TextSpan(
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                                children: [
                                  WidgetSpan(
                                    child: Icon(Icons.remove_red_eye),
                                  ),
                                  TextSpan(
                                    text: state.responseRepositories[index].watchersCount!=null?state.responseRepositories[index].watchersCount.toString():"0",
                                  )
                                ],
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                                children: [
                                  WidgetSpan(
                                    child: Icon(Icons.star),
                                  ),
                                  TextSpan(
                                    text: state.responseRepositories[index].stargazersCount!=null?state.responseRepositories[index].stargazersCount.toString():"0",
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
              ),
            );
          }

          if(state is HomeLoadedIssues){
            return Column(
              children: List.generate(state.responseIssue.length, (index) =>
                  GestureDetector(
                    onTap: (){
                      debugPrint(jsonEncode(state.responseIssue[index]));
                    },
                    child: Container(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: state.responseIssue[index].user.avatarUrl!=null?
                          Image.network(state.responseIssue[index].user.avatarUrl) :
                          Container(
                            color: Colors.grey,
                          ),
                        ),
                        title: Text(state.responseIssue[index].title??"-"),
                        subtitle: Text(state.responseIssue[index].updatedAt!=null?DateFormat('dd MMM yyyy - HH:mm', "id_ID").format(state.responseIssue[index].updatedAt) :"-"),
                        trailing: state.responseIssue[index].state!=null?
                        Text(state.responseIssue[index].state.toUpperCase(), style: TextStyle(color: state.responseIssue[index].state=="open"? Colors.red : Colors.green, fontWeight: FontWeight.bold),) :
                        Text("")
                      ),
                    ),
                  )
              ),
            );
          }
          if(state is HomeLoadedUsersIndex){
            return Column(
              children: List.generate(state.responseUsers.length, (index) =>
                  GestureDetector(
                    onTap: (){
                      _onWidgetDidBuild((){
                        Navigator.of(context).push(MaterialPageRoute(builder: (builder) => DetailUser(state.responseUsers[index])));
                      });
                      homeCubit.finish();
                    },
                    child: Container(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: state.responseUsers[index].avatarUrl!=null?
                          Image.network(state.responseUsers[index].avatarUrl) :
                          Container(
                            color: Colors.grey,
                          ),
                        ),
                        title: Text(state.responseUsers[index].login??"-"),
                        subtitle: Text(state.responseUsers[index].bio??""),
                      ),
                    ),
                  )
              ),
            );
          }

          if(state is HomeLoadedRepositoriesIndex){
            return Column(
              children: List.generate(state.responseRepositories.length, (index) =>
                  GestureDetector(
                    onTap: (){

                    },
                    child: Container(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: state.responseRepositories[index].owner.avatarUrl!=null?
                          Image.network(state.responseRepositories[index].owner.avatarUrl) :
                          Container(
                            color: Colors.grey,
                          ),
                        ),
                        title: Text(state.responseRepositories[index].name??"-"),
                        subtitle: Text(state.responseRepositories[index].createdAt!=null?DateFormat('dd MMM yyyy - HH:mm', "id_ID").format(state.responseRepositories[index].createdAt) :"-"),
                        trailing: Column(
                          children: [
                            Text.rich(
                              TextSpan(
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                                children: [
                                  WidgetSpan(
                                    child: Icon(Icons.remove_red_eye),
                                  ),
                                  TextSpan(
                                    text: state.responseRepositories[index].watchersCount!=null?state.responseRepositories[index].watchersCount.toString():"0",
                                  )
                                ],
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                                children: [
                                  WidgetSpan(
                                    child: Icon(Icons.star),
                                  ),
                                  TextSpan(
                                    text: state.responseRepositories[index].stargazersCount!=null?state.responseRepositories[index].stargazersCount.toString():"0",
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
              ),
            );
          }

          if(state is HomeLoadedIssuesIndex){
            return Column(
              children: List.generate(state.responseIssue.length, (index) =>
                  GestureDetector(
                    onTap: (){
                      debugPrint(jsonEncode(state.responseIssue[index]));
                    },
                    child: Container(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: state.responseIssue[index].user.avatarUrl!=null?
                          Image.network(state.responseIssue[index].user.avatarUrl) :
                          Container(
                            color: Colors.grey,
                          ),
                        ),
                        title: Text(state.responseIssue[index].title??"-"),
                        subtitle: Text(state.responseIssue[index].updatedAt!=null?DateFormat('dd MMM yyyy - HH:mm', "id_ID").format(state.responseIssue[index].updatedAt) :"-"),
                        trailing: state.responseIssue[index].state!=null?
                        Text(state.responseIssue[index].state.toUpperCase(), style: TextStyle(color: state.responseIssue[index].state=="open"? Colors.red : Colors.green, fontWeight: FontWeight.bold),) :
                        Text("")
                      ),
                    ),
                  )
              ),
            );
          }

          if(state is HomeLoading){

            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                  child: CircularProgressIndicator(),
              ),
            );

          }

          if(state is HomeError){

            return Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 100),
                  child: Image.asset("images/ilustrasi-error.png"),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Text("Terjadi Kesalahan, silahkan coba beberapa saat lagi"),
                )
              ],
            );

          }

          if(state is HomeEmptyData){

            return Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 100),
                  child: Image.asset("images/empty-state.png"),
                )
              ],
            );

          }

          return Container();
        }
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

}