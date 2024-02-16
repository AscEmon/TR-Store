sealed class ProductDetailsEvent {}

class LoadProductDetailsEvent implements ProductDetailsEvent {
  final int id;
  LoadProductDetailsEvent({required this.id});
}
