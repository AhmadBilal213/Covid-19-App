import 'package:flutter/material.dart';
import 'package:flutter_covid19_app/Model/WorldStatesModel.dart';
import 'package:flutter_covid19_app/Services/states_services.dart';
import 'package:flutter_covid19_app/View/Countries_list.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorldStatsScreen extends StatefulWidget {
  const WorldStatsScreen({super.key});

  @override
  State<WorldStatsScreen> createState() => _WorldStatsScreenState();
}

class _WorldStatsScreenState extends State<WorldStatsScreen> with TickerProviderStateMixin{


  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              FutureBuilder(
                  future: stateServices.fetchWorldSatesRecords(),
                  builder: (context, AsyncSnapshot<WorldStatesModel> snapshot){

                    if(!snapshot.hasData){
                      return Expanded(
                        flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 50,
                            controller: _controller,
                          )
                      );
                    }else{
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total": double.parse(snapshot.data!.cases!.toString()),
                              "Recovered": double.parse(snapshot.data!.cases!.toString()),
                              "Deaths": double.parse(snapshot.data!.cases!.toString()),
                            },
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true,
                            ),
                            chartRadius: MediaQuery.of(context).size.width / 3.2,
                            legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left,),
                            animationDuration: const Duration(milliseconds: 800),
                            chartType: ChartType.ring,
                            colorList: colorList,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.06),
                            child: Card(
                                child: Column(
                                    children: [
                                      ReuseableRow(title: 'Total', value: snapshot.data!.cases.toString()),
                                      ReuseableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                                      ReuseableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                                      ReuseableRow(title: 'Active', value: snapshot.data!.active.toString()),
                                      ReuseableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                                      ReuseableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                                      ReuseableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),

                                    ]
                                )
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
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
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(
                                child: Text('Track Countries'),
                              ),
                            ),
                          )
                        ],
                      );
                    }
                  }),

            ],
          ),
        ),
      ));
  }
}


class ReuseableRow extends StatelessWidget {
  String title, value;
  ReuseableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(),
        ],
      ),
    );
  }
}
