class RecieptResult {
  final String paymetStatus;

  final int pricePayable;

  final bool purchaseSucees;

  RecieptResult(this.paymetStatus, this.pricePayable, this.purchaseSucees);

  RecieptResult.fromJson(Map<String, dynamic> json)
      : paymetStatus = json["payment_status"],
        pricePayable = json["payable_price"],
        purchaseSucees = json["purchase_success"];
}
