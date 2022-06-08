import 'package:arenation_app/services/http/users/getUser.dart';
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
import 'package:fluttertoast/fluttertoast.dart';
import '../utils/button_style.dart';
import '../utils/textfield_style.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return HomeStatefulWidget();
  }
}

class HomeStatefulWidget extends StatefulWidget {
  HomeStatefulWidget({Key? key}) : super(key: key);

  @override
  _HomeStatefulWidgetState createState() => _HomeStatefulWidgetState();
}

class _HomeStatefulWidgetState extends State<HomeStatefulWidget> {
  int counter = 0;

  String sport = "";
  String city = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
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
                      onPressed: () => Navigator.pushNamed(context, "/profile"),
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
                filterHeader(_context, getArenas),
                Expanded(
                  child: listArenas(context, getArenas),
                )
              ]);
            },
          ),
        ),
        onWillPop: () async {
          counter = counter + 1;
          if (counter == 2) {
            Fluttertoast.showToast(
                msg: "Presiona nuevamente para salir de la aplicación",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black54,
                textColor: Colors.white,
                fontSize: 16.0);
            Future.delayed(const Duration(seconds: 3), () {
              counter = 0;
            });
          } else if (counter == 3) {
            counter = 0;
            Provider.of<GetArenas>(context, listen: false)
                .setStateOne(StateHttp.init);
            Navigator.pushNamed(context, "/");
          }
          return false;
        });
  }

  Widget filterHeader(BuildContext context, GetArenas arenas) {
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
            onPressed: () {
              showModalFilter(context, arenas);
            },
            icon: Icon(
              Icons.filter_list_rounded,
              color: CustomColors.placeholderColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget listArenas(BuildContext mainContext, GetArenas arenas) {
    DataResponseArenas data;
    String sportData = sport;
    String cityData = city;
    switch (sportData) {
      case "Fútbol":
        sportData = "627ee546e34dcdc7fb4c127e";
        break;
      case "Baloncesto":
        sportData = "62a0043245012af976eaf157";
        break;
      case "Voleibol":
        sportData = "62a0047645012af976eaf159";
        break;
      case "Tenis":
        sportData = "62a0046445012af976eaf158";
        break;
      case "Seleccionar deporte":
        sportData = "";
        break;
    }
    switch (cityData) {
      case "Seleccionar ciudad":
        cityData = "";
        break;
      default:
        cityData = city;
        break;
    }
    Map<String, String> body = {
      "sport": sportData,
      "city": cityData,
    };

    return arenas.stateOne == StateHttp.error
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [arenaEmptyResult(mainContext)],
          )
        : Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: Column(
              children: [
                FutureBuilder<Response>(
                  future: arenas.stateOne == StateHttp.loading
                      ? arenas.getArenas(body)
                      : null,
                  builder:
                      (BuildContext context, AsyncSnapshot<Response> snapshot) {
                    if (snapshot.hasData) {
                      data = snapshot.data!.getData as DataResponseArenas;
                      return Expanded(
                          child: data.data.isNotEmpty
                              ? ListView.builder(
                                  itemCount: data.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 16, 0, 16),
                                      child: arenaCard(
                                          context, data.data[index], arenas),
                                    );
                                  },
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [arenaEmptyResult(mainContext)],
                                ));
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
        mainAxisAlignment: MainAxisAlignment.center,
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
            textAlign: TextAlign.center,
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

  void showModalFilter(BuildContext context, GetArenas services) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Filtros",
                      style: CustomTextTheme.h1(context),
                    ),
                    Container(margin: const EdgeInsets.only(bottom: 16)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Ciudad",
                          style: CustomTextTheme.h2(context),
                        ),
                      ],
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: CustomColors.secondaryLight,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0))),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          underline: Container(
                            height: 4,
                          ),
                          value: city.isEmpty ? "Seleccionar ciudad" : city,
                          elevation: 50,
                          style: TextStyle(color: CustomColors.secondaryDark),
                          items: <String>[
                            "Seleccionar ciudad",
                            "Montería",
                            "San Pelayo",
                            "Cereté",
                            "Sahagún",
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              city = newValue!;
                            });
                          },
                        )),
                    Container(margin: const EdgeInsets.only(bottom: 16)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Deporte",
                          style: CustomTextTheme.h2(context),
                        ),
                      ],
                    ),
                    //Cambiar estructura de muestra de items... Que vengan de la BD.
                    Container(
                        decoration: BoxDecoration(
                            color: CustomColors.secondaryLight,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0))),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          underline: Container(
                            height: 4,
                          ),
                          value: sport.isEmpty ? "Seleccionar deporte" : sport,
                          elevation: 50,
                          style: TextStyle(color: CustomColors.secondaryDark),
                          items: <String>[
                            "Seleccionar deporte",
                            "Fútbol",
                            "Baloncesto",
                            "Voleibol",
                            "Tenis"
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              sport = newValue!;
                            });
                          },
                        )),
                    Container(margin: const EdgeInsets.only(bottom: 16)),
                    TextButton(
                      onPressed: () {
                        services.setStateOne(StateHttp.loading);
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          Navigator.pop(context);
                        });
                      },
                      style: CustomButtonStyle.solidButton(context,
                          fullWidth: true, pd: 12),
                      child: Text(
                        "Buscar",
                        style: CustomTextTheme.buttonText(
                            context, CustomColors.secondaryWhite),
                      ),
                    ),
                    Container(margin: const EdgeInsets.only(bottom: 14)),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          city = "";
                          sport = "";
                        });
                        services.setStateOne(StateHttp.loading);
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          Navigator.pop(context);
                        });
                      },
                      style: CustomButtonStyle.outlinedButton(context,
                          fullWidth: true, pd: 12),
                      child: Text(
                        "Limpiar filtros",
                        textAlign: TextAlign.left,
                        style: CustomTextTheme.buttonText(
                            context, CustomColors.primary500),
                      ),
                    ),
                  ],
                ),
              ));
        });
      },
    );
  }
}
