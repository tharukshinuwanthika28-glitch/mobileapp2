import 'package:flutter/material.dart';
import 'success_screen.dart';

class WaitingDriverScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SuccessScreen(),
        ),
      );
    });

    return Scaffold(

      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Text(
              "Driver Confirmation",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 40),

            Stack(
              alignment: Alignment.center,

              children: [

                SizedBox(
                  width: 150,
                  height: 150,
                  child: CircularProgressIndicator(
                    strokeWidth: 8,
                  ),
                ),

                Icon(
                  Icons.directions_bus,
                  size: 50,
                  color: Colors.blue,
                ),

              ],
            ),

            SizedBox(height: 40),

            Text(
              "Driver is verifying your payment...",
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 50),

            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel Request"),
            )

          ],
        ),
      ),
    );
  }
}