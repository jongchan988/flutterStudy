import 'package:dailyfish_app/intro.dart';
import 'package:flutter/material.dart';
import 'entity/people.dart';
import 'second_page.dart';
import 'sliver_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: IntroPage(),
    );
  }
}

class AnimationApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnimationApp();
}

class _AnimationApp extends State<AnimationApp>{
  List<People> peoples = new List.empty(growable: true);
  Color weightColor = Colors.blue;
  int current = 0;
  double _opacity = 1;

  void _changeWeightColor(double weight){
    if(weight < 40){
      weightColor = Colors.blueAccent;
    } else if(weight < 60){
      weightColor = Colors.indigo;
    } else if(weight < 80){
      weightColor = Colors.orange;
    } else {
      weightColor = Colors.red;
    }
  }

  @override
  void initState(){
    peoples.add(People('스미스', 172, 73));
    peoples.add(People('스미1', 170, 57));
    peoples.add(People('스미2', 170, 52));
    peoples.add(People('스미3', 210, 62));
    peoples.add(People('스미4', 184, 72));
    peoples.add(People('스미5', 111, 82));
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation Example'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              AnimatedOpacity(
                opacity: _opacity,
                duration: Duration(seconds: 1),
                child: SizedBox(
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 100,
                        child: Text('이름: ${peoples[current].name}'),

                      ),
                      AnimatedContainer(
                        duration: Duration(seconds: 2),
                        curve: Curves.bounceIn,
                        color: Colors.amber,
                        child: Text(
                          '키 ${peoples[current].height}',
                          textAlign: TextAlign.center,
                        ),
                        width: 50,
                        height: peoples[current].height,
                      ),
                      AnimatedContainer(
                        duration: Duration(seconds: 2),
                        curve: Curves.easeInCubic,
                        color: weightColor,
                        child: Text(
                          '몸무게 ${peoples[current].weight}',
                          textAlign: TextAlign.center,
                        ),
                        width: 50,
                        height: peoples[current].weight,
                      ),
                      AnimatedContainer(
                        duration: Duration(seconds: 2),
                        curve: Curves.linear,
                        color: Colors.pinkAccent,
                        child: Text(
                          'bmi ${peoples[current].bmi.toString().substring(0,2)}',
                          textAlign: TextAlign.center,
                        ),
                        width: 50,
                        height: peoples[current].bmi,
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                  ),
                  height:200,
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  setState(() {
                    if(current < peoples.length -1){
                      current++;
                    }
                    _changeWeightColor(peoples[current].weight);
                  });
                },
                child: Text('다음'),
              ),
              ElevatedButton(
                onPressed: (){
                  setState(() {
                    if(current > 0){
                      current--;
                    }
                    _changeWeightColor(peoples[current].weight);
                  });
                },
                child: Text('이전'),
              ),
              ElevatedButton(
                onPressed: (){
                  setState(() {
                    _opacity == 1? _opacity = 0 : _opacity = 1;
                  });
                },
                child: Text('${_opacity == 1 ? '사라지기': '나타나기'}'),
              ),
              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SecondPage()
                    )
                  );
                },
                child: SizedBox(
                  width: 200,
                  child: Row(
                    children: <Widget>[
                      Hero(
                        tag: 'detail',
                        child: Icon(Icons.cake),
                      ),
                      Text('이동하기')
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SliverPage()));
                },
                child: Text('페이지 이동'),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }
}