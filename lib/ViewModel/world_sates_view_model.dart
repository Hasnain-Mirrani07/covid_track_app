import 'dart:convert';
import 'package:covid_tracker/Model/countries_list_model.dart';
import 'package:covid_tracker/Model/world_states.dart';
import 'package:covid_tracker/ViewModel/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

class WorldStatesViewModel {
  Future<WorldStatesModel> fetchWorldRecords() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  List<CountriesListModel> countrylist = [];
  Future<List<CountriesListModel>> countriesListApi() async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    print(response.statusCode.toString());
    print(data);
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      for (Map i in data) {
        countrylist
            .add(CountriesListModel(i['countryInfo']['flag'], i['country']));
      }
      return countrylist;
    } else {
      throw Exception('Error');
    }
  }
}
