import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:arenation_app/utils/custom_colors.dart';
import 'package:provider/provider.dart';
import '../services/http/arenas/getArenas.dart';
import '../models/response.dart';
import 'package:arenation_app/widgets/skeletons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:arenation_app/utils/text_theme.dart';
import '../services/httpstate.dart';
import '../models/arenas/modelArena.dart';

class Arena extends StatelessWidget {
  const Arena({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.secondaryWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CustomColors.secondaryWhite,
        elevation: 0,
        titleSpacing: 0,
        title: Text("Arena"),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_rounded,
            color: CustomColors.placeholderColor,
          ),
        ),
      ),
      body: Consumer<GetArenas>(
        builder: (_context, getArenas, child) {
          return Column(children: [
            Expanded(
              child: _bodyPage(context, getArenas),
            )
          ]);
        },
      ),
    );
  }

  Widget _bodyPage(BuildContext bodyContext, GetArenas arenas) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
        child: Column(
          children: [
            FutureBuilder<Response>(
              future: arenas.state == StateHttp.loading &&
                      arenas.state != StateHttp.success
                  ? arenas.getArena()
                  : null,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return skeletonCardArena(bodyContext);
                }else if (snapshot.hasData) {
                  var data = snapshot.data!.getData as DataArena;
                  return Text(data.data.title);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else {
                  return arenaEmptyResult(bodyContext);
                }
              },
            )
          ],
        ));
  }

  Widget arenaEmptyResult(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 8.0),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 32),
            child: Text(
              "No hay resultados",
            ),
          ),
          Text(
            "Ups! Ha ocurrido un error",
            style: CustomTextTheme.h1(context),
          )
        ],
      ),
    );
  }
}
