import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../utils/utils.dart';
import 'login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database =
      FirebaseDatabase.instance.reference().child('users');

  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    confirmPasswordController.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  String? _phone, _password;

  Widget _buildUserName() {
    return TextFormField(
      controller: fullNameController,
      decoration: InputDecoration(
        labelText: 'Full Name',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: appPrimaryColor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your name';
        }
        if (!RegExp(r"^[A-Za-z]+(?:\s+[A-Za-z]+)*\s*$").hasMatch(value)) {
          return 'Please enter a valid name';
        }
        return null;
      },
      onSaved: (value) {
        _phone = value!;
      },
    );
  }

  Widget _buildPhone() {
    return TextFormField(
      controller: phoneNumberController,
      decoration: InputDecoration(
        labelText: 'Phone',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: appPrimaryColor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your phone number';
        }
        if (!RegExp(r'^(\+92|0)?3\d{2}(-|\s)?\d{7}$').hasMatch(value)) {
          return 'Please enter a valid phone number';
        }
        return null;
      },
      onSaved: (value) {
        _phone = value!;
      },
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      controller: passwordController,
      obscureText: !_showPassword,
      decoration: InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: appPrimaryColor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _showPassword ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your password';
        }
        if (value.length < 6) {
          return 'Password should be at least 6 characters long.';
        }
        return null;
      },
      onSaved: (value) {
        _password = value!;
      },
    );
  }

  Widget _buildConfirmPassword() {
    return TextFormField(
      controller: confirmPasswordController,
      obscureText: !_showPassword,
      decoration: InputDecoration(
        labelText: 'Confirm Password',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: appPrimaryColor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _showPassword ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your password';
        }
        if (value.length < 6) {
          return 'Password should be at least 6 characters long.';
        }
        if (value != passwordController.text) {
          return 'Password does not match';
        }
        return null;
      },
      onSaved: (value) {
        _password = value!;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: appPrimaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 20.0),
            width: mediaQuery.size.width * 0.9,
            height: mediaQuery.size.height * 0.95,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      width: mediaQuery.size.width * 0.15,
                    ),
                    const SizedBox(width: 40),
                    // Expanded(
                    Text(
                      'خدا کا کلام',
                      style: TextStyle(
                        color: appPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                        fontSize: 50,
                      ),
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                    ),
                    // ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'توریت، زبور اور انجیل پر مبنی کورسز',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  width: mediaQuery.size.height * 0.5,
                  height: mediaQuery.size.height * 0.6,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: tSecondaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: tSecondaryColor,
                        spreadRadius: 5,
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  // child: Image.asset(
                  //   'assets/sun_logo.png',
                  //   width: mediaQuery.size.width * 0.2,
                  // ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Image.asset(
                        //   'assets/sun_logo.png',
                        //   width: mediaQuery.size.width * 0.2,
                        //   height: mediaQuery.size.height * 0.2,
                        // ),
                        // const Text(
                        //   'Log In',
                        //   // textDirection: TextDirection.ltr,
                        //   style: TextStyle(
                        //     fontSize: 18,
                        //     fontWeight: FontWeight.normal,
                        //   ),
                        //   textAlign: TextAlign.left,
                        // ),
                        // const SizedBox(height: 10),
                        const Text(
                          '  Please Sign Up to continue',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF707070),
                          ),
                        ),
                        const SizedBox(height: 03),
                        _buildUserName(),
                        const SizedBox(height: 10),
                        _buildPhone(),
                        const SizedBox(height: 10),
                        _buildPassword(),
                        const SizedBox(height: 10),
                        _buildConfirmPassword(),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appPrimaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            elevation: 2,
                          ),

                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                // Show the CircularProgressIndicator
                                setState(() {
                                  _isLoading = true;
                                });

                                UserCredential userCredential =
                                    await _auth.createUserWithEmailAndPassword(
                                        email:
                                            '${phoneNumberController.text}@example.com'
                                                .toString(),
                                        password:
                                            passwordController.text.toString());

                                // Hide the CircularProgressIndicator
                                setState(() {
                                  _isLoading = false;
                                });

                                // Display a Toast message to indicate that the account was created successfully
                                Utils().toastMessage(
                                    'Account created successfully');

                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );

                                // Sign up successful, do something here (e.g. navigate to a new screen)
                              } on FirebaseAuthException catch (e) {
                                // Hide the CircularProgressIndicator
                                setState(() {
                                  _isLoading = false;
                                });

                                if (e.code == 'weak-password') {
                                  Utils().toastMessage(
                                      'The password should be at least 6 characters.');
                                } else if (e.code == 'email-already-in-use') {
                                  Utils().toastMessage(
                                      'The account already exists for that phone number.');
                                } else {
                                  Utils().toastMessage(e.toString());
                                }
                              } catch (e) {
                                // Hide the CircularProgressIndicator
                                setState(() {
                                  _isLoading = false;
                                });

                                Utils().toastMessage(e.toString());
                              }
                            }
                          },
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : const Text('Sign Up'),
                          // child: const Text(
                          //   'Log In',
                          // ),
                        ),
                      ],
                    ),
                  ),
                ),
                // const SizedBox(height: 10),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text(
                      'Already have an account?',
                      // textDirection: TextDirection.ltr,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    GestureDetector(
                      child: const Text(
                        ' Login',
                        // textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.amberAccent,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
