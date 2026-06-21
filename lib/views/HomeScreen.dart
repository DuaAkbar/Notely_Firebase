import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/Controllers/AuthController.dart';
import 'package:notes_app/Controllers/NotesController.dart';
import 'package:notes_app/utils/Helpers.dart';
import 'package:notes_app/utils/colors.dart';
import 'package:notes_app/views/AddNotesScreen.dart';
import 'package:notes_app/views/NotesScreen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  Authcontroller authcontroller = Get.put(Authcontroller());
  bool isGridView = false;
  bool isOffline = false;
  StreamSubscription<List<ConnectivityResult>>? connectivitySubscription;
  TextEditingController noteSearchController = TextEditingController();
  final Notescontroller notescontroller = Get.put(Notescontroller());
  @override
  void initState() {
    super.initState();

    connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      result,
    ) {
      setState(() {
        isOffline = result.contains(ConnectivityResult.none);
      });
    });
  }

  @override
  void dispose() {
    connectivitySubscription?.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notely",
          style: TextStyle(
            fontSize: 22,
            color: colors.primary,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            authcontroller.logOut();
          },
          icon: Icon(Icons.logout_rounded),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isGridView = !isGridView;
              });
            },
            icon: Icon(isGridView ? Icons.list : Icons.grid_view),
          ),
        ],
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Text("Logged in as : ${FirebaseAuth.instance.currentUser!.email}"),
          SizedBox(height: 12),

          if (isOffline)
            Container(
              width: double.infinity,
              color: Colors.red,
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Text(
                "You're offline",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

          SizedBox(height: 12),

          Expanded(
            child: Obx(() {
              final filteredNotes =
                  notescontroller.notelymodel.where((note) {
                    final query = noteSearchController.text.toLowerCase();
                    return note.title.toLowerCase().contains(query) ||
                        note.preview.toLowerCase().contains(query);
                  }).toList();
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {});
                      },
                      controller: noteSearchController,
                      minLines: 1,
                      maxLines: 2,
                      maxLength: 50,
                      decoration: InputDecoration(
                        counterText: '',
                        label: Text(
                          "Search Note!",
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: colors.secondary,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(),

                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await Future.delayed(Duration(seconds: 1));
                      },
                      child:
                          isGridView
                              ? GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1.0,
                                    ),

                                itemCount: filteredNotes.length,
                                itemBuilder: (context, index) {
                                  final note = filteredNotes[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(() => NotesScreen(note: note));
                                    },
                                    child: Card(
                                      color: hexToColor(note.color),
                                      margin: EdgeInsets.all(12),
                                      elevation: 4,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    note.title,
                                                    style: TextStyle(
                                                      fontFamily: 'Nunito',
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: colors.primary,
                                                    ),
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    Helpers.showConfirmationDialogue(
                                                      "Are you sure?",
                                                      "This action will delete your note",
                                                      () {
                                                        notescontroller
                                                            .deleteNotes(
                                                              note.id!,
                                                            );
                                                      },
                                                    );
                                                  },
                                                  icon: Icon(
                                                    Icons.delete_outline_sharp,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            Text(
                                              note.preview,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: 'Nunito',
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              note.date,
                                              style: TextStyle(
                                                fontFamily: 'Nunito',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: colors.primary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                              : ListView.builder(
                                itemCount: filteredNotes.length,
                                itemBuilder: (context, index) {
                                  final note = filteredNotes[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(() => NotesScreen(note: note));
                                    },
                                    child: Card(
                                      color: hexToColor(note.color),
                                      margin: EdgeInsets.all(12),
                                      elevation: 4,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    note.title,
                                                    style: TextStyle(
                                                      fontFamily: 'Nunito',
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: colors.primary,
                                                    ),
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    Helpers.showConfirmationDialogue(
                                                      "Are you sure?",
                                                      "This action will delete your note",
                                                      () {
                                                        notescontroller
                                                            .deleteNotes(
                                                              note.id!,
                                                            );
                                                      },
                                                    );
                                                  },
                                                  icon: Icon(
                                                    Icons.delete_outline_sharp,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            Text(
                                              note.preview,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: 'Nunito',
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              note.date,
                                              style: TextStyle(
                                                fontFamily: 'Nunito',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: colors.primary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddNotesScreen());
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Icon(Icons.add, size: 25),
      ),
    );
  }
}
