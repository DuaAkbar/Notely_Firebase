import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/services/navigationService.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Navigationservice navigationservice = Get.put(Navigationservice()); 
  @override
  Widget build(BuildContext context) {
    return Obx(()=>
      Scaffold(
        body: navigationservice.pages[navigationservice.currentPage.value],
         bottomNavigationBar: NavigationBar(
            height: 60,
            selectedIndex: navigationservice.currentPage.value,
            onDestinationSelected: (value) {
              navigationservice.updateindex(value);
            },
            destinations: [
              NavigationDestination( icon: Icon(Icons.home), label: ""),
              NavigationDestination(icon: Icon(Icons.public), label: ""),
            ],
          ),
      ),
    );
  }
}