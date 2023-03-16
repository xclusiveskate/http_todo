import 'package:flutter/material.dart';
import 'package:http_todo/service.dart';

// import 'dart:async';

class HttpTodo extends StatefulWidget {
  const HttpTodo({super.key});

  @override
  State<HttpTodo> createState() => _HttpTodoState();
}

class _HttpTodoState extends State<HttpTodo> {
  ScrollController control = ScrollController();
  bool searching = false;
  late Future call;

  getCall() async {
    var awaitedCalls = await HttpCall().getRequest();
    return awaitedCalls;
  }

  @override
  void initState() {
    call = getCall();
    super.initState();
  }

  @override
  void dispose() {
    getCall();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            "Http request from jsonPlaceHolder",
            style: TextStyle(fontSize: 15),
          ),
          actions: [
            searching
                ? SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: const TextField(),
                  )
                : const SizedBox.shrink(),
            IconButton(
                onPressed: () {
                  setState(() {
                    searching = !searching;
                  });
                },
                icon: const Icon(Icons.search))
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          controller: control,
          child: FutureBuilder(
              future: getCall(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  List datas = snapshot.data;
                  // print(snapshot.data);
                  print(datas.length);
                  return ListView.builder(
                      controller: control,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: datas.length,
                      itemBuilder: (context, index) {
                        // var theTodo = snapshot.data!;

                        var item = datas[index];

                        return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: ListTile(
                              tileColor:
                                  const Color.fromARGB(255, 195, 229, 244),
                              onTap: () {},
                              leading: Text(
                                item['id'].toString(),
                                style: const TextStyle(fontSize: 16),
                              ),
                              subtitle: Text(
                                item['title'],
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.justify,
                                style: const TextStyle(fontSize: 16),
                              ),
                              trailing: PopupMenuButton(
                                onSelected: (value) {},
                                child: const Icon(Icons.more_vert),
                                itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                        onTap: () {},
                                        value: 1,
                                        child: const Text("Delete")),
                                    PopupMenuItem(
                                        onTap: () async {
                                          await showDialog(
                                              barrierDismissible: true,
                                              barrierColor:
                                                  const Color.fromARGB(
                                                          255, 249, 228, 164)
                                                      .withOpacity(.5),
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  backgroundColor: Colors.amber
                                                      .withOpacity(.6),
                                                  elevation: 10,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                );
                                              });
                                        },
                                        value: 2,
                                        child: const Text("Show More details")),
                                  ];
                                },
                              ),
                            ));
                      });
                } else {
                  return Text("${snapshot.error}");
                }
              }),
        ),
      ),
    );
  }
}
