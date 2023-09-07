class OfferModel {
  OfferModel({
    this.textBtn = 'Order Now',
    this.imagepath,
    required this.percent,
    required this.titleOffer,
  });
  final String percent;

  final String titleOffer;
  final String textBtn;
  final String? imagepath;

  static List<OfferModel> offers = [
    OfferModel(
      percent: '20',
      titleOffer: 'Order Medicines',
    ),
    OfferModel(
      percent: '69',
      titleOffer: 'Food & Accesories',
    ),
    OfferModel(
      percent: '35',
      titleOffer: 'Groomings',
    ),
    OfferModel(
      percent: '50',
      titleOffer: 'Health Insurance',
    ),
    OfferModel(
      percent: '20',
      titleOffer: 'Order Medicines',
    ),
    OfferModel(
      percent: '69',
      titleOffer: 'Food & Accesories',
    ),
    OfferModel(
      percent: '35',
      titleOffer: 'Groomings',
    ),
    OfferModel(
      percent: '50',
      titleOffer: 'Health Insurance',
    ),
  ];
}
