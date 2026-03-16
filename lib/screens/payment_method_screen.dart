import 'package:flutter/material.dart';
import 'cash_confirm_screen.dart';
import 'payment_history_screen.dart';

class PaymentMethodScreen extends StatefulWidget {
  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> methods = [
    {"title": "Bank Slip Upload", "icon": Icons.upload_file},
    {"title": "Cash to Driver", "icon": Icons.payments},
    {"title": "Direct Bank Transfer", "icon": Icons.account_balance},
    {"title": "Credit/Debit Card", "icon": Icons.credit_card},
    {"title": "Digital Wallets", "icon": Icons.phone_iphone},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: Text("Payment Method"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,

        // ✅ Add History Icon
        actions: [
          IconButton(
            icon: Icon(Icons.history, color: Colors.blue),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PaymentHistoryScreen()),
              );
            },
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

            Text(
              "Payment Method Selection",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              "Choose your preferred payment option below.",
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),

            SizedBox(height: 25),

            Expanded(
              child: ListView.builder(
                itemCount: methods.length,
                itemBuilder: (context, index) {
                  bool selected = selectedIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 15),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: selected ? Colors.blue : Colors.grey.shade300,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            methods[index]["icon"],
                            size: 28,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 15),
                          Text(
                            methods[index]["title"],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  String selectedMethod = methods[selectedIndex]["title"];

                  if (selectedMethod == "Cash to Driver") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CashConfirmScreen(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Selected: $selectedMethod"),
                      ),
                    );
                  }
                },
                child: Text(
                  "Continue",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}