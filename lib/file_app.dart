import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FileApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FileApp();
}

class _FileApp extends State<FileApp> {
  int _count = 0;
  List<String> itemList = new List.empty(growable: true);
  TextEditingController controller = new TextEditingController();

  Future<List<String>> readListFile() async {
    List<String> itemList = new List.empty(growable: true);
    var key = 'first';
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? firstCheck = pref.getBool(key);
    var dir = await getApplicationDocumentsDirectory();
    bool fileExist = await File(dir.path + '/fruit.txt').exists();

    if (notExistData(firstCheck, fileExist)){
      pref.setBool(key, true);
      var file = await DefaultAssetBundle.of(context).loadString('repo/fruit.txt');
      File(dir.path + '/fruit.txt').writeAsStringSync(file);
      return parseList(file, itemList);
    }
    return await getDataFromAppDir(itemList, dir);
  }


  Future <List<String>> getDataFromAppDir(itemList, dir) async{
    var file = await File(dir.path + '/fruit.txt').readAsString();
    return parseList(file, itemList);
  }

  List<String> parseList(String file, List<String> itemList){
    var array = file.split('\n');
    for (var item in array){
      itemList.add(item);
    }
    return itemList;
  }

  bool notExistData(bool? firstCheck, bool fileExist) => firstCheck == null || firstCheck == false || fileExist == false;
  @override
  void initState(){
    super.initState();
    readCountFile();
    initData();
  }
  void initData() async{
    var result = await readListFile();
    setState(() {
      itemList.addAll(result);
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('File example'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              TextField(
                controller: controller,
                keyboardType: TextInputType.text,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index){
                    return Card(
                      child: Text(
                        itemList[index],
                        style: TextStyle(fontSize: 30),
                      ),
                    );
                  },
                  itemCount: itemList.length,
                )
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void writeCountFile(int count) async{
    var dir = await getApplicationDocumentsDirectory();
    File( '${dir.path}/count.txt').writeAsStringSync(count.toString());
  }

  void readCountFile() async {
    try{
      var dir = await getApplicationDocumentsDirectory();
      var file = await File('${dir.path}/count.txt').readAsString();
      print(file);
      setState(() {
        _count = int.parse(file);
      });
    }catch(e){
      print(e.toString());
    }
  }
}