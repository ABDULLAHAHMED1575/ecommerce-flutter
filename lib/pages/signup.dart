import 'package:flutter/material.dart';
import '../widgets/inputField.dart';
import '../widgets/customButton.dart';
import '../services/auth_service.dart';
import './login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  bool loading = false;
  String error='';
  void handleSignup() async {


    try {
      if (emailController.text.isEmpty || passwordController.text.isEmpty || firstName.text.isEmpty || lastName.text.isEmpty) {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Input Fields required"),
              backgroundColor: Colors.red.shade300,
              duration: Duration(seconds: 3),
            ),
          );
        });
        return;
      }
      setState(() {
        loading = true;
        error = '';
      });
      final user = await AuthService.signup(
        email: emailController.text,
        password: passwordController.text,
        firstName: firstName.text,
        lastName: lastName.text,
      );

      setState(() => loading = false);

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Account created successfully! Please login."),
            backgroundColor: Colors.green.shade300,
          ),
        );
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => Login())
        );
      } else {
        setState(() {
          error = "Signup failed, please try again.";
        });
      }
    } catch (e) {
      setState(() {
        loading = false;
        error = "An error occurred: ${e.toString()}";
      });
    }

    if (error.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: Colors.red.shade300,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  void loginPage(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login())
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:new Center(child: Text("SIGNUP",style: TextStyle(fontSize: 36,fontWeight: FontWeight.bold,color: Colors.white),),),
        shadowColor: Colors.white,
        backgroundColor: Colors.blue.shade300,
      ),
      backgroundColor: Colors.blue.shade100,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Inputfield(
                      controller: firstName,
                      label: "Enter first name",
                      hint: "First Name",
                      prefixIcon: Icons.email,
                    ),
                    SizedBox(height: 20),
                    Inputfield(
                      controller: lastName,
                      label: "Enter last name",
                      hint: "Last Name",
                      prefixIcon: Icons.email,
                    ),
                    SizedBox(height: 20),
                    Inputfield(
                      controller: emailController,
                      label: "Enter Email",
                      hint: "Email",
                      prefixIcon: Icons.email,
                    ),
                    SizedBox(height: 20),
                    Inputfield(
                      controller: passwordController,
                      label: "Enter Password",
                      hint: "Password",
                      obscureText: true,
                      prefixIcon: Icons.lock,
                    ),
                    SizedBox(height: 20),
                    loading
                        ? CircularProgressIndicator()
                        : CustomButton(
                      onPressed: handleSignup,
                      text: "Create account",
                      textColor: Colors.white,
                      color: Colors.blue,
                    ),
                    TextButton(onPressed: loginPage, child: Text("Already have an account"))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
