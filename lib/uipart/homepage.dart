// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherfinal/apiservices/apiservices.dart';

class Homepage1 extends StatefulWidget {
  const Homepage1({super.key});

  @override
  State<Homepage1> createState() => _Homepage1State();
}

class _Homepage1State extends State<Homepage1> {
  @override
  void initState() {
    weatherservices;

    lodeState();

    fetchdata();
    super.initState();
  }

  final TextEditingValue text = TextEditingValue();
  final Apiservices weatherservices = Apiservices();

  List<String> citys = [];
  Map<String, dynamic>? weatherdata;
  String city = "auto:ip";

  Future<void> fetchdata() async {
    try {
      final fetchweatherdata = await weatherservices.currentweather(city);
      setState(() {
        weatherdata = fetchweatherdata;
      });
    } catch (e) {
      // print(e);
    }
  }

  Future<void> lodeState() async {
    final stateNames = await weatherservices.loadJsonData();
    setState(() {
      citys = stateNames;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(221, 62, 88, 98),
        body: SingleChildScrollView(
          child: weatherdata == null
              ? const Center(child: CircularProgressIndicator())
              : (weatherdata?["error"] != null &&
                      weatherdata?["error"]["code"] == 1006)
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.menu,
                                      color: Colors.white,
                                    )),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 20.0),
                                    child: Autocomplete<String>(
                                      optionsBuilder:
                                          (TextEditingValue textEditingValue) {
                                        // If the input is empty, return an empty list
                                        if (textEditingValue.text.isEmpty) {
                                          return const Iterable<String>.empty();
                                        }
                                        // Filter city names based on the input text
                                        return citys.where((city) => city
                                            .toLowerCase()
                                            .contains(textEditingValue.text
                                                .toLowerCase()));
                                      },
                                      onSelected: (String selection) {
                                        city = selection;
                                        fetchdata();
                                      },
                                      fieldViewBuilder: (context, controller,
                                          focusNode, onFieldSubmitted) {
                                        return TextField(
                                          controller: controller,
                                          focusNode: focusNode,
                                          decoration: InputDecoration(
                                            labelText: "Search City",
                                            border: OutlineInputBorder(),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      city = "auto:ip";
                                      fetchdata();
                                    },
                                    icon: const Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    )),
                              ]),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "City not found",
                            style: GoogleFonts.roboto(color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  : Column(children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.menu,
                                        color: Colors.white,
                                      )),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 20.0),
                                      child: Autocomplete<String>(
                                        optionsBuilder: (TextEditingValue
                                            textEditingValue) {
                                          // If the input is empty, return an empty list
                                          if (textEditingValue.text.isEmpty) {
                                            return const Iterable<
                                                String>.empty();
                                          }
                                          // Filter city names based on the input text
                                          return citys.where((city) => city
                                              .toLowerCase()
                                              .contains(textEditingValue.text
                                                  .toLowerCase()));
                                        },
                                        onSelected: (String selection) {
                                          city = selection;
                                          fetchdata();
                                        },
                                        fieldViewBuilder: (context, controller,
                                            focusNode, onFieldSubmitted) {
                                          return TextField(
                                            controller: controller,
                                            focusNode: focusNode,
                                            decoration: InputDecoration(
                                              labelText: "Search City",
                                              border: OutlineInputBorder(),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        city = "auto:ip";
                                        fetchdata();
                                      },
                                      icon: const Icon(
                                        Icons.location_pin,
                                        color: Colors.white,
                                      )),
                                ]),
                            Text(
                              "${weatherdata?["location"]["name"]}  , ${weatherdata?["location"]["country"]}",
                              style: GoogleFonts.roboto(
                                  fontSize: 30, color: Colors.white),
                            ),
                            Text(
                              "${weatherdata?["location"]["localtime"]}",
                              style: GoogleFonts.roboto(
                                  fontSize: 30, color: Colors.white),
                            ),
                          ]),
                      const SizedBox(
                        height: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.network(
                                height: 50,
                                width: 50,
                                "http:${weatherdata?["current"]["condition"]["icon"]}"),
                            Text(
                              "${weatherdata?["current"]["condition"]["text"]}",
                              style: GoogleFonts.roboto(
                                  fontSize: 36, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${weatherdata?["current"]["temp_c"]}\u00B0",
                                style: GoogleFonts.poppins(
                                    fontSize: 150, color: Colors.amber),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Text(
                                "${weatherdata?["current"]["feelslike_c"]}\u2103",
                                style: GoogleFonts.roboto(
                                    fontSize: 25, color: Colors.white),
                              ),
                              Text(
                                "${weatherdata?["current"]["windchill_c"]}\u2103",
                                style: GoogleFonts.roboto(
                                    fontSize: 25, color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "7Days Forecast",
                              style: GoogleFonts.roboto(
                                  fontSize: 30, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: SizedBox(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: weatherdata?['forecast']
                                        ['forecastday']
                                    .length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: 130,
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            side: const BorderSide(
                                                color: Colors.white, width: 1),
                                          ),
                                          color: const Color.fromARGB(
                                              255, 42, 48, 68),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${weatherdata?['forecast']['forecastday'][index]['date']}",
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 15,
                                                      color: Colors.white),
                                                ),
                                                Image.network(
                                                    "http:${weatherdata?['forecast']['forecastday'][index]['day']['condition']['icon']}"),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "${weatherdata?['forecast']['forecastday'][index]['day']['maxtemp_c']}\u2103",
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 15,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                                  );
                                })),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: SingleChildScrollView(
                          child: Container(
                              height: 170,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: weatherdata?['forecast']
                                          ['forecastday']
                                      .length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: 200,
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Card(
                                            elevation: 5,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              side: const BorderSide(
                                                  color: Colors.white,
                                                  width: 1),
                                            ),
                                            color: Colors.transparent,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            "${weatherdata?['forecast']['forecastday'][index]['date']}",
                                                            style: GoogleFonts
                                                                .roboto(
                                                                    fontSize:
                                                                        15,
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                        ]),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "${weatherdata?['forecast']['forecastday'][index]['date']}",
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                        Text(
                                                          "${weatherdata?['forecast']['forecastday'][index]['day']['maxtemp_c']}\u2103",
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: 45,
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                        Image.network(
                                                          "http:${weatherdata?['forecast']['forecastday'][index]['day']['condition']['icon']}",
                                                        )
                                                      ],
                                                    ),
                                                  ]),
                                            ),
                                          )),
                                    );
                                  })),
                        ),
                      ),
                    ]),
        ));
  }
}
