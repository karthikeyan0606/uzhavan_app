import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uzhavan_app/files/cart/buy_now_dialog.dart';
import 'package:uzhavan_app/files/cart/cart.dart';
import 'package:uzhavan_app/files/home/bloc/home_bloc.dart';
import 'package:uzhavan_app/files/home/category_tags.dart';
import 'package:uzhavan_app/files/home/product_tile_widget.dart';
import 'package:uzhavan_app/files/home/search_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  String searchQuery = '';
  String selectedCategory = '';
  bool isSearchVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cart()));
        } else if (state is HomeProductItemCartedActionState) {
          showBuyNowDialog(context);
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;

            // Filter products
            final filteredProducts = successState.products.where((product) {
              final matchesSearch = product.name
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase());

              // selectedCategory
              final matchesCategory = selectedCategory.isEmpty ||
                  selectedCategory == 'All' ||
                  product.category == selectedCategory;

              return matchesSearch && matchesCategory;
            }).toList();

            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.green,
                title: GestureDetector(
                  onTap: () {
                    homeBloc.add(HomeInitialEvent());
                  },
                  child: Text(
                    'Uzhavan',
                    style: GoogleFonts.rubikMonoOne(
                      textStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isSearchVisible = !isSearchVisible;
                      });
                    },
                    icon: Icon(
                      isSearchVisible ? Icons.close : Icons.search,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeCartButtonNavigateEvent());
                    },
                    icon: Icon(Icons.shopping_bag_outlined),
                  ),
                ],
              ),
              body: Column(
                children: [
                  //  search bar
                  if (isSearchVisible)
                    SearchBar(
                      onSearch: (query) {
                        setState(() {
                          searchQuery = query;
                        });
                      },
                    ),
                  // Category tags
                  const SizedBox(height: 10),
                  CategoryTags(
                    categories: [
                      'All',
                      'seed',
                      'weed killer',
                      'fertilizer',
                      'pesticide'
                    ],
                    selectedCategory: selectedCategory,
                    onCategorySelected: (category) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  // Product list
                  Expanded(
                    child: filteredProducts.isEmpty
                        ? Center(child: Text("No products found"))
                        : ListView.builder(
                            itemCount: filteredProducts.length,
                            itemBuilder: (context, index) {
                              return ProductTileWidget(
                                homeBloc: homeBloc,
                                productDataModel: filteredProducts[index],
                              );
                            },
                          ),
                  ),
                ],
              ),
            );

          case HomeErrorState:
            return Scaffold(body: Center(child: Text('Error')));
          default:
            return SizedBox();
        }
      },
    );
  }
}
