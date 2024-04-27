// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mp5/Providers/UserProvider.dart';
import 'package:provider/provider.dart';

import '../Models/User.dart';
import '../Requests/GithubRequest.dart';

class FollowerPage extends StatefulWidget {
  const FollowerPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FollowerPageState createState() => _FollowerPageState();
}

class _FollowerPageState extends State<FollowerPage> {
  late User user;
  List<User> users = [];

  @override
  Widget build(BuildContext context) {
    setState(() {
      user = Provider.of<UserProvider>(context).getUSer();

      Github(user.login).fetchFollowers().then((follower) {
        Iterable list = json.decode(follower.body);
        setState(() {
          users = list.map((model) => User.fromJson(model)).toList();
        });
      });
    });

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.grey,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Colors.white,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(user.avatar_url),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      user.login,
                      style: const TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
              systemOverlayStyle: SystemUiOverlayStyle.dark,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: 600,
                  // ignore: unnecessary_null_comparison
                  child: users != null
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.all(15),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Color.fromARGB(
                                              255, 238, 238, 238)))),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 60,
                                        height: 60,
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              users[index].avatar_url),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        users[index].login,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey[700]),
                                      ),
                                    ],
                                  ),
                                  const Text(
                                    'Follower',
                                    style: TextStyle(color: Colors.blue),
                                  )
                                ],
                              ),
                            );
                          },
                        )
                      : const Align(child: Text('Data is loading ...')),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
