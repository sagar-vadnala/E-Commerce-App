// // screens/login_screen.dart
// import 'package:e_commerce_app/provider/auth-provider.dart';
// import 'package:e_commerce_app/screens/home_screen.dart';
// import 'package:e_commerce_app/widgets/my_button.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _usernameController,
//               decoration: InputDecoration(labelText: 'Username'),
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration: InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 await authProvider.login(
//                   _usernameController.text,
//                   _passwordController.text,
//                 );

//                 if (authProvider.isAuthenticated) {
//                   Navigator.pushReplacementNamed(context, '/home');
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Login failed')),
//                   );
//                 }
//               },
//               child: Text('Login'),
//             ),
//             SizedBox(height: 20,),
//             MyButton(text: "Login Later",
//             onTap: () {
//               Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>  HomeScreen(),
//                       ),
//                     );
//             },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:e_commerce_app/screens/home_screen.dart';
import 'package:e_commerce_app/widgets/my_button.dart';
import 'package:e_commerce_app/widgets/my_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {

  LoginScreen({super.key,});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmpasswordController =
      TextEditingController();

  //register method
  void register() {}

    //get auth service
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Icon(
                Icons.message,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),
          
              const SizedBox(
                height: 50,
              ),
              //welcome back message
              Text(
                "Let's create an account for you",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary, fontSize: 16),
              ),
          
              const SizedBox(
                height: 50,
              ),
          
              //email Text field
              MyTextField(
                hintText: 'Email',
                obscureText: false,
                controller: _emailController,
              ),
              const SizedBox(
                height: 10,
              ),
              //password text field
              MyTextField(
                hintText: "Password",
                obscureText: true,
                controller: _passwordController,
              ),
              //confirm password
              const SizedBox(
                height: 10,
              ),
              //confirm password text field
              MyTextField(
                hintText: "Confirm Password",
                obscureText: true,
                controller: _confirmpasswordController,
              ),
              const SizedBox(
                height: 25,
              ),
              //login button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: MyButton(
                  text: 'Register',
                  onTap: () => register,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              //register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  GestureDetector(
                    child: Text(
                      "Login now",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  )
                ],
              ),
               Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20,top: 10),
                child: MyButton(
                  text: 'Login later(Guest)',
                  onTap: () {
                    Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
