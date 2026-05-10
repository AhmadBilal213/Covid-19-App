import 'package:flutter/material.dart';
import 'package:flutter_covid19_app/View/World_Stat.dart';

class DetailScreen extends StatefulWidget {
  String name;
  String image;
  int totalcases , totalDeaths , totalRecovered , active , critical , todayRecovered , todayDeaths;
  DetailScreen({
    super.key,
    required this.name,
    required this.image,
    required this.totalcases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.todayDeaths,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                      ReuseableRow(title: 'Cases', value: widget.totalcases.toString()),
                      ReuseableRow(title: 'Deaths', value: widget.totalDeaths.toString()),
                      ReuseableRow(title: 'Recovered', value: widget.totalRecovered.toString()),
                      ReuseableRow(title: 'Active', value: widget.active.toString()),
                      ReuseableRow(title: 'Critical', value: widget.critical.toString()),
                      ReuseableRow(title: 'Today Deaths', value: widget.todayDeaths.toString()),
                      ReuseableRow(title: 'Today Recovered', value: widget.todayRecovered.toString()),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),

                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
            ));
  }
}
