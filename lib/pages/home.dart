import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/http/arenas/getArenas.dart';
import '../services/httpstate.dart';
import '../models/response.dart';
import '../models/arenas/modelArena.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Arenas"),
      ),
      body: Consumer<GetArenas>(
        builder: (context, getArenas, child) {
          getArenas.setState(StateHttp.loading);
          return Column(children: [
            ListArenas(getArenas),
          ]);
        },
      ),
    );
  }

  Widget ListArenas(GetArenas arenas) {
    DataResponseArenas data;
    return Center(
        child: arenas.state == StateHttp.error
            ? Text("Error")
            : FutureBuilder<Response>(
                future: arenas.state == StateHttp.loading? arenas.getArenas():null,
                builder:
                    (BuildContext context, AsyncSnapshot<Response> snapshot) {
                  if (snapshot.hasData) {
                    data = snapshot.data!.getData as DataResponseArenas;
                    for (var arena in data.data){
                      return Text(arena.title);
                    }
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return const CircularProgressIndicator();
                },
              ));
  }
}
