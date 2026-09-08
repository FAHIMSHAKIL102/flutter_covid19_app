import 'package:flutter/material.dart';
import 'package:flutter_covid19_app/services/states_services.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: statesServices.countriesListApi(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade100,
                        child: ListTile(
                          leading: Container(
                            height: 50,
                            width: 50,
                            color: Colors.white,
                          ),
                          title: Container(
                            height: 10,
                            width: 89,
                            color: Colors.white,
                          ),
                          subtitle: Container(
                            height: 10,
                            width: 89,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String name = snapshot.data![index]['country'];
                      if (searchController.text.isEmpty) {
                        return Column(
                          children: [
                            ListTile(
                              leading: Image(
                                height: 50,
                                width: 50,
                                image: NetworkImage(
                                  snapshot.data![index]['countryInfo']['flag'],
                                ),
                              ),
                              title: Text(snapshot.data![index]['country']),
                            ),
                          ],
                        );
                      } else if (name.toLowerCase().contains(
                        searchController.text.toLowerCase(),
                      )) {
                        return Column(
                          children: [
                            ListTile(
                              leading: Image(
                                height: 50,
                                width: 50,
                                image: NetworkImage(
                                  snapshot.data![index]['countryInfo']['flag'],
                                ),
                              ),
                              title: Text(snapshot.data![index]['country']),
                            ),
                          ],
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
