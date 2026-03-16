import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen()));
}

// ---------------- Home Screen ----------------
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController feeController = TextEditingController();
  String selectedMonth = "March";
  String greeting = "";
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _updateGreeting();
    timer = Timer.periodic(Duration(minutes: 1), (_) => _updateGreeting());
  }

  void _updateGreeting() {
    final hour = DateTime.now().hour;
    String newGreeting;

    if (hour >= 5 && hour < 12) {
      newGreeting = "Good Morning";
    } else if (hour >= 12 && hour < 17) {
      newGreeting = "Good Afternoon";
    } else if (hour >= 17 && hour < 21) {
      newGreeting = "Good Evening";
    } else {
      newGreeting = "Good Night";
    }

    if (newGreeting != greeting) {
      setState(() {
        greeting = newGreeting;
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  // Fee validation
  bool validateFee() {
    if (feeController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please enter a fee amount.")));
      return false;
    }
    final fee = double.tryParse(feeController.text);
    if (fee == null || fee <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a valid positive amount.")),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              height: 220,
              width: double.infinity,
              padding: EdgeInsets.only(top: 60, left: 20, right: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff3A7BFF), Color(0xff2B4CDB)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "EduRide Student",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white24,
                        child: Icon(Icons.notifications, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text("$greeting,", style: TextStyle(color: Colors.white70)),
                  Text(
                    "Ashan Perera 👋",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Fee Input Section
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter Transport Fee",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: feeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixText: "Rs ",
                      hintText: "Enter amount",
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField(
                    value: selectedMonth,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items:
                        [
                          "January",
                          "February",
                          "March",
                          "April",
                          "May",
                          "June",
                        ].map((month) {
                          return DropdownMenuItem(
                            value: month,
                            child: Text(month),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedMonth = value!;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Color(0xff2B4CDB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (validateFee()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PaymentOptionsScreen(
                                fee: feeController.text,
                                month: selectedMonth,
                              ),
                            ),
                          );
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.payment),
                          SizedBox(width: 10),
                          Text(
                            "Pay Transport Fee",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Modern Billing History Button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      icon: Icon(Icons.history, color: Color(0xff2B4CDB)),
                      label: Text(
                        "View Billing History",
                        style: TextStyle(color: Color(0xff2B4CDB)),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: Color(0xff2B4CDB), width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // Navigate to Billing History Screen (placeholder)
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BillingHistoryScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------ Payment Options Screen ----------------
class PaymentOptionsScreen extends StatefulWidget {
  final String fee;
  final String month;

  PaymentOptionsScreen({required this.fee, required this.month});

  @override
  State<PaymentOptionsScreen> createState() => _PaymentOptionsScreenState();
}

class _PaymentOptionsScreenState extends State<PaymentOptionsScreen> {
  String? selectedOption;

  List<Map<String, dynamic>> paymentOptions = [
    {
      "icon": Icons.account_balance_wallet,
      "title": "Google Pay",
      "subtitle": "Pay instantly via Google Pay",
    },
    {
      "icon": Icons.account_balance,
      "title": "PayPal",
      "subtitle": "Pay securely via PayPal",
    },
    {
      "icon": Icons.upload_file,
      "title": "Deposit Slip",
      "subtitle": "Upload a payment receipt",
    },
    {
      "icon": Icons.directions_bus,
      "title": "Driver Collection",
      "subtitle": "Pay cash directly to driver",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Payment Method"),
        backgroundColor: Color(0xff2B4CDB),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(20),
              itemCount: paymentOptions.length,
              itemBuilder: (context, index) {
                var option = paymentOptions[index];
                bool isSelected = selectedOption == option['title'];

                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedOption = option['title'];
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.blue.shade100
                              : Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: isSelected
                                ? Colors.blue
                                : Colors.blue.shade200,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                option['icon'],
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    option['title'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    option['subtitle'],
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (isSelected)
                              Icon(Icons.check_circle, color: Colors.blue),
                          ],
                        ),
                      ),
                    ),
                    if (isSelected && option['title'] == "Deposit Slip")
                      DepositSlipInfoWidget(fee: widget.fee),
                  ],
                );
              },
            ),
          ),
          if (selectedOption != null)
            Container(
              padding: EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Color(0xff2B4CDB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (selectedOption == "Deposit Slip") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DepositSlipUploadScreen(
                            fee: widget.fee,
                            month: widget.month,
                          ),
                        ),
                      );
                    } else if (selectedOption == "Google Pay") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => GooglePayScreen(
                            fee: widget.fee,
                            month: widget.month,
                          ),
                        ),
                      );
                    } else if (selectedOption == "PayPal") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PayPalScreen(
                            fee: widget.fee,
                            month: widget.month,
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "${selectedOption!} selected for Rs ${widget.fee} (${widget.month})",
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    "Proceed with $selectedOption",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------- Google Pay Screen ----------------
class GooglePayScreen extends StatelessWidget {
  final String fee;
  final String month;

  GooglePayScreen({required this.fee, required this.month});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Pay"),
        backgroundColor: Color(0xff2B4CDB),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pay via Google Pay",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text("Amount: Rs $fee"),
            Text("Month: $month"),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                icon: Icon(Icons.payment),
                label: Text("Pay Now"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                  backgroundColor: Color(0xff2B4CDB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Payment successful via Google Pay!"),
                    ),
                  );
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- PayPal Screen ----------------
class PayPalScreen extends StatelessWidget {
  final String fee;
  final String month;

  PayPalScreen({required this.fee, required this.month});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PayPal"), backgroundColor: Color(0xff2B4CDB)),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pay via PayPal",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text("Amount: Rs $fee"),
            Text("Month: $month"),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                icon: Icon(Icons.payment),
                label: Text("Pay with PayPal"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                  backgroundColor: Color(0xff003087),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Payment successful via PayPal!")),
                  );
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- Deposit Slip Info Widget ----------------
class DepositSlipInfoWidget extends StatelessWidget {
  final String fee;

  DepositSlipInfoWidget({required this.fee});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bank Details",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text("Bank: ABC Bank"),
          Text("Account Name: EduRide Transport"),
          Text("Account Number: 123-456-789"),
          Text("Branch: Colombo 07"),
          SizedBox(height: 10),
          Text(
            "Please transfer and upload your deposit slip below.",
            style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// ---------------- Deposit Slip Upload Screen ----------------
class DepositSlipUploadScreen extends StatefulWidget {
  final String fee;
  final String month;

  DepositSlipUploadScreen({required this.fee, required this.month});

  @override
  State<DepositSlipUploadScreen> createState() =>
      _DepositSlipUploadScreenState();
}

class _DepositSlipUploadScreenState extends State<DepositSlipUploadScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 70,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void showUploadOptions() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Camera"),
              onTap: () {
                Navigator.pop(context);
                pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("Gallery"),
              onTap: () {
                Navigator.pop(context);
                pickImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  void removeImage() {
    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Deposit Slip"),
        backgroundColor: Color(0xff2B4CDB),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Bank Name", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              "Bank of Ceylon",
              style: TextStyle(color: Colors.grey.shade700),
            ),
            SizedBox(height: 15),
            Text(
              "Reference Number",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "BOC${DateTime.now().millisecondsSinceEpoch}",
              style: TextStyle(color: Colors.grey.shade700),
            ),
            SizedBox(height: 15),
            Text(
              "Transfer Amount",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Rs ${widget.fee}",
              style: TextStyle(color: Colors.grey.shade700),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: showUploadOptions,
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: _image == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.upload_file, color: Colors.blue, size: 40),
                          SizedBox(height: 10),
                          Text("Tap to upload deposit slip"),
                          Text(
                            "Choose Camera or Gallery",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      )
                    : Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.file(
                              _image!,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 5,
                            right: 5,
                            child: GestureDetector(
                              onTap: removeImage,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Note: Please upload a clear deposit slip before submitting.",
              style: TextStyle(fontSize: 12, color: Colors.red),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: _image != null
                      ? Color(0xff2B4CDB)
                      : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _image != null
                    ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Deposit Slip Submitted!")),
                        );
                      }
                    : null,
                child: Text("Submit Payment", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- Billing History Placeholder ----------------
class BillingHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Billing History"),
        backgroundColor: Color(0xff2B4CDB),
      ),
      body: Center(
        child: Text(
          "Billing history will be displayed here.",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
