import 'package:flutter/material.dart';
import 'package:flutter_covid19_app/view/world_states_screen.dart';

class DetailsScreen extends StatefulWidget {
   String name;
   String image;
   int totalCases;
   int totalDeaths;
   int totalRecovered;
   int active;
   int critical;
   int test;
   DetailsScreen({
    super.key,
    required this.name,
    required this.image,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.test,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        children: [
          Stack(
            alignment: .topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.heightOf(context) * .067,
                ),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.heightOf(context) * .06),
                      DescriptionRow(
                        title: 'Cases',
                        value: widget.totalCases.toString(),
                      ),
                      DescriptionRow(
                        title: 'Test',
                        value: widget.test.toString(),
                      ),
                      DescriptionRow(
                        title: 'Deaths',
                        value: widget.totalDeaths.toString(),
                      ),
                      DescriptionRow(
                        title: 'Critical',
                        value: widget.critical.toString(),
                      ),
                       DescriptionRow(
                        title: 'Total Recovered',
                        value: widget.totalRecovered.toString(),
                      ),
                      DescriptionRow(
                        title: 'Active',
                        value: widget.active.toString(),
                      ),
                      
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
