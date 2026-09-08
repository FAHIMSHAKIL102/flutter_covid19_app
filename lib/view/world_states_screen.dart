import 'package:flutter/material.dart';
import 'package:flutter_covid19_app/model/world_states_model.dart';
import 'package:flutter_covid19_app/services/states_services.dart';
import 'package:flutter_covid19_app/view/countries_list_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: Duration(seconds: 3),
  )..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final List<Color> colorList = [
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.heightOf(context);
    double w = MediaQuery.widthOf(context);

    StatesServices statesServices = StatesServices();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: h * .01),
              FutureBuilder(
                future: statesServices.fetchWorldStatesRecords(),
                builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            'Total': double.parse(
                              snapshot.data!.cases.toString(),
                            ),
                            'Recovered': double.parse(
                              snapshot.data!.recovered.toString(),
                            ),
                            'Deaths': double.parse(
                              snapshot.data!.deaths.toString(),
                            ),
                          },
                          chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                          chartRadius: w / 2,
                          legendOptions: LegendOptions(
                            legendPosition: LegendPosition.left,
                          ),
                          animationDuration: Duration(seconds: 2),
                          chartType: ChartType.ring,
                          colorList: colorList,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: h * .06),
                          child: Card(
                            child: Column(
                              children: [
                                DescriptionRow(
                                  title: 'Total Cases',
                                  value: snapshot.data!.cases.toString(),
                                ),
                                DescriptionRow(
                                  title: 'Deaths',
                                  value: snapshot.data!.deaths.toString(),
                                ),
                                DescriptionRow(
                                  title: 'Active',
                                  value: snapshot.data!.active.toString(),
                                ),
                                DescriptionRow(
                                  title: 'Critical',
                                  value: snapshot.data!.critical.toString(),
                                ),
                                DescriptionRow(
                                  title: 'Recovered',
                                  value: snapshot.data!.recovered.toString(),
                                ),
                                DescriptionRow(
                                  title: 'Today Deaths',
                                  value: snapshot.data!.todayDeaths.toString(),
                                ),
                                DescriptionRow(
                                  title: 'Today Recovered',
                                  value: snapshot.data!.todayRecovered
                                      .toString(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CountriesListScreen(),
                              ),
                            );
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'Track Countries',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Expanded(
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50,
                        controller: _controller,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DescriptionRow extends StatelessWidget {
  final String title, value;
  const DescriptionRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(title, style: TextStyle(fontSize: 16)),
              Text(value),
            ],
          ),
          SizedBox(height: 5),
          Divider(),
        ],
      ),
    );
  }
}
