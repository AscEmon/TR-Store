import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tr_store/modules/product_details/bloc/product_details_event.dart';

import '../bloc/product_details_bloc.dart';
import '/global/widget/global_appbar.dart';
import '/global/widget/global_text.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int id;
  const ProductDetailsScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductDetailsBloc>().add(
          LoadProductDetailsEvent(id: widget.id),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(
        title: "Productdetails",
      ),
      body: const Center(
        child: GlobalText(str: "Productdetails Setup"),
      ),
    );
  }
}
