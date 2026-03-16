import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Padding(
        padding: EdgeInsets.all(30),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Icon(
              Icons.check_circle,
              size: 100,
              color: Colors.green,
            ),

            SizedBox(height: 20),

            Text(
              "Payment Successful",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            Container(

              padding: EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6,
                    color: Colors.black12,
                  )
                ],
              ),

              child: Column(

                children: [

                  Text("Transaction ID: BUS-45892"),
                  Text("Driver: John Silva"),

                  Divider(),

                  Text(
                    "Amount Paid: Rs.2550",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ],
              ),
            ),

            SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(
                    context, (route) => route.isFirst);
              },

              child: Text("Done"),
            )

          ],
        ),
      ),
    );
  }
}