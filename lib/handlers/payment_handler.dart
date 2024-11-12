import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayService {
  final Razorpay _razorpay = Razorpay();
  final int amount;

  RazorpayService({required this.amount}) {
    // Set up Razorpay event listeners

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openCheckout() {
    var options = {
      'key': 'rzp_live_0O7o5xi0wjOfEv', // Replace with your actual API Key
      'amount': amount *
          100, // Amount in the smallest currency unit (e.g., paise for INR)
      'name': 'SwipeFit',
      'description': 'Purchase description',
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print("Error opening Razorpay checkout: ${e.toString()}");
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Payment Successful: ${response.paymentId}");
    // Add additional code here to update UI or backend after successful payment
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Error: ${response.code} - ${response.message}");
    // Add additional code here to handle payment failure
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Wallet selected: ${response.walletName}");
    // Handle external wallet selection here if necessary
  }

  void dispose() {
    _razorpay.clear();
  }
}
