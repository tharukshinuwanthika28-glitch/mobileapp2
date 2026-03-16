import 'package:flutter/material.dart';
import 'waiting_driver_screen.dart';

class CashConfirmScreen extends StatefulWidget {
  @override
  _CashConfirmScreenState createState() => _CashConfirmScreenState();
}

class _CashConfirmScreenState extends State<CashConfirmScreen> {

  bool cashReady = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Confirm Payment"),
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          children: [

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),

              child: Padding(
                padding: EdgeInsets.all(20),

                child: Column(
                  children: [

                    priceRow("Bus Fee", "Rs.2500"),
                    priceRow("Service Fee", "Rs.50"),

                    Divider(),

                    priceRow("Total", "Rs.2550", isTotal: true),

                  ],
                ),
              ),
            ),

            Spacer(),

            CheckboxListTile(
              value: cashReady,

              onChanged: (value) {
                setState(() {
                  cashReady = value!;
                });
              },

              title: Text(
                "I have physical cash ready for the driver",
              ),
            ),

            SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,

              child: ElevatedButton(

                onPressed: cashReady
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                WaitingDriverScreen(),
                          ),
                        );
                      }
                    : null,

                child: Text("Confirm Payment Request"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget priceRow(String title, String price,
      {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight:
                  isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),

          Text(
            price,
            style: TextStyle(
              fontWeight:
                  isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}