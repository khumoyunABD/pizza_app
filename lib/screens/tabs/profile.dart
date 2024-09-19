import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Material(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                // Profile Picture and Name
                Center(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                          'assets/images/user_profile.png',
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        '******',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        user!.email!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // Divider to separate sections
                const Divider(),
                // Profile Information
                const ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    'Name',
                  ),
                  subtitle: Text(
                    '******',
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text('Email'),
                  subtitle: Text(user.email!),
                ),
                const Divider(),
                const ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Phone'),
                  subtitle: Text(
                    '******',
                  ),
                ),
                const Divider(),
                const ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text('Address'),
                  subtitle: Text(
                    '******',
                  ),
                ),
                const Divider(),
                const ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  subtitle: Text('Account, Privacy, Security'),
                ),
                const Divider(),
                const ListTile(
                  leading: Icon(Icons.help),
                  title: Text('Help & Support'),
                  subtitle: Text('FAQ, Contact Us'),
                ),
                const Divider(),
                // Additional Information
                const ListTile(
                  leading: Icon(Icons.info),
                  title: Text('About'),
                  subtitle: Text('App version 1.0.0'),
                ),
                const Divider(),
                // Additional Information
                ListTile(
                  onTap: () {
                    context.read<SignInBloc>().add(SignOutRequired());
                  },
                  leading: const Icon(Icons.logout),
                  title: const Text('Log out'),
                  //subtitle: Text('App version 1.0.0'),
                ),
                // const SizedBox(
                //   height: 30,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
