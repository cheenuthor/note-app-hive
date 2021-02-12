
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  final list;

  const Search({Key key, @required this.list}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    List<String> searched = List.from(widget.list);
    bool isFound = searched.length > 0;
    print(searched);
    return Scaffold(
      appBar: AppBar(
        title: Text("TO-DO"),
        centerTitle: true,
        // actions: [
        //   IconButton(icon: Icon(Icons.delete), onPressed: () => todoBox.clear())
        // ],
      ),
      body: !isFound
          ? Center(
              child: Text("Not Found :("),
            )
          : ListView.builder(
        physics: BouncingScrollPhysics(),
              itemCount: searched.length,
              itemBuilder: (context, index) {
                // final String todo = todoBox.getAt(index).toString();
                return ListTile(
                  title: Text(searched[index]),
                );
              }),
    );
  }
}
