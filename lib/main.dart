import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تجربة دفع وهمية',
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  void navigateToPayment(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaymentPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('الصفحة الرئيسية')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => navigateToPayment(context),
          child: Text('ادفع 2 دولار'),
        ),
      ),
    );
  }
}

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _isProcessing = true;

  @override
  void initState() {
    super.initState();
    simulatePayment();
  }

  void simulatePayment() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      _isProcessing = false;
    });
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('نجاح العملية'),
        content: Text('تم دفع 2 دولار بنجاح.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
            child: Text('تم'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('بوابة الدفع')),
      body: Center(
        child: _isProcessing
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('جاري معالجة الدفع...')
                ],
              )
            : Text(''),
      ),
    );
  }
}
