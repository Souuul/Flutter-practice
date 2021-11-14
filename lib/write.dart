import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'data/todo.dart'; //art enter

class TodoWrightPage extends StatefulWidget {
  final Todo todo;

  TodoWrightPage({key, required this.todo}): super(key:key);

  @override
  State<StatefulWidget> createState() {
    return _TodoWriteState();
  }
}


class _TodoWriteState extends State<TodoWrightPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController memoController = TextEditingController();
  int colorIndex = 0;
  int ctIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.todo.title;
    memoController.text = widget.todo.memo;

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            //페이지 저장시 사용
            child: Text('저장', style: TextStyle(color: Colors.white),),
            onPressed: (){
              widget.todo.title = nameController.text;
              widget.todo.memo = memoController.text;
              Navigator.of(context).pop(widget.todo);
            },
          )
        ],
      ),
      body: ListView.builder(

          itemBuilder: (ctx, idx) {
        if(idx ==0) {
          return Container(
            child: Text('제목', style: TextStyle(fontSize: 20),),
            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          );
        } else if(idx ==1) {
          return Container(
            child: TextField(
              controller: nameController,
            ),
            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          );
        }
        else if(idx == 2) {
          return InkWell(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('색상' , style: TextStyle(fontSize: 20)),
                  Container(
                    width: 10,
                    height: 10,
                    color: Color(widget.todo.color),
                  )
                ],
              ),
            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),

            ),
            onTap: (){
              List<Color> colors = [
                Color(0xFF80d3f4),
                Color(0xFFa794fa),
                Color(0xFFfb91d1),
                Color(0xFFfb8a94),
                Color(0xFFfebd9a),
                Color(0xFF51e29d),
                Color(0xFFFFFFFF),
              ];
              widget.todo.color = colors[colorIndex].value;
              colorIndex++;

              setState(() {
                colorIndex = colorIndex % colors.length;
              });


            },
          );
        }
        else if(idx == 3) {
          return InkWell(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text('카테고리', style: TextStyle(fontSize: 20)),
                  Text(widget.todo.category),
                ],
              ),
            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),

            ),
            onTap: (){
              List<String> category = ['공부', '운동', '게임'];
              widget.todo.category = category[ctIndex];
              ctIndex++;
              setState(() {
                ctIndex = ctIndex % category.length;
              });
            },
          );
        }

        else if(idx == 4) {
          return Container(
            child: Row(
              children: [
                Text('메모 ', style: TextStyle(fontSize: 20)),
              ],
            ),
            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),

          );
        }

        else if(idx == 5) {
          return Container(
            child: TextField(
              controller: memoController,
              maxLines: 10,
              minLines: 10,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black
                  )
                ),
              ),
            ),
            margin: EdgeInsets.symmetric(vertical: 1, horizontal: 16),

          );
        }

        return Container();
      },
        itemCount: 6,
      ),
    );
  }
}