import 'package:flutter/material.dart';

class SliverPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SliverPage();
}

class _SliverPage extends State<SliverPage>{
  Widget customCard(String text){
    return Card(
      child: Container(
        height: 120,
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Sliver Example'),
              background: Image.asset('repo/images/sunny.png'),
            ),
            backgroundColor: Colors.deepOrangeAccent,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                customCard('1'),
                customCard('2'),
                customCard('3'),
                customCard('4'),
              ]
            ),
          ),
          SliverGrid(
            delegate: SliverChildListDelegate([
              customCard('1'),
              customCard('2'),
              customCard('3'),
              customCard('4'),
            ]),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          )
        ],
      ),
    );
  }
}