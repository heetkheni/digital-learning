import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';


class RazorPay extends StatefulWidget {
  const RazorPay({super.key});

  @override
  State<RazorPay> createState() => _RazorPayState();
}

class _RazorPayState extends State<RazorPay> {

  late Razorpay _razorPay = Razorpay();
    TextEditingController amountController = TextEditingController();


    Future<void> opneCheckout(amount) async {

      amount = amount * 100;

  

        //6zwJGEsSTFFKk0znXeonn3YV
   

      var options = {
      'key': 'rzp_test_Fc5JcS8L0tNc9e', // Replace with your Razorpay Key
      'amount': amount,
      'name': 'Geeks For Geeks',
      'retry': {'enabled': true, 'max_count': 1},
      'prefill': {'contact': '1234567890', 'email': 'heetkhenifirebase@gmail.com'},
      'external': {
        'wallet': ['paytm','gpay']
      }
    };

      try {

        _razorPay.open(options);
      

      }
      catch(e){
        debugPrint(e.toString());
      }
    }


    void handlePaymentSucces(PaymentSuccessResponse response){
      Fluttertoast.showToast(msg: "Payment Succefull"+response.paymentId! ,toastLength: Toast.LENGTH_SHORT );
    }

    
    void handlePaymentError(PaymentFailureResponse response){
      Fluttertoast.showToast(msg: "Payment fail"+response.message! ,toastLength: Toast.LENGTH_SHORT );
    }

    
    void handleexternalWalletr(ExternalWalletResponse response){
      Fluttertoast.showToast(msg: "External Wallet"+response.walletName! ,toastLength: Toast.LENGTH_SHORT );
    }

    @override
  void dispose() {
    _razorPay.clear();
    super.dispose();
  }

  @override
  void initState() {
   _razorPay = Razorpay();
   _razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleexternalWalletr);
   _razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
   _razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSucces);
    super.initState();
  }
    

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Text("Welcome to Razorpay Payment Gateway Integration",style: TextStyle(fontSize: 18,color: Colors.white),textAlign: TextAlign.center,),
            SizedBox(height: 30,),
            Padding(padding: EdgeInsets.all(8),
            child: TextFormField(
              cursorColor: Colors.white,
              autofocus: false,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Enter amount to paid",
                labelStyle: TextStyle(fontSize: 15.0,color: Colors.white),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1
                  )
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1
                  )
                ),
                errorStyle: TextStyle(color: Colors.redAccent,fontSize: 15),
              ),
              controller: amountController,
              validator: (value){
                if(value == null || value.isEmpty || value == 0){
                  return "Please enter amount or more than one";
                }
                return null;
              },
              ),
            ),

            SizedBox(height: 30,),
            ElevatedButton(onPressed: (){
              if(amountController.text.toString().isNotEmpty){
                setState(() {
                  int amount = int.parse(amountController.text.toString());
                  opneCheckout(amount);
                });
              }
            }, child: Text("Pay amount"))
          ],
        ),
      ),
    );
  }
}