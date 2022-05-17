import 'package:arenation_app/utils/custom_colors.dart';
import 'package:arenation_app/utils/text_theme.dart';
import 'package:arenation_app/widgets/skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../services/http/arenas/getArenas.dart';
import '../services/httpstate.dart';
import '../models/response.dart';
import '../models/arenas/modelArena.dart';
import 'package:arenation_app/utils/functions/get_avg_score.dart';
import "package:intl/intl.dart";
import 'package:cached_network_image/cached_network_image.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.secondaryWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CustomColors.secondaryWhite,
        elevation: 0,
        // title: Text("Arenation", style: CustomTextTheme.h2(context),),
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: SvgPicture.asset("assets/svg/logo.svg"),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 24.0,
              top: 5.0,
              bottom: 5.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: CustomColors.secondaryLight,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.person_outline_rounded,
                    color: CustomColors.placeholderColor,
                  )),
            ),
          )
        ],
      ),
      body: Consumer<GetArenas>(
        builder: (_context, getArenas, child) {
          return Column(children: [
            filterHeader(_context),
            Expanded(
              child: listArenas(context, getArenas),
            )
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
    String sport = "";
    String city = "";
    Map<String, String> body = {
      "sport": sport,
      "city": city,
    };
    return arenas.state == StateHttp.error
        ? arenaEmptyResult(mainContext)
        : Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: Column(
              children: [
                FutureBuilder<Response>(
                  future: arenas.state == StateHttp.loading
                      ? arenas.getArenas(body)
                      : null,
                  builder:
                      (BuildContext context, AsyncSnapshot<Response> snapshot) {
                    if (snapshot.hasData) {
                      data = snapshot.data!.getData as DataResponseArenas;
                      return Expanded(
                        child: ListView.builder(
                          itemCount: data.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                              child:
                                  arenaCard(context, data.data[index], arenas),
                            );
                          },
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return skeletonCardArena(mainContext);
                  },
                )
              ],
            ),
          );
  }

  Widget arenaEmptyResult(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 8.0),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 32),
            child: SvgPicture.asset(
              "assets/svg/empty_arena_state.svg",
              height: 120,
            ),
          ),
          Text(
            "Ups! No encontramos resultados",
            style: CustomTextTheme.h1(context),
          )
        ],
      ),
    );
  }

  Widget arenaCard(BuildContext context, Arenas arena, GetArenas id) {
    if (arena != null) {
      return InkWell(
        onTap: () {
          id.arenaSelected.setId(arena.id);
          id.setState(StateHttp.loading);
          Navigator.pushNamed(context, "/arena");
        },
        child: Container(
          decoration: BoxDecoration(
            color: CustomColors.secondaryWhite,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                placeholder: ((context, url) => arenaImageSkeleton(170.0)),
                imageUrl: arena.images[0],
                imageBuilder: (context, imageProvider) => Container(
                  width: double.infinity,
                  height: 170,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                    color: CustomColors.primary100,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  arena.title,
                  style: CustomTextTheme.h1(context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: CustomColors.secondaryDark,
                      size: 20,
                    ),
                    Text(
                      "${arena.city}, ${arena.department}",
                      style: CustomTextTheme.p200(
                          context, CustomColors.secondaryDark),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: CustomColors.warning,
                          size: 20,
                        ),
                        Text(
                          "${AVGScore.getAVGScore(arena.reviews)}",
                          style: CustomTextTheme.p200(
                              context, CustomColors.secondaryDark),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "desde ${NumberFormat.simpleCurrency().format(arena.price)}",
                          style: CustomTextTheme.p200(
                              context, CustomColors.secondaryDark,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "/hora",
                          style: CustomTextTheme.p200(
                              context, CustomColors.placeholderColor),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Column(children: const [
      Text("No hay Arenas"),
    ]);
  }
}
