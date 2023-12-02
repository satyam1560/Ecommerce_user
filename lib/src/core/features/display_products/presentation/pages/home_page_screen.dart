import 'package:ecommerce_user/src/core/features/display_products/presentation/widgets/discount.dart';
import 'package:ecommerce_user/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cart/presentation/widgets/favorite_cart.dart';
import '../../data/models/product_model.dart';
import '../bloc/display_products_bloc.dart';
import 'product_details.dart';

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
        body: Column(
          children: [
            const SearchBar(
              elevation: MaterialStatePropertyAll(5),
              leading: Icon(Icons.search),
              hintText: 'Search',
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: BlocBuilder<DisplayProductsBloc, DisplayProductState>(
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
            ),
          ],
        ));
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
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => ProductDetails(
                  product: product,
                ));
      },
      child: Card(
        margin: const EdgeInsets.all(5.0),
        child: Stack(
          children: [
            buildProductCardContent(product),
            Positioned(
              right: 0,
              child: DiscountTag(product: product),
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
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
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
                  FavoriteAndCart(
                    productId: product.id,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
