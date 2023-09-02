class OrderResult {
  final int orderId;
  final String bankGatewayUrl;

  OrderResult(this.orderId, this.bankGatewayUrl);

  OrderResult.fromJson(Map<String, dynamic> json)
      : orderId = json["order_id"],
        bankGatewayUrl = json["bank_gateway_url"];
}

class OrderParams {
  final String name;
  final String lastName;
  final String postalCode;
  final String mobile;
  final String address;
  final PaymentMethode paymentMethode;

  OrderParams(this.name, this.lastName, this.postalCode, this.mobile,
      this.address, this.paymentMethode);
}

enum PaymentMethode { online, cashOnDelivery }
