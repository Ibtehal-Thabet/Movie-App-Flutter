import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:movieflutter/Authentication/login_screen.dart';
import 'package:movieflutter/SectionHomeUi/FavoriteList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class drawerfunc extends StatefulWidget {
  const drawerfunc({
    super.key,
  });

  @override
  State<drawerfunc> createState() => _drawerfuncState();
}

class _drawerfuncState extends State<drawerfunc> {
  File? _image;

  Future<void> SelectImage() async {
    // final pickedfile =
    //     await ImagePicker().(source: ImageSource.gallery);
    // if (pickedfile != null) {
    //   CroppedFile? cropped = await ImageCropper().cropImage(
    //     sourcePath: pickedfile.path,
    //     aspectRatioPresets: [
    //       CropAspectRatioPreset.square,
    //       CropAspectRatioPreset.ratio3x2,
    //       CropAspectRatioPreset.original,
    //       CropAspectRatioPreset.ratio4x3,
    //       CropAspectRatioPreset.ratio16x9
    //     ],
    //   );
    //   SharedPreferences sp = await SharedPreferences.getInstance();
    //   sp.setString('imagepath', cropped!.path);
    //   _image = cropped as File?;
    // } else {
    //   print('No image selected.');
    // }
  }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((sp) {
      setState(() {
        _image = File(sp.getString('imagepath')!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color.fromRGBO(18, 18, 18, 0.9),
        child: ListView(
          children: [
            DrawerHeader(
              child: Container(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await SelectImage();
                        //toast message
                        Fluttertoast.showToast(
                            msg: "Image Changed",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      },
                      child: _image == null
                          ? const CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage('asset/user.png'),
                            )
                          : CircleAvatar(
                              radius: 50,
                              backgroundImage: FileImage(_image!),
                            ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Welcome',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            listtilefunc('Home', Icons.home, ontap: () {
              //close drawer
              Navigator.pop(context);
            }),
            listtilefunc('Favorite', Icons.favorite, ontap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FavoriteMovies()));
            }),
            listtilefunc('Logout', Icons.exit_to_app_rounded, ontap: () async {
              //SystemNavigator.pop();
              final cloud = Supabase.instance.client;
              await cloud.auth.signOut();
              Get.off(LoginScreen());
            }),
          ],
        ),
      ),
    );
  }
}

Widget listtilefunc(String title, IconData icon, {Function? ontap}) {
  return GestureDetector(
    onTap: ontap as void Function()?,
    child: ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}
