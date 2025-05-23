import 'package:flutter/material.dart';
import './pages/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  onPressed(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login(),)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("./assets/logo.png",height: 200.5,),
            SizedBox(height: 20,),
            Text("Phone Planet",style: TextStyle(fontSize: 34,fontWeight: FontWeight.bold,color: Colors.blue), ),
            SizedBox(height: 50,),
            ElevatedButton(
              onPressed: onPressed,
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states){
                      if(states.contains(WidgetState.pressed)){
                        return Theme.of(context).colorScheme.primary.withOpacity(0.5);
                      }
                      return null;
                    }
                  )
              ),
              child: Text("Continue"),
            )
          ],
        )
      ),
    );
  }
}
