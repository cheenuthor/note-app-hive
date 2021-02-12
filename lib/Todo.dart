import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/main.dart';
import 'package:notes/search.dart';
import 'package:notes/widget/modal.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var dataBox;



  @override
  void initState() {
    super.initState();
    dataBox = Hive.box(box);
  }

  void addTodo(String todo)  {
    setState(() {
      todoBox.add(todo.toString());
    });
    Navigator.pop(context);
  }

  void deleteTodo(int index) {
    setState(() {
      todoBox.deleteAt(index);
    });
  }

  void searchList(filteredUsers, value) {
    filteredUsers = todoBox.values.where((todo) => todo.startsWith(value));

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Search(
          list: filteredUsers,
        ),
      ),
    );
  }
  final todoBox = Hive.box('todo');

  @override
  Widget build(BuildContext context) {
  bool isEmpty = Hive.box('todo').isEmpty;
    var filteredUsers;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("TO-DO"),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.delete), onPressed: () => todoBox.clear())
        ],
      ),
      body: Container(
        child: isEmpty
            ? Center(child: Text("Add T0-D0s"))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search your todo here...',
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                            ),
                          ),
                          onSubmitted: (value) {
                            searchList(filteredUsers, value);
                          }),
                    ),
                    ValueListenableBuilder(
                      valueListenable: Hive.box(box).listenable(),
                      builder: (context, box, widget) {
                        return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: box.length,
                            itemBuilder: (context, index) {
                              final String todo =
                                  todoBox.getAt(index).toString();
                              return ListTile(
                                title: Text(
                                  todo,
                                  style: TextStyle(
                                    color: Color(0xff0C2D48),
                                  ),
                                ),
                                trailing: IconButton(
                                  onPressed: () => deleteTodo(
                                    index,
                                  ),
                                  icon: Icon(
                                    Icons.delete,
                                    // color: Colors.red,
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                  ],
                ),
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModel(context, addTodo),
        child: Icon(Icons.add),
      ),
    );
  }
}
