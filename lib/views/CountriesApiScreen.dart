import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/Controllers/CountryController.dart';

class Countriesapiscreen extends StatefulWidget {
  const Countriesapiscreen({super.key});

  @override
  State<Countriesapiscreen> createState() => _CountriesapiscreenState();
}

class _CountriesapiscreenState extends State<Countriesapiscreen> {
  TextEditingController countrySearch = TextEditingController();
  Countrycontroller countrycontroller = Get.put(Countrycontroller());
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Around the World",
          style: TextStyle(
            fontSize: 22,
            color: colors.primary,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: Obx(() {
        final filterCountry =
            countrycontroller.countryList.where((country) {
              final query = countrySearch.text.toLowerCase();
              return country.name.toLowerCase().contains(query) ||
                  country.capital.toLowerCase().contains(query);
            }).toList();

        if (countrycontroller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: TextField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: countrySearch,
                minLines: 1,
                maxLines: 2,
                maxLength: 50,
                decoration: InputDecoration(
                  counterText: '',
                  label: Text(
                    "Search Country / Capital!",
                    style: TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: colors.secondary, width: 1.0),
                  ),
                ),
              ),
            ),

            SizedBox(),
            if (filterCountry.isEmpty)
              Expanded(child: Center(child: Text("No data Found")))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: filterCountry.length,
                  itemBuilder: (context, index) {
                    final country = filterCountry[index];
                    return Card(
                      child: ListTile(
                        title: Text(
                          country.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'DancingScript',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          "Capital: ${country.capital}",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        );
      }),
    );
  }
}
