import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/components/my_drawer.dart';
import 'package:untitled/components/my_list_tile.dart';
import 'package:untitled/components/my_post_button.dart';
import 'package:untitled/components/my_textfield.dart';
import 'package:untitled/database/firestore.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final FirestoreDatabase database = FirestoreDatabase();
  final TextEditingController newPostController = TextEditingController();

  void postMessage() {
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
    }
    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("F O R U M"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: database.getPostStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final posts = snapshot.data!.docs;

                    if (snapshot.data == null || posts.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(25),
                          child: Text("No current posts"),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];

                        String message = post['PostMessage'];
                        String userEmail = post['UserEmail'];

                        return MyListTile(
                          title: message,
                          subTitle: userEmail,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 30,
            left: 15,
            right: 15,
            child: Row(
              children: [
                Expanded(
                  child: MyTextField(
                    hintText: "Message..",
                    obscureText: false,
                    controller: newPostController,
                  ),
                ),
                const SizedBox(width: 10),
                PostButton(
                  onTap: postMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
