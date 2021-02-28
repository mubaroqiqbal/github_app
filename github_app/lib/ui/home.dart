import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:github_app/cubit/home_cubit.dart';
import 'package:github_app/data/model/enum/search_enum.dart';
import 'package:github_app/ui/home_bloc_builder.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<Home> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final StreamController<bool> streamController = StreamController<bool>.broadcast();

  ScrollController _nestedScrollViewController;
  ScrollController _scrollViewController;

  bool isScrolled = false;
  bool paginationType = true;
  String searchType="USERS";
  int page=1;

  int firstPagination=1;
  int secondPagination=2;
  int thirdPagination=3;
  int currentPagination=1;

  KeyboardVisibilityController _keyController = KeyboardVisibilityController();

  Timer _debounce;
  String query = "";
  String currentQuery = "";
  int _debouncetime = 750;

  final _controllerQuery = TextEditingController();

  @override
  void initState() {
    super.initState();
    page=1;
    _controllerQuery.addListener(_onSearchChanged);

    _keyController.onChange.listen((event) {
      if(FocusScope.of(context).hasFocus && !_keyController.isVisible){
        FocusScope.of(context).unfocus();
      }
    });

    _nestedScrollViewController = ScrollController();
    _nestedScrollViewController.addListener(_nestedScrollListener);

    _scrollViewController = ScrollController();
    _scrollViewController.addListener(_scrollListener);

  }

  _nestedScrollListener() {
      try{
        if (_nestedScrollViewController.offset > _nestedScrollViewController.position.minScrollExtent+1) {
          isScrolled=true;
          setState(() {});
        }else{
          isScrolled=false;
          setState(() {});
        }
      } on Exception catch(e){
        throw("error");
      }
  }

  _scrollListener() {
    try{
      if (_scrollViewController.offset >= _scrollViewController.position.maxScrollExtent&&
          !_scrollViewController.position.outOfRange) {
        if (_controllerQuery.text.replaceAll(" ", "")!="") {

          if(paginationType){

            _scaffoldKey.currentState.showSnackBar(SnackBar(
              backgroundColor: Colors.white,
              content: Container(
                height: 40,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            )
            );

            page++;

            if(searchType==SearchEnum.USERS){
              HomeBlocBuilder.homeCubit.getUsers(_controllerQuery.text, page).asStream();
            }else if(searchType==SearchEnum.REPOSITORIES){
              HomeBlocBuilder.homeCubit.getRepositories(_controllerQuery.text, page).asStream();
            }else if(searchType==SearchEnum.ISSUES){
              HomeBlocBuilder.homeCubit.getIssues(_controllerQuery.text, page).asStream();
            }
          }else{
            if(HomeCubit.dataLength!=1){
                _scaffoldKey.currentState.showSnackBar(
                    SnackBar(
                      duration: Duration(days: 365),
                      backgroundColor: Colors.white,
                      content: Container(
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                  child: Icon(Icons.chevron_left, color: currentPagination!=1? Colors.black : Colors.grey,),
                                  onTap: () {
                                    if(currentPagination!=1){
                                      firstPagination--;
                                      secondPagination--;
                                      thirdPagination--;
                                      currentPagination--;

                                      if(searchType==SearchEnum.USERS){
                                        HomeBlocBuilder.homeCubit.getUsers(_controllerQuery.text, currentPagination).asStream();
                                      }else if(searchType==SearchEnum.REPOSITORIES){
                                        HomeBlocBuilder.homeCubit.getRepositories(_controllerQuery.text, currentPagination).asStream();
                                      }else if(searchType==SearchEnum.ISSUES){
                                        HomeBlocBuilder.homeCubit.getIssues(_controllerQuery.text, currentPagination).asStream();
                                      }
                                    }
                                  }
                              ),
                              SizedBox(width: 20,),
                              InkWell(
                                  child: Text(firstPagination.toString(), style: TextStyle(color: currentPagination!=firstPagination? Colors.black : Colors.black, fontWeight: FontWeight.bold),),
                                  onTap: () {
                                    if(currentPagination!=firstPagination){
                                      currentPagination=firstPagination;

                                      if(searchType==SearchEnum.USERS){
                                        HomeBlocBuilder.homeCubit.getUsers(_controllerQuery.text, currentPagination).asStream();
                                      }else if(searchType==SearchEnum.REPOSITORIES){
                                        HomeBlocBuilder.homeCubit.getRepositories(_controllerQuery.text, currentPagination).asStream();
                                      }else if(searchType==SearchEnum.ISSUES){
                                        HomeBlocBuilder.homeCubit.getIssues(_controllerQuery.text, currentPagination).asStream();
                                      }
                                    }
                                  }
                              ),
                              SizedBox(width: 20,),
                              InkWell(
                                  child: Text(secondPagination.toString(), style: TextStyle(color: currentPagination!=secondPagination? Colors.black : Colors.blueAccent, fontWeight: FontWeight.bold),),
                                  onTap: () {
                                    currentPagination=secondPagination;
                                    firstPagination++;
                                    secondPagination++;
                                    thirdPagination++;

                                    if(searchType==SearchEnum.USERS){
                                      HomeBlocBuilder.homeCubit.getUsers(_controllerQuery.text, currentPagination).asStream();
                                    }else if(searchType==SearchEnum.REPOSITORIES){
                                      HomeBlocBuilder.homeCubit.getRepositories(_controllerQuery.text, currentPagination).asStream();
                                    }else if(searchType==SearchEnum.ISSUES){
                                      HomeBlocBuilder.homeCubit.getIssues(_controllerQuery.text, currentPagination).asStream();
                                    }
                                  }
                              ),
                              HomeCubit.dataLength>2?
                              SizedBox(width: 20,):Container(),
                              HomeCubit.dataLength>2?
                              InkWell(
                                  child: Text(thirdPagination.toString(), style: TextStyle(color: currentPagination!=thirdPagination?Colors.black:Colors.blueAccent, fontWeight: FontWeight.bold),),
                                  onTap: () {
                                    if(HomeCubit.dataLength>3){
                                      currentPagination=thirdPagination;

                                      firstPagination=firstPagination+2;
                                      secondPagination=secondPagination+2;
                                      secondPagination=secondPagination+2;
                                    }else{
                                      currentPagination=thirdPagination;
                                    }

                                    if(searchType==SearchEnum.USERS){
                                      HomeBlocBuilder.homeCubit.getUsers(_controllerQuery.text, currentPagination).asStream();
                                    }else if(searchType==SearchEnum.REPOSITORIES){
                                      HomeBlocBuilder.homeCubit.getRepositories(_controllerQuery.text, currentPagination).asStream();
                                    }else if(searchType==SearchEnum.ISSUES){
                                      HomeBlocBuilder.homeCubit.getIssues(_controllerQuery.text, currentPagination).asStream();
                                    }
                                  }
                              ):Container(),
                              HomeCubit.dataLength>3?
                              SizedBox(width: 20,) : Container(),
                              HomeCubit.dataLength>3?
                              Text("...", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),):Container(),
                              HomeCubit.dataLength>3?
                              SizedBox(width: 20,):Container(),
                              InkWell(
                                  child: Text(HomeCubit.dataLength!=null?HomeCubit.dataLength.toString(): "0", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                  onTap: () {
                                    if(currentPagination!=HomeCubit.dataLength){

                                      currentPagination=HomeCubit.dataLength;
                                      firstPagination=HomeCubit.dataLength-firstPagination;
                                      secondPagination=HomeCubit.dataLength-secondPagination;
                                      thirdPagination=HomeCubit.dataLength-thirdPagination;

                                      if(searchType==SearchEnum.USERS){
                                        HomeBlocBuilder.homeCubit.getUsers(_controllerQuery.text, HomeCubit.dataLength).asStream();
                                      }else if(searchType==SearchEnum.REPOSITORIES){
                                        HomeBlocBuilder.homeCubit.getRepositories(_controllerQuery.text, HomeCubit.dataLength).asStream();
                                      }else if(searchType==SearchEnum.ISSUES){
                                        HomeBlocBuilder.homeCubit.getIssues(_controllerQuery.text, HomeCubit.dataLength).asStream();
                                      }
                                    }
                                  }
                              ),
                              SizedBox(width: 20,),
                              InkWell(
                                  child: Icon(Icons.chevron_right, color: Colors.black,),
                                  onTap: () {
                                    if(currentPagination!=HomeCubit.dataLength||currentPagination!=thirdPagination){

                                      currentPagination++;
                                      firstPagination++;
                                      secondPagination++;
                                      thirdPagination++;

                                      if(searchType==SearchEnum.USERS){
                                        HomeBlocBuilder.homeCubit.getUsers(_controllerQuery.text, HomeCubit.dataLength).asStream();
                                      }else if(searchType==SearchEnum.REPOSITORIES){
                                        HomeBlocBuilder.homeCubit.getRepositories(_controllerQuery.text, HomeCubit.dataLength).asStream();
                                      }else if(searchType==SearchEnum.ISSUES){
                                        HomeBlocBuilder.homeCubit.getIssues(_controllerQuery.text, HomeCubit.dataLength).asStream();
                                      }
                                    }
                                  }
                              ),
                            ],
                          )
                      ),
                    )
                );
              }
            }
          setState(() {});
        }
      }else{
        _scaffoldKey.currentState.hideCurrentSnackBar();
      }
    } on Exception catch(e){
      throw("error");
    }
  }

  _onSearchChanged() {
    try{
      if (_debounce?.isActive ?? false) _debounce.cancel();
      _debounce = Timer(Duration(milliseconds: _debouncetime), () {

        if (_controllerQuery.text.replaceAll(" ", "")!="") {

          page=1;

          if(paginationType){
            if(searchType==SearchEnum.USERS){
              HomeBlocBuilder.homeCubit.getUsers(_controllerQuery.text, page).asStream();
            }else if(searchType==SearchEnum.REPOSITORIES){
              HomeBlocBuilder.homeCubit.getRepositories(_controllerQuery.text, page).asStream();
            }else if(searchType==SearchEnum.ISSUES){
              HomeBlocBuilder.homeCubit.getIssues(_controllerQuery.text, page).asStream();
            }
          }else{
            if(searchType==SearchEnum.USERS){
              HomeBlocBuilder.homeCubit.getUsersIndex(_controllerQuery.text, page).asStream();
            }else if(searchType==SearchEnum.REPOSITORIES){
              HomeBlocBuilder.homeCubit.getUsersIndex(_controllerQuery.text, page).asStream();
            }else if(searchType==SearchEnum.ISSUES){
              HomeBlocBuilder.homeCubit.getUsersIndex(_controllerQuery.text, page).asStream();
            }
          }
          setState(() {});
        }else{
          clearForm();
        }
      });
    } on Exception catch(e){
      throw("error");
    }
  }

  @override
  void dispose() {
    _controllerQuery.removeListener(_onSearchChanged);
    _controllerQuery.dispose();
    super.dispose();
  }

  void clearForm(){
    _controllerQuery.text="";
    HomeBlocBuilder.homeCubit.finish();
    firstPagination=1;
    secondPagination=2;
    thirdPagination=3;
    currentPagination=1;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
        body: new NestedScrollView(
          controller: _nestedScrollViewController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverAppBar(
                backgroundColor: Color.fromRGBO(41, 171, 226 , 1),
                forceElevated: innerBoxIsScrolled,
                floating: true,
                pinned: true,
                snap: true,
                title: !isScrolled?
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromRGBO(225, 225, 225 , 0.75),
                  ),
                  height: 45,
                  child: TextField(
                    controller: _controllerQuery,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.black,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        fillColor: Colors.black
                    ),
                  ),
                ) : Container(),
                bottom: PreferredSize(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(41, 171, 226 , 1),
                      ),
                      child: Column(
                        children: [
                          Theme(
                            data: ThemeData.dark(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new Radio(
                                  value: SearchEnum.USERS,
                                  groupValue: searchType,
                                  activeColor: Colors.white,
                                  onChanged: ((value){
                                    debugPrint(value.toString());
                                    setState(() {
                                      searchType=value;
                                      clearForm();
                                    });
                                  }),
                                ),
                                Text("User", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                new Radio(
                                  value: SearchEnum.ISSUES,
                                  groupValue: searchType,
                                  activeColor: Colors.white,
                                  onChanged: ((value){
                                    debugPrint(value.toString());
                                    setState(() {
                                      searchType=value;
                                      clearForm();
                                    });
                                  }),
                                ),
                                Text("Issues", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                new Radio(
                                  value: SearchEnum.REPOSITORIES,
                                  groupValue: searchType,
                                  activeColor: Colors.white,
                                  onChanged: ((value){
                                    debugPrint(value.toString());
                                    setState(() {
                                      searchType=value;
                                      clearForm();
                                    });
                                  }),
                                ),
                                Text("Repositories", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ChoiceChip(
                                label: Text("Lazy Loading", style: TextStyle(color: paginationType ? Colors.white:Colors.black, fontWeight: FontWeight.bold),),
                                selected: paginationType,
                                selectedColor: Colors.black,
                                backgroundColor: Colors.white,
                                onSelected: (selected) {
                                  paginationType=true;
                                  clearForm();
                                  setState(() {});
                                },
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5)
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              ChoiceChip(
                                label: Text("With Index", style: TextStyle(color: !paginationType ? Colors.white: Colors.black, fontWeight: FontWeight.bold),),
                                selected: !paginationType,
                                selectedColor: Colors.black,
                                backgroundColor: Colors.white,
                                onSelected: (selected) {
                                  paginationType=false;
                                  clearForm();
                                  setState(() {});
                                },
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5)
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    preferredSize: Size.fromHeight(100.0)
                )
              ),
            ];
          },
          body: Stack(
            children: [
              ListView(
                controller: _scrollViewController,
                children: [
                  HomeBlocBuilder.instance().buildResult(),
                ],
              )
            ],
          )
        ),
    );
  }
}
