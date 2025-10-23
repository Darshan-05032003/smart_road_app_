class ProviderServiceHistoryModel {
  String customerName;
  String serviceType;
  String date;
  String amount;

  ProviderServiceHistoryModel(
    this.customerName,
    this.serviceType,
    this.date,
    this.amount,
  );
}

class ActiveRequestModel {
  final String customerName;
  final String serviceType;
  final String distance;
  final String eta;
  final String status;

  ActiveRequestModel(
    this.customerName,
    this.serviceType,
    this.distance,
    this.eta,
    this.status,
  );
}
