import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentHistoryScreen extends StatelessWidget {
  final Color darkBlue = Color(0xFF1A237E);

  // Function to confirm payment
  void confirmPayment(String docId) {
    FirebaseFirestore.instance
        .collection('payments')
        .doc(docId)
        .update({'status': 'Completed'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment History",
          style: TextStyle(
            color: darkBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: darkBlue),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('payments')
              .orderBy('date', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            final docs = snapshot.data!.docs;

            if (docs.isEmpty) {
              return Center(
                child: Text(
                  "No transactions yet.",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            }

            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final data = docs[index].data() as Map<String, dynamic>;
                final docId = docs[index].id;
                bool isPending = data['status'] == "Pending";

                return Card(
                  margin: EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color(0xFFE8EAF6),
                      child: Icon(Icons.payment, color: darkBlue),
                    ),
                    title: Text(
                      data['method'] ?? "Unknown",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: darkBlue,
                      ),
                    ),
                    subtitle: Text(data['date'] ?? ""),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\$${data['amount'] ?? 0}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: darkBlue,
                          ),
                        ),
                        isPending
                            ? ElevatedButton(
                                onPressed: () {
                                  confirmPayment(docId);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Payment Confirmed"),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                                child: Text("Confirm"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 5),
                                  textStyle: TextStyle(fontSize: 12),
                                ),
                              )
                            : Text(
                                data['status'] ?? "",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}