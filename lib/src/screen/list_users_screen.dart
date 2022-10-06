import 'package:chat_test/src/controllers/user_ctrl.dart';
import 'package:chat_test/src/models/user.dart';
import 'package:chat_test/src/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListUserScreen extends StatefulWidget {
  const ListUserScreen({super.key});

  @override
  State<ListUserScreen> createState() => _ListUserScreenState();
}

class _ListUserScreenState extends State<ListUserScreen> {
  int? _edad, _id;
  String? _nombre, _correo;
  List users = [];

  Future<void> getInfoUser() async {
    final prefs = await SharedPreferences.getInstance();
    _edad = prefs.getInt('edad');
    _id = prefs.getInt('id');
    _nombre = prefs.getString('nombre');
    _correo = prefs.getString('correo');
  }

  Future getListUsers() async {
    final usersCtrl = UserCtrl();
    final list = await usersCtrl.get(context);
    users = list.data.map((val) => User.fromJson(val)).toList();

    setState(() {});
  }

  @override
  void initState() {
    getInfoUser();
    getListUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Hola, ',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: _nombre ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Tienes $_edad años',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: double.infinity,
              child: Divider(),
            ),
            SizedBox(
              height: size.height * 0.8,
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: users.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      border: Border.all(
                        width: 1,
                        color: const Color(0xFFDBDBDB),
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${users[index].nombre}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileScreen(id: 1),
                                ),
                              ),
                              child: const Icon(
                                Icons.person,
                                size: 14,
                              ),
                            ),
                            const SizedBox(width: 5),
                            ElevatedButton(
                                onPressed: () {},
                                child: const Icon(
                                  Icons.chat,
                                  size: 14,
                                )),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
