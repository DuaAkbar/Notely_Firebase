import 'dart:convert';

import 'package:get/get.dart';
import 'package:notes_app/models/CountryModel.dart';
import 'package:http/http.dart' as http;

class Countrycontroller extends GetxController {
  RxBool isLoading = true.obs;
  RxList<CountryModel> countryList = <CountryModel>[].obs;

  @override
  void onInit() {
    fetchCountries();
    super.onInit();
  }

  void fetchCountries() async {
    try {
      isLoading(true);
      final url = Uri.parse(
        "https://countriesnow.space/api/v0.1/countries/capital",
      );
      final response = await http.get(url);
      print("api response status:${response.statusCode}");
      print("response body : ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        final List<dynamic> countries = jsonData['data'];

        final excludedCountry = ['Israel', 'Jerusalem'];
        countryList.value =
            countries.map((c) => CountryModel.fromJson(c)).where((country)=> !excludedCountry.contains(country.name)).toList();
      } else {
        print(" Failed to load data");
      }
    } catch (e) {
      print("${e}");
    } finally {
      isLoading.value = false;
    }
  }
}
