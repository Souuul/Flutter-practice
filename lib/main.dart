import 'package:flutter/material.dart';
import 'package:to_do_project/data/util.dart';
import 'package:to_do_project/write.dart';
import 'data/todo.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<Todo> todos = [
    Todo(
      title: '패스트캠퍼스 강의듣기1',
      memo: '앱개발 입문강의 듣기1',
      color: Colors.redAccent.value,
      done: 0,
      category: '공부',
      date: 20210709,

    ),
    Todo(
      title: '패스트캠퍼스 강의듣기2',
      memo: '앱개발 입문강의 듣기2',
      color: Colors.blue.value,
      done: 1,
      category: '공부',
      date: 20210709,
    ),
  ];

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: PreferredSize(child: AppBar(),
        preferredSize: Size.fromHeight(0),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white,),
        onPressed: () async {
          Todo todo = await Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => TodoWrightPage(todo: Todo(
            title: '',
            color: 0,
            memo: '',
            done: 0,
            category: '',
            date:utils.getFormatTime(DateTime.now())
          ))));
          setState(() {
            todos.add(todo);
          });
        },
      ),
      body: ListView.builder(
        itemBuilder: (ctx, idx){
          if(idx ==0) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              child: Text('오늘하루', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            );
          }else if(idx==1){

            List<Todo> undone = todos.where((t){
              return t.done == 0;
            }).toList();

            return Container(
                child: Column(
                  children: List.generate(undone.length, (_idx){
                    Todo t = undone[_idx];

                    return InkWell(child : TodoCardWidget(t: t),
                      onTap: (){
                      setState(() {
                        if (t.done == 0){
                          t.done = 1;
                        }else{
                          t.done = 0;
                        }
                      }
                      );

                      },
                      onLongPress: () async{
                        Todo todo = await Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => TodoWrightPage(todo: t
                        )));
                        setState(() {
                        });
                      },
                    );

                  }),
                )
            );
          }else if(idx ==2) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              child: Text('완료된 하루', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            );
          }else if(idx==3){
            List<Todo> done = todos.where((t){
              return t.done == 1;
            }).toList();
            return Container(
                child: Column(
                  children: List.generate(done.length, (_idx){
                    Todo t = done[_idx];
                    return InkWell(child : TodoCardWidget(t: t),
                      onTap: (){
                        setState(() {
                          if (t.done == 0){
                            t.done = 1;
                          }else{
                            t.done = 0;
                          }
                        }
                        );

                      },
                      onLongPress: () async{
                        Todo todo = await Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => TodoWrightPage(todo: t
                        )));
                        setState(() {
                        });
                      },
                    );

                  }),
                )
            );
          }
          return Container();

        },
        itemCount: 4,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.today_outlined),
              label: '오늘'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment_late_outlined),
              label: '기록'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              label: '더보기'
          )
        ],
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


class TodoCardWidget extends StatelessWidget {
  final Todo t;

  TodoCardWidget({Key? key, required this.t}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(t.color),
          borderRadius: BorderRadius.circular(16)
      ),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children : [
              Text(t.title, style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),),
              Text(t.done == 0 ? '미완료' : "완료", style: TextStyle(color: Colors.white),),
            ],
          ),
          Container(height: 12,),
          Text(t.memo, style: TextStyle(color: Colors.white),)
        ],
      ),
    );
  }
}
