// ignore_for_file: sized_box_for_whitespace

import 'package:arenation_app/utils/functions/get_avg_score.dart';
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
import 'package:arenation_app/widgets/image_carousel.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../utils/button_style.dart';

class Arena extends StatelessWidget {
  Arena({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ArenaStatefulWidget();
  }
}

class ArenaStatefulWidget extends StatefulWidget {
  ArenaStatefulWidget({Key? key}) : super(key: key);
  @override
  _ArenaStatefulWidget createState() => _ArenaStatefulWidget();
}

class _ArenaStatefulWidget extends State<ArenaStatefulWidget> {
  bool scheduleDay = false;
  bool scheduleDefined = false;
  DateTime initialDate = DateTime.now();
  String schedule = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.secondaryWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CustomColors.secondaryWhite,
        elevation: 0,
        titleSpacing: 0,
        title: const Text("Arena"),
        leading: IconButton(
          onPressed: () {
            Provider.of<GetArenas>(context, listen: false)
                .setStateOne(StateHttp.loading);
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.chevron_left_outlined,
            color: CustomColors.secondaryDark,
          ),
        ),
      ),
      body: Consumer<GetArenas>(
        builder: (_context, getArenas, child) {
          return _bodyPage(context, getArenas);
        },
      ),
    );
  }

  Widget _bodyPage(BuildContext bodyContext, GetArenas arenas) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(children: [
        FutureBuilder<Response>(
          future: arenas.state == StateHttp.loading &&
                  arenas.state != StateHttp.success
              ? arenas.getArena()
              : null,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return selectedArenaSkeleton(bodyContext);
            } else if (snapshot.hasData) {
              var data = snapshot.data!.getData as DataArena;
              return arenaDetails(bodyContext, data.data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              return arenaEmptyResult(bodyContext);
            }
          },
        ),
      ]),
    );
  }

  Widget arenaDetails(BuildContext context, Arenas arena) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: [
          arenaCarousel(context, arena),
          arenaHeader(context, arena),
          arenaDescription(context, arena),
          arenaFacilities(context, arena),
          arenaSchedule(context),
          arenaReviews(context, arena.reviews),
        ],
      ),
    );
  }

  Widget arenaReviews(BuildContext context, List<Review> reviews) {
    // return const Text("Reviews");
    // return
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Reseñas",
            style: CustomTextTheme.h2(context),
          ),
          Container(
            width: double.infinity,
            height: 120,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                for (var review in reviews) arenaReviewCard(context, review),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget arenaReviewCard(BuildContext context, Review review) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
          color: CustomColors.secondaryLight,
          borderRadius: BorderRadius.circular(8)),
      width: MediaQuery.of(context).size.width * 0.7,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "User Name",
                    style: CustomTextTheme.p200(
                        context, CustomColors.secondaryDark,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(DateFormat.yMMMMd("en_US").format(review.date)),
                ],
              ),
            ),
            Text(
              review.content,
              // overflow: TextOverflow.ellipsis,
              textWidthBasis: TextWidthBasis.parent,
              style: CustomTextTheme.p100(context, CustomColors.secondaryDark),
            ),
          ],
        ),
      ),
    );
  }

  Widget arenaFacilities(BuildContext context, Arenas arena) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Facilidades",
            style: CustomTextTheme.h2(context),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var facilitiy in arena.facilities)
                Text(
                  "\u2022 ${facilitiy}",
                  style:
                      CustomTextTheme.p200(context, CustomColors.secondaryDark),
                )
            ],
          )
        ],
      ),
    );
  }

  Widget arenaDescription(BuildContext context, Arenas arena) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Descripción",
            style: CustomTextTheme.h2(context),
          ),
          Text(arena.description,
              style: CustomTextTheme.p200(context, CustomColors.secondaryDark))
        ],
      ),
    );
  }

  Widget arenaHeader(BuildContext context, Arenas arena) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            arena.title,
            style: CustomTextTheme.h1(context),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Container(
                  // margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  decoration: BoxDecoration(
                    color: CustomColors.secondaryLight,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    child: Text(
                      "JA",
                      style: CustomTextTheme.p200(
                          context, CustomColors.placeholderColor),
                    ),
                  ),
                ),
                Text(
                  " Jose Ayazo",
                  style:
                      CustomTextTheme.p300(context, CustomColors.secondaryDark),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Text("${arena.city} - ${arena.department}"),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                arena.sportId.name,
                style:
                    CustomTextTheme.p200(context, CustomColors.secondaryDark),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: CustomColors.primary500,
                  borderRadius: BorderRadius.circular(2.5),
                ),
                width: 10,
                height: 5,
              ),
              Text(
                arena.surfaceType,
                style:
                    CustomTextTheme.p200(context, CustomColors.secondaryDark),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: CustomColors.primary500,
                  borderRadius: BorderRadius.circular(2.5),
                ),
                width: 10,
                height: 5,
              ),
              Icon(
                Icons.star,
                color: CustomColors.warning,
              ),
              Text(
                AVGScore.getAVGScore(arena.reviews).toString(),
                style:
                    CustomTextTheme.p200(context, CustomColors.secondaryDark),
              ),
            ],
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
            child: const Text(
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

  Widget arenaSchedule(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Container(
          margin: const EdgeInsets.only(top: 16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Horarios",
              style: CustomTextTheme.h2(context),
            ),
            Text(
              "Seleccione el día y hora deseada para jugar.",
              style: CustomTextTheme.p200(context, CustomColors.secondaryDark),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16.0),
            ),
            if (!scheduleDay && !scheduleDefined)
              Container(
                  decoration: BoxDecoration(
                      color: CustomColors.secondaryLight,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0))),
                  child: CalendarDatePicker(
                      initialDate: initialDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2023),
                      onDateChanged: (value) {
                        setState(() {
                          scheduleDay = true;
                          initialDate = value;
                        });
                      }))
            else if (scheduleDay && !scheduleDefined)
              Container(
                  height: 400,
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          scheduleFree(
                              context, "08:00 AM - 09:00 AM", 1, setState),
                          scheduleFree(
                              context, "10:00 AM - 11:00 AM", 2, setState),
                          scheduleFree(
                              context, "01:00 PM - 02:00 PM", 3, setState),
                          scheduleFree(
                              context, "06:00 PM - 07:00 PM", 4, setState),
                          scheduleFree(
                              context, "10:00 PM - 11:00 PM", 5, setState),
                          TextButton(
                              style: CustomButtonStyle.solidButton(context,
                                  fullWidth: false, pd: 10),
                              onPressed: () {
                                setState(() {
                                  scheduleDay = false;
                                });
                              },
                              child: Text(
                                "Atras",
                                style: CustomTextTheme.p300(
                                    context, CustomColors.secondaryWhite),
                              ))
                        ]),
                  ))
            else if (scheduleDefined)
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: CustomColors.secondaryLight,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              initialDate.day.toString() +
                                  "/" +
                                  initialDate.month.toString() +
                                  "/" +
                                  initialDate.year.toString(),
                              style: CustomTextTheme.h2(context),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  schedule,
                                  style: CustomTextTheme.h2(context),
                                ),
                                Text(
                                  "Hora seleccionada",
                                  style: CustomTextTheme.p200(
                                      context, CustomColors.success),
                                ),
                              ],
                            )
                          ],
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          style: CustomButtonStyle.solidButton(context,
                              fullWidth: false, pd: 10),
                          onPressed: null,
                          child: Text(
                            "¡Listo!, reservar ahora",
                            style: CustomTextTheme.p300(
                                context, CustomColors.secondaryWhite),
                          )),
                      TextButton(
                          style: CustomButtonStyle.outlinedButton(context,
                              fullWidth: false, pd: 10),
                          onPressed: () {
                            setState(() {
                              scheduleDefined = false;
                              scheduleDay = true;
                            });
                          },
                          child: Text(
                            "Cambiar fecha",
                            style: CustomTextTheme.p300(
                                context, CustomColors.primary500),
                          )),
                    ],
                  )
                ],
              )
          ]));
    });
  }

  Widget scheduleFree(
      BuildContext context, String hour, int option, StateSetter setState) {
    return InkWell(
        onTap: () {
          setState(() {
            scheduleDefined = true;
            schedule = hour;
          });
        },
        child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
                color: CustomColors.secondaryLight,
                borderRadius: const BorderRadius.all(Radius.circular(8.0))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Disponible",
                      style: TextStyle(
                        color: CustomColors.success,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      hour,
                      style: CustomTextTheme.p300(
                          context, CustomColors.secondaryDark),
                    ),
                  ]),
            )));
  }
}
