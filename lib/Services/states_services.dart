import 'dart:convert';

import 'package:flutter_covid19_app/Model/WorldStatesModel.dart';
import 'package:flutter_covid19_app/Services/Utilities/app_url.dart';
import 'package:flutter_covid19_app/View/Countries_list.dart';
import 'package:http/http.dart' as http;

class StateServices{
  Future<WorldStatesModel> fetchWorldSatesRecords () async{
    final response = await http.get(
      Uri.parse(AppUrl.baseUrl + AppUrl.world),
    );
    if (response.statusCode == 200){

      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    }else{
      throw Exception('Error');
    }


  }


  Future<List<dynamic>> countriesListApi () async{
    var data;
    final response = await http.get(
      Uri.parse(AppUrl.baseUrl + AppUrl.countries),
    );
    if (response.statusCode == 200){

      data = jsonDecode(response.body);
      return data;
    }else{
      throw Exception('Error');
    }


  }
}