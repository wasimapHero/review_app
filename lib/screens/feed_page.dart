import 'package:flutter/material.dart';

class FeedPage extends StatelessWidget {
const FeedPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        body: Center(child: Text("Feed Page"),),
      ),
    );
  }
}