import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movieflutter/SqfLitelocalstorage/NoteDbHelper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../DetailScreen/checker.dart';

class FavoriteMovies extends StatefulWidget {
  const FavoriteMovies({super.key});

  @override
  State<FavoriteMovies> createState() => _FavoriteMoviesState();
}

class _FavoriteMoviesState extends State<FavoriteMovies> {
  // int svalue = 1;

  @override
  void initState() {
    super.initState();
  }


  // sortByChecker(int sortvalue) {
  //   // if (userId != null) {
  //   print('user id: $userId');
  //   if (sortvalue == 1) {
  //     return FavMovielist().queryAllSortedDate(userId!);
  //   } else if (sortvalue == 2) {
  //     return FavMovielist().queryAllSorted(userId!);
  //   } else if (sortvalue == 3) {
  //     return FavMovielist().queryAllSortedRating(userId!);
  //   }
  //   // }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(18, 18, 18, 0.5),
      appBar: AppBar(
        elevation: MediaQuery.of(context).size.height * 0.06,
        backgroundColor: const Color.fromRGBO(40, 47, 50, 1.0),
        title: const Text(
          'Favorite Movies',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.07,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: [
              // const Padding(
              //   padding: EdgeInsets.all(8.0),
              //   child: Text(
              //     'Sort By',
              //     style: TextStyle(color: Colors.white),
              //   ),
              // ),
              // DropdownButton(
              //   iconEnabledColor: Colors.white,
              //   focusColor: Colors.white,
              //   iconDisabledColor: Colors.white,
              //   dropdownColor: const Color.fromRGBO(18, 18, 18, 0.5),
              //   value: svalue,
              //   items: const [
              //     DropdownMenuItem(
              //       value: 1,
              //       child: Text('View All',
              //           style: TextStyle(color: Colors.white)),
              //     ),
              //     DropdownMenuItem(
              //       value: 2,
              //       child: Text('Sort by Name',
              //           style: TextStyle(color: Colors.white)),
              //     ),
              //     DropdownMenuItem(
              //       value: 3,
              //       child: Text('Sort by Rating',
              //           style: TextStyle(color: Colors.white)),
              //     ),
              //   ],
              //   onChanged: (value) {
              //     setState(() {
              //       svalue = value as int;
              //     });
              //   },
              // ),
              //     ],
              //   ),
              // ),
              // Center(
              //   child: CircularProgressIndicator(
              //     color: Colors.amber,
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  //query all data from database and show in listview builder here
                  child: FutureBuilder(
                    future: FavMovielist().queryAll(),
                    builder: (context,
                        AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                                background: Container(
                                  color: Colors.red,
                                  child: const Icon(Icons.delete),
                                ),
                                onDismissed: (direction) {
                                  FavMovielist()
                                      .delete(snapshot.data![index]['id']);
                                  Fluttertoast.showToast(
                                      msg: "Deleted from Favorite successfully",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor:
                                      const Color.fromRGBO(18, 18, 18, 1),
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                },
                                key: UniqueKey(),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return descriptioncheckui(
                                            snapshot.data![index]['tmdbid']
                                                .toString(),
                                            snapshot.data![index]['tmdbtype']
                                                .toString());
                                      },
                                    ));
                                  },
                                  child: Card(
                                    child: ListTile(
                                      tileColor:
                                      const Color.fromRGBO(24, 24, 24, 1),
                                      textColor: Colors.white,
                                      title:
                                      Text(snapshot.data![index]['tmdbname']),
                                      subtitle: Row(children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: 20,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(snapshot.data![index]['tmdbrating'])
                                      ]),
                                      trailing:
                                      Text(snapshot.data![index]['tmdbtype']),
                                    ),
                                  ),
                                ));
                          },
                        );
                      } else {
                        return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(120.0),
                              child: Column(children: [
                                Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                  size: 120,
                                ),
                                Text(
                                  'No Favorites yet',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 26,
                                  ),
                                ),
                              ]),
                            )
                          // CircularProgressIndicator(
                          //   color: Color(0xff34e3c4),
                          // ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }
}