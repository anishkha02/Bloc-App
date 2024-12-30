abstract class DetailEvent {}

class LoadDetail extends DetailEvent {
  final int productId;

  LoadDetail(this.productId);
}
