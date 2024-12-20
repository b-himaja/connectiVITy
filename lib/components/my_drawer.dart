import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    FirebaseAuth.instance.signOut();
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [

            //drawer header
        DrawerHeader(
            child: Image.asset(
              'assets/vit.png',
              width: 90,
            ),
        ),

        const SizedBox(height:40),

        //home tile
        Padding(
          padding: const EdgeInsets.only(left:25.0),
          child: ListTile(
            leading: Icon(
                Icons.home,
                color: Theme.of(context).colorScheme.inversePrimary
            ),
            title: Text("H O M E"),
            onTap: (){
              Navigator.pop(context);
            },
          ),
        ),
        //profile tile

        Padding(
          padding: const EdgeInsets.only(left:25.0),
          child: ListTile(
            leading: Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.inversePrimary
            ),
            title: Text("P R O F I L E"),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context,'/profile_page');
            },
          ),
        ),

        //users tile

        Padding(
          padding: const EdgeInsets.only(left:25.0),
          child: ListTile(
            leading: Icon(
                Icons.group,
                color: Theme.of(context).colorScheme.inversePrimary
            ),
            title: Text("U S E R S"),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context,'/users_page');

            },
          ),
        ),
      ]
    ),

        //logout tile

        Padding(
          padding: const EdgeInsets.only(left:25.0, bottom: 25),
          child: ListTile(
            leading: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.inversePrimary
            ),
            title: Text("L O G O U T"),
            onTap: (){
              Navigator.pop(context);
              logout();
            },
          ),
        )
      ],
      ),
    );
  }
}
