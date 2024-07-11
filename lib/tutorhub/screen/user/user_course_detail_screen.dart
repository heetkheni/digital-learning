import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:tutorhub/tutorhub/screen/user/user_home_screen.dart';
import 'package:tutorhub/tutorhub/widget/video_player.dart';

class DetailScreen extends StatefulWidget {
  final Course course;

  DetailScreen({required this.course});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Razorpay _razorPay = Razorpay();

  Future<void> opneCheckout() async {

    var amount = widget.course.price;


    //6zwJGEsSTFFKk0znXeonn3YV

    var options = {
      'key': 'rzp_test_Fc5JcS8L0tNc9e', // Replace with your Razorpay Key
      'amount': 100 * int.parse((widget.course.price)),
      'name': 'TutorHub',
      'retry': {'enabled': true, 'max_count': 1},
      'prefill': {
        'contact': '1234567890',
        'email': 'heetkhenifirebase@gmail.com'
      },
      'external': {
        'wallet': ['paytm', 'gpay']
      }
    };

    try {
      _razorPay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void handlePaymentSucces(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Succefull" + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void handlePaymentError(response) {
    Fluttertoast.showToast(
        msg: "Payment fail" + response.message!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void handleexternalWalletr(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "External Wallet" + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }

  @override
  void dispose() {
    _razorPay.clear();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
        ],
        elevation: 0, // No shadow under the app bar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.course.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  _buildInfoContainer(Icons.star, widget.course.category),
                  SizedBox(width: 10),
                  _buildInfoContainer(Icons.person, widget.course.lessons),
                  SizedBox(width: 10),
                  _buildInfoContainer(
                      Icons.play_circle, "${widget.course.lessons} hr"),
                ],
              ),
              SizedBox(height: 20),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[300],
                ),
                child: VideoDisplay(videoURL: widget.course.videoUrl),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
              
                    opneCheckout();
                
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "Enroll Now",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoContainer(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(fontSize: 17),
          ),
        ],
      ),
    );
  }
}
