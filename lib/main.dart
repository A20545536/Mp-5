import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mp5/Pages/FollowersPage.dart';
import 'package:mp5/Pages/FollowingPage.dart';
import 'package:mp5/Providers/UserProvider.dart';

void main() {
  runApp(ChangeNotifierProvider<UserProvider>(
    create: (context) => UserProvider(),
    child: const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StateHomePage createState() => _StateHomePage();
}

class _StateHomePage extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  void _getUser() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (_controller.text == '') {
      userProvider.setMessage('Please Enter your username');
    } else {
      userProvider.fetchUser(_controller.text).then((value) {
        if (value) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const FollowingPage()));
        } else {
          userProvider.setMessage('You must be a Github user to login');
        }
      });
    }
  }

  void _getUser1() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (_controller.text == '') {
      userProvider.setMessage('Please Enter your username');
    } else {
      userProvider.fetchUser(_controller.text).then((value) {
        if (value) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const FollowerPage()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 100,
                ),
                const SizedBox(
                  width: 80,
                  height: 80,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                        'https://icon-library.net/images/github-icon-png/github-icon-png-29.jpg'),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Github",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 150,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(.1)),
                  child: TextField(
                    onChanged: (value) {
                      context.read<UserProvider>().setMessage(null);
                    },
                    controller: _controller,
                    enabled: !context.watch<UserProvider>().isLoading(),
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        errorText:
                            Provider.of<UserProvider>(context).getMessage(),
                        border: InputBorder.none,
                        hintText: "Github username",
                        hintStyle: const TextStyle(color: Colors.grey)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  padding: const EdgeInsets.all(20),
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: context.watch<UserProvider>().isLoading()
                      ? null
                      : _getUser,
                  child: context.watch<UserProvider>().isLoading()
                      ? const CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          strokeWidth: 2,
                        )
                      : const Text(
                          'Get Your Following Now',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  padding: const EdgeInsets.all(20),
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: context.watch<UserProvider>().isLoading()
                      ? null
                      : _getUser1,
                  child: context.watch<UserProvider>().isLoading()
                      ? const CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          strokeWidth: 2,
                        )
                      : const Text(
                          'Get Your Followers Now',
                          style: TextStyle(color: Colors.white),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
