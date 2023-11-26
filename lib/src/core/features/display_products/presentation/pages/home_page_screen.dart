import 'package:ecommerce_user/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/product_model.dart';
import '../bloc/display_products_bloc.dart';
import '../widgets/custom_button.dart';
import '../widgets/favorite_cart.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  void initState() {
    context.read<DisplayProductsBloc>().add(DisplayProductItems());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello Satyam..'),
      ),
      body: BlocBuilder<DisplayProductsBloc, DisplayProductState>(
        builder: (context, state) {
          if (state.productStatus == ProductStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.productStatus == ProductStatus.success) {
            return buildProductGrid(state.products!);
          } else if (state.productStatus == ProductStatus.failure) {
            return Center(child: Text('Error: ${state.failure}'));
          } else {
            return const Text('Something Went Wrong !');
          }
        },
      ),
    );
  }

  Widget buildProductGrid(List<Product> products) {
    const double itemWidth = 180;
    final double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = (screenWidth / itemWidth).floor();

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.6,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return buildProductCard(product);
      },
    );
  }

  Widget buildProductCard(Product product) {
    return GestureDetector(
      onTap: () {
        //navigate to product detail screen
      },
      child: Card(
        // color: Colors.amber,
        margin: const EdgeInsets.all(5.0),
        child: Stack(
          children: [
            buildProductCardContent(product),
            Positioned(
              right: 0,
              child: buildDiscountTag(product),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProductCardContent(Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                10.0), // Adjust the value for desired corner radius
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0), // Same value as above
            child: Image.network(
              product.productImgUrl!,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),

        const Spacer(),
        Container(
          padding: const EdgeInsetsDirectional.only(start: 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.title!,
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              Text(
                '₹ ${double.parse(product.productPrice.toString())}',
                style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '₹ ${double.parse(product.sellingPrice.toString())}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: TColors.buttonPrimary,
                    ),
                  ),
                  const Spacer(),
                  const FavoriteAndCart(),
                ],
              ),
            ],
          ),
        ),
        // const Spacer(),
      ],
    );
  }

  Widget buildDiscountTag(Product product) {
    final originalPrice = product.productPrice as num;
    final discountedPrice = product.sellingPrice as num;

    final discount = (originalPrice - discountedPrice) / originalPrice;
    final discountPercentage = (discount * 100).ceil();
    return CustomButton(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      text: '$discountPercentage%',
      backgroundColor: const Color.fromARGB(238, 243, 176, 43),
      textColor: Colors.white,
    );
  }
}
