import 'package:arenation_app/utils/custom_colors.dart';
import 'package:arenation_app/utils/text_theme.dart';
import 'package:arenation_app/widgets/skeletons.dart';
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
      backgroundColor: CustomColors.secondaryWhite,
      appBar: AppBar(
        backgroundColor: CustomColors.secondaryWhite,
        elevation: 0,
        title: Text("Arenation", style: CustomTextTheme.h2(context)),
      ),
      body: Consumer<GetArenas>(
        builder: (_context, getArenas, child) {
          // getArenas.setState(StateHttp.loading);
          return Column(children: [
            filterHeader(_context),
            listArenas(context, getArenas),
          ]);
        },
      ),
    );
  }

  Widget filterHeader(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Encuentra tu Arena",
            style: CustomTextTheme.h1(context),
          ),
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.filter_alt_outlined,
              color: CustomColors.secondaryDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget listArenas(BuildContext mainContext, GetArenas arenas) {
    DataResponseArenas data;
    return Expanded(
        child: arenas.state == StateHttp.error
            ? const Text("Error")
            : Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                child: Column(
                  children: [
                    FutureBuilder<Response>(
                      future: arenas.state == StateHttp.loading
                          ? arenas.getArenas()
                          : null,
                      builder: (BuildContext context,
                          AsyncSnapshot<Response> snapshot) {
                        if (snapshot.hasData) {
                          data = snapshot.data!.getData as DataResponseArenas;
                          for (var arena in data.data) {
                            return arenaCard(arena);
                          }
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return skeletonCardArena(mainContext);
                      },
                    )
                  ],
                ),
              ));
  }

  Widget arenaCard(arena) {
    return InkWell(
        child: Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      child: Column(),
    ));
  }
}
