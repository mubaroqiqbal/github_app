import 'package:flutter/material.dart';

class ErrorList extends StatelessWidget{

  final String message;

  ErrorList(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 700 * (MediaQuery.of(context).size.width/1000),
                margin: EdgeInsets.only(bottom: 20),
                child: AspectRatio(
                  aspectRatio: 223/166,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/ilustrasi-error.png"),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                ),
              ),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Proxima Nova",
                    fontWeight: FontWeight.w700),
              ),
            ]
        )
    );
  }

}