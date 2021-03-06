import 'package:dailyfish_app/iosSub/cupertino_second_page.dart';
import 'package:flutter/cupertino.dart';
import 'animal_item.dart';
import 'iosSub/cupertino_first_page.dart';
import 'cupertino_design_page.dart';

class CupertinoMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CupertinoMain();
  }
}

class _CupertinoMain extends State<CupertinoMain> {
  CupertinoTabBar? tabBar;
  List<Animal> animalList = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    tabBar = CupertinoTabBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.home)),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.add)),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.add))
      ],
    );
    animalList.add(
        Animal(animalName: "벌", kind: "곤충", imagePath: "repo/images/bee.png"));
    animalList.add(Animal(
        animalName: "고양이", kind: "포유류", imagePath: "repo/images/cat.png"));
    animalList.add(Animal(
        animalName: "젖소", kind: "포유류", imagePath: "repo/images/cow.png"));
    animalList.add(Animal(
        animalName: "강아지", kind: "포유류", imagePath: "repo/images/dog.png"));
    animalList.add(Animal(
        animalName: "여우", kind: "포유류", imagePath: "repo/images/fox.png"));
    animalList.add(Animal(
        animalName: "원숭이", kind: "영장류", imagePath: "repo/images/monkey.png"));
    animalList.add(Animal(
        animalName: "돼지", kind: "포유류", imagePath: "repo/images/pig.png"));
    animalList.add(Animal(
        animalName: "늑대", kind: "포유류", imagePath: "repo/images/wolf.png"));
  }

  Widget getTabBuilderContainer(BuildContext context, int value) {
    int tabNo = value + 1;
    switch (value){
      case 0 :
        return CupertinoFirstPage(
          animalList: animalList,
        );
      case 1 :
        return CupertinoSecondPage(
          animalList: animalList,
        );
      case 2 :
        return CupertinoDesignPage(

        );
    }
    return Container(
      child: Center(
        child: Text('cupertino tab $tabNo'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoTabScaffold(
          tabBar: tabBar!,
          tabBuilder: (context, value) {
            return getTabBuilderContainer(context, value);
          }),
    );
  }
}
