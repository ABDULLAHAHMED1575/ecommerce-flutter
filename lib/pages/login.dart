import 'package:flutter/material.dart';
import '../widgets/inputField.dart';
import '../widgets/customButton.dart';
import '../services/auth_service.dart';
import './admin/admin_dashboard.dart';
import './signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool loading = false;
  String error='';
  void handleLogin()async{
    try{
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Input Fields required"),
              backgroundColor: Colors.red.shade300,
              duration: Duration(seconds: 3),
            ),
          );
        });
      }
      final user = await AuthService.login(
          emailController.text,
          passwordController.text
      );
      setState(()=> loading = false);
      if(user != null){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminDashboard()),
        );
      }
    }
    catch(e){
      setState(()=> loading = false);
      error = 'An error occured: ${e.toString()}';
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
    error = '';
  }

  void registerpage(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Signup())
    );
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:Center(child: Text("LOGIN",style: TextStyle(fontSize: 36,fontWeight: FontWeight.bold,color: Colors.white),),),
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
                      onPressed: handleLogin,
                      text: "Login",
                      textColor: Colors.white,
                      color: Colors.blue,
                    ),
                    TextButton(onPressed: registerpage, child: Text("Don't have an account"))
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