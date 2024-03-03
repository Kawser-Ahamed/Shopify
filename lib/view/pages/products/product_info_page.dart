import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopify/data/screen.dart';
import 'package:shopify/models/api/comments_model.dart';
import 'package:shopify/models/cart/cart_model.dart';
import 'package:shopify/resource/assets/app_images.dart';
import 'package:shopify/resource/colors/app_color.dart';
import 'package:shopify/utils/reusable/cart_icon_design.dart';
import 'package:shopify/utils/reusable/custom_text.dart';
import 'package:shopify/view/pages/products/search.dart';
import 'package:shopify/view_models/api/comments_view_model.dart';
import 'package:shopify/view_models/cart/cart_view_model.dart';
import 'package:shopify/view_models/products/click_controller.dart';
import 'package:shopify/view_models/products/products_controller.dart';

class ProductInfoPage extends StatefulWidget {
  const ProductInfoPage({super.key});

  @override
  State<ProductInfoPage> createState() => _ProductInfoPageState();
}

class _ProductInfoPageState extends State<ProductInfoPage> {

  ClickController clickController = Get.find();
  ProductsController productsController = Get.find();
  final _scrollController = ScrollController();
  CommentsViewModel commentsViewModel = Get.put(CommentsViewModel());
  TextEditingController reviewAndComments = TextEditingController();
  CartViewModel cartViewModel = Get.find();
  
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    return PopScope(
      onPopInvoked: (value){
        clickController.productQuantity.value = 1;
        clickController.sizeTapIndex.value = 0;
        clickController.size.value = "";
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: (productsController.productInfoData.first.quantity>0) ? Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 1,
                blurRadius: 2,
              )
            ]
          ),
          child: ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap:(){
                      if(clickController.productQuantity.value>1){
                        clickController.productQuantity.value--;
                      }
                    },
                    child: Container(
                      height: height * 0.05,
                      width: height * 0.05,
                      color: Colors.transparent,
                      child: const FittedBox(
                        child: Icon(Icons.remove,color: Colors.red,),
                      ),
                    ),
                  ),
                  SizedBox(width: width * 0.02),
                  Obx(() => Text(clickController.productQuantity.value.toString(),
                    style: TextStyle(
                      fontSize: (width/Screen.designWidth) * 45,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  SizedBox(width: width * 0.02),
                  InkWell(
                    onTap:(){
                      if(clickController.productQuantity.value<productsController.productInfoData[clickController.productIndex.value].quantity){
                        clickController.productQuantity.value++;
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: const Duration(seconds: 1), content: Column(children: [
                          Text("Shopify",
                            style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.bold,
                              fontSize: (width/Screen.designWidth) * 30,
                            ),
                          ),
                          Text("Sorry, We don't have much product than that",
                            style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.normal,
                              fontSize: (width/Screen.designWidth) * 25,
                            ),
                          ),
                        ],),));
                      }
                    },
                    child: Container(
                      height: height * 0.05,
                      width: height * 0.05,
                      color: Colors.transparent,
                      child: const FittedBox(
                        child: Icon(Icons.add,color: Colors.green,),
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap:(){
                  CartModel cartModel = CartModel(
                    productId: productsController.productInfoData.first.id, 
                    productName: productsController.productInfoData.first.productName, 
                    productImageUrl: productsController.productInfoData.first.primaryImageUrl,
                    price: productsController.productInfoData.first.price, 
                    size: clickController.size.value, 
                    quantity: clickController.productQuantity.value, 
                    totalPrice: productsController.productInfoData.first.price * clickController.productQuantity.value,
                    originalQuantity: productsController.productInfoData.first.quantity,
                    deliveryCharge: productsController.productInfoData.first.deliveryCharge,
                  );
                  cartViewModel.addProductsOnCart(cartModel);
                  //debugPrint('added on cart');
                },
                child: Container(
                  height: height * 0.06,
                  width:  width * 0.5,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Colors.pink,Colors.red]),
                    borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth)*50)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.04,vertical: 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: height * 0.05,
                          width: height * 0.06,
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(
                              image: AssetImage("assets/images/cart_bag.png"),
                            ),
                          ),
                        ),
                        Text("Add To Cart",
                          style: GoogleFonts.aBeeZee(
                            fontSize: (width/Screen.designWidth) * 30,
                            color: Colors.white
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ]
          ),
        ) : const SizedBox(),
        body: NotificationListener<ScrollNotification>(
          onNotification: (notification){
            if(notification is ScrollUpdateNotification){
              (_scrollController.position.pixels > height * 0.25) ? clickController.scrollState.value = true : clickController.scrollState.value = false;
            }
            return false;
          },
          child: Container(
            height: height * 1,
            width: width * 1,
            color: Colors.white,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                Obx(() => SliverAppBar(
                  expandedHeight: height * 0.4,
                  leading: (clickController.scrollState.value) ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          clickController.scrollState.value = false;
                          clickController.productQuantity.value = 1;
                          clickController.productRating.value = 0;
                          clickController.sizeTapIndex.value = 0;
                          clickController.size.value = "";
                          Get.back();
                        },
                        child: Container(
                          height: height * 0.04,
                          width: height * 0.04,
                          color: Colors.transparent,
                          margin: EdgeInsets.only(left: width * 0.05),
                          child: const FittedBox(
                            child: Icon(Icons.arrow_back_ios,color: Colors.white),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: (){
                              clickController.scrollState.value = false;
                              Get.to(const Search(),transition: Transition.rightToLeftWithFade);
                            },
                            child: Container(
                              height: height * 0.04,
                              width: height * 0.04,
                              color: Colors.transparent,
                              margin: EdgeInsets.only(left: width * 0.05),
                              child: const FittedBox(
                                child: Icon(Icons.search,color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(width: width * 0.03),
                          // Container(
                          //   height: height * 0.04,
                          //   width: height * 0.04,
                          //   color: Colors.transparent,
                          //   margin: EdgeInsets.only(right: width * 0.05),
                          //   child: const FittedBox(
                          //     child: Icon(CupertinoIcons.cart,color: Colors.white),
                          //   ),
                          // ),
                          const CartIconsDesign(iconsHeight: 0.06, iconWidth: 0.06,color: Colors.white,),
                          SizedBox(width: width * 0.05),
                        ],
                      )
                    ],
                  ) : const Text(""),
                  leadingWidth: width * 1,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        (productsController.productInfoData.first.quantity>0) ?Hero(
                          tag: productsController.productInfoData[clickController.productIndex.value].id,
                          child: Image.network(productsController.productInfoData[clickController.productIndex.value].primaryImageUrl,fit: BoxFit.fill,width: double.infinity,height: double.infinity,)
                        ) : Image.asset(AppImages.soldOut,fit: BoxFit.fill,width: double.infinity,height: double.infinity,),
                        Positioned(
                          top: 0,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap:(){
                                  clickController.productQuantity.value = 1;
                                  clickController.scrollState.value = false;
                                  clickController.productRating.value = 0;
                                  clickController.sizeTapIndex.value = 0;
                                  clickController.size.value = "";
                                  Get.back();
                                },
                                child: Container(
                                  height: height * 0.06,
                                  width: height * 0.06,
                                  margin: EdgeInsets.only(left: width * 0.05,top: height * 0.08),
                                  decoration: BoxDecoration(
                                    color: AppColor.iconBackground,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all((width/Screen.designWidth) * 10),
                                    child: const FittedBox(
                                      child: Icon(Icons.arrow_back,color: Colors.white,),
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap:(){
                                      Get.to(const Search(),transition: Transition.rightToLeftWithFade);
                                    },
                                    child: Container(
                                      height: height * 0.06,
                                      width: height * 0.06,
                                      //alignment: Alignment.center,
                                      margin: EdgeInsets.only(bottom: width * 0.03,top: height * 0.08,right: width * 0.03),
                                      decoration: BoxDecoration(
                                        color: AppColor.iconBackground,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all((width/Screen.designWidth) * 10),
                                        child: const FittedBox(
                                          child: Icon(Icons.search,color: Colors.white,),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap:(){
                                    },
                                    child: Container(
                                      height: height * 0.06,
                                      width: height * 0.06,
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(right: width * 0.03),
                                      decoration: BoxDecoration(
                                        color: AppColor.iconBackground,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const CartIconsDesign(iconsHeight: 0.06, iconWidth: 0.06, color: Colors.white),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ),
                  pinned: true,
                  floating: false,
                  backgroundColor: AppColor.primaryColor,
                )),
                SliverToBoxAdapter(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          margin: EdgeInsets.only(top: height * 0.01,left: width * 0.03),
                          child: Text(
                            productsController.productInfoData[clickController.productIndex.value].productName,
                            style: GoogleFonts.aBeeZee(
                              fontSize: (width/Screen.designWidth) * 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: height * 0.05,
                            width: height * 0.05,
                            color: Colors.transparent,
                            child: Padding(
                              padding: EdgeInsets.all((width/Screen.designWidth) * 10),
                              child: const FittedBox(
                                child: Icon(Icons.star,color: Colors.orange),
                              ),
                            ),
                          ),
                          Text(
                            productsController.productInfoData[clickController.productIndex.value].ratings.toString(),
                            style: TextStyle(
                              fontSize: (width/Screen.designWidth) * 30, 
                            ),
                          ),
                          SizedBox(width: width * 0.03),
                        ],
                      )
                    ],
                  )
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03,vertical: height * 0.01),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '৳ ${productsController.productInfoData[clickController.productIndex.value].price.toString()}',
                              style: TextStyle(
                                fontSize: (width/Screen.designWidth) * 35, 
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: width * 0.05),
                            (productsController.productInfoData[clickController.productIndex.value].oldPrice != 0) 
                            ? Text(
                              '৳ ${productsController.productInfoData[clickController.productIndex.value].oldPrice.toString()}',
                              style: TextStyle(
                                fontSize: (width/Screen.designWidth) * 30, 
                                color: Colors.red,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.lineThrough
                              ),
                            ): const Text(""),
                          ],
                        ),
                        Text(
                          "Category: ${productsController.productInfoData[clickController.productIndex.value].category}",
                          style: TextStyle(
                            fontSize: (width/Screen.designWidth) * 30, 
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Divider(color: Colors.grey),
                        Text(
                          "Product Description",
                          style: TextStyle(
                            fontSize: (width/Screen.designWidth) * 40, 
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Brand: ${productsController.productInfoData[clickController.productIndex.value].brandName}",
                          style: TextStyle(
                            fontSize: (width/Screen.designWidth) * 30, 
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Type: ${productsController.productInfoData[clickController.productIndex.value].type}",
                          style: TextStyle(
                            fontSize: (width/Screen.designWidth) * 30, 
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ExpandableText(
                          productsController.productInfoData[clickController.productIndex.value].productDescription,
                          maxLines: 3,
                          textAlign: TextAlign.justify,
                          expandText: "Read more",
                          collapseText: "Read less",
                          style: TextStyle(
                            fontSize: (width/Screen.designWidth) * 25,
                          ),
                          linkColor: AppColor.primaryColor,
                        ),
                        (productsController.productInfoData[clickController.productIndex.value].productSize!.isNotEmpty) ?
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(text: "Select Size", height: 0.04, width: 0.3, color: Colors.black, bold: true, size: 30),
                              Obx(() => Wrap(
                                spacing: width* 0.03,
                                children: List.generate(
                                  productsController.productInfoData[clickController.productIndex.value].productSize!.length, 
                                  (index){
                                    clickController.size.value = productsController.productInfoData.first.productSize![clickController.sizeTapIndex.value];
                                    return InkWell(
                                      onTap: (){
                                        clickController.sizeTapIndex.value = index;
                                        clickController.size.value = productsController.productInfoData.first.productSize![clickController.sizeTapIndex.value];
                                      },
                                      child: Container(
                                        height: height * 0.05,
                                        width: height * 0.05,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: (clickController.sizeTapIndex.value == index) ? AppColor.secondaryColor : Colors.transparent,
                                          border: Border.all(color: Colors.black,width: width * 0.002),
                                          borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth)*20)),
                                        ),
                                        child: FittedBox(
                                          child: Text(
                                            productsController.productInfoData[clickController.productIndex.value].productSize![index],
                                            style: GoogleFonts.aBeeZee(
                                              fontSize: (width/Screen.designWidth) * 30,
                                              color: (clickController.sizeTapIndex.value == index) ? Colors.white : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                ),
                              )),
                            ],
                          )
                          : Container(),
                        const Divider(color: Colors.grey),
                        SizedBox(height: height* 0.02),
                          Text("Reviews & Comments",
                            style: GoogleFonts.aBeeZee(
                              fontSize: (width/Screen.designWidth) * 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("What people thinks about this product",
                            style: GoogleFonts.aBeeZee(
                              fontSize: (width/Screen.designWidth) * 30,
                              fontWeight: FontWeight.w400,
                            ),
                          ), 
                          FutureBuilder(
                            future: commentsViewModel.getUsersComments(), 
                            builder: (context, AsyncSnapshot<List<CommentsModel>> snapshot) {
                              if(snapshot.hasData){
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: commentsViewModel.comments.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return (productsController.productInfoData[0].id != snapshot.data![index].postId) ? Container() :
                                    Card(
                                      color: Colors.white,
                                      child: ListTile(
                                        leading: Container(
                                          height : height * 0.05,
                                          width: height * 0.05,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: (index%2==0) ? Colors.blue : (index%3==0) ? Colors.green : Colors.pink,
                                            shape: BoxShape.circle,
                                          ),  
                                          child: Text(snapshot.data![index].name.toString()[0].toUpperCase(),
                                            style: TextStyle(
                                              fontSize: (width/Screen.designWidth)*30,
                                              color: Colors.white,
                                            ),
                                          ),          
                                        ),
                                        title: Text(snapshot.data![index].name.toString(),
                                          style: TextStyle(
                                            fontSize: (width/Screen.designWidth)*30,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        subtitle: ExpandableText(snapshot.data![index].body.toString(),
                                          style: TextStyle(
                                            fontSize: (width/Screen.designWidth)*25,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ), 
                                          maxLines: 3,
                                          expandText: 'Show more',
                                          collapseText: 'Show Less',
                                          linkColor: AppColor.primaryColor,
                                        ),    
                                      ),
                                    );
                                  },
                                );
                              }
                              else{
                                return Center(
                                  child: Text("Loading...",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: (width/Screen.designWidth) * 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                          const Divider(color: Colors.grey),
                          SizedBox(height: height* 0.02),
                          Text("Rate this product",
                            style: GoogleFonts.aBeeZee(
                              fontSize: (width/Screen.designWidth) * 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("Share your feelings with others",
                            style: GoogleFonts.aBeeZee(
                              fontSize: (width/Screen.designWidth) * 30,
                              fontWeight: FontWeight.w400,
                            ),
                          ), 
                          Wrap(
                            spacing: width* 0.03,
                            children: List.generate(
                              5, 
                              (index) => Obx(() => InkWell(
                                onTap: (){
                                  int pressedIndex = index+1;
                                  if(clickController.productRating.value == pressedIndex){
                                    clickController.productRating.value = 0;
                                  }
                                  else{
                                    clickController.productRating.value = pressedIndex;
                                  }
                                },
                                child: Container(
                                  height: height * 0.04,
                                  width: height * 0.04,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    //border: Border.all(color: Colors.black,width: width * 0.002),
                                    borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth)*20)),
                                  ),
                                  child: FittedBox(
                                    child: Icon(
                                      (index+1 <= clickController.productRating.value) ? Icons.star : Icons.star_border,
                                      color: (index+1 <= clickController.productRating.value) ? Colors.yellow : Colors.black,
                                    ),
                                  ),
                                ),
                              ),),
                            ),
                          ),
                          SizedBox(height: height * 0.02),
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  height: height * 0.06,
                                  width: width * 1,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth) * 50)),
                                  ),
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                                    child: TextFormField(
                                      controller: reviewAndComments,
                                      decoration: InputDecoration(
                                        focusedBorder: InputBorder.none,
                                        border: InputBorder.none,
                                        hintText: "Describe your experience",
                                        hintStyle: TextStyle(
                                          fontSize: (width/Screen.designWidth) * 30,
                                        ),
                                        icon: Icon(Icons.comment,color: AppColor.iconBackground),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: width* 0.02),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: height * 0.05,
                                  decoration: BoxDecoration(
                                    color: Colors.pink,
                                    borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth)*50)),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                                    child: FittedBox(
                                      child: Text("Comment",
                                        style: TextStyle(
                                          fontSize: (width/Screen.designWidth) * 30,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        SizedBox(height: height * 0.02),
                        (productsController.productInfoCatgory.isNotEmpty) ? Text("Related Products For You",
                          style: GoogleFonts.aBeeZee(
                            fontSize: (width/Screen.designWidth) * 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ) : Container(),
                        GridView.builder(
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: width * 0.005,
                            mainAxisSpacing: height * 0.020,
                            childAspectRatio: width / (height / 1.3),
                          ), 
                          itemCount: productsController.productInfoCatgory.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            if (productsController.productInfoData[0].id == productsController.productInfoCatgory[index].id){
                              return Container();
                            }
                            else{
                              return InkWell(
                                onTap: (){
                                  productsController.filterProductInfo(productsController.productInfoCatgory[index].id);
                                  productsController.filterProductInfoCategoryProducts(productsController.productsData[index].category,productsController.productInfoCatgory[index].id);
                                  setState(() {
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: width * 0.02),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular((width/Screen.designWidth) * 20)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        blurRadius: 2,
                                        spreadRadius: 2,
                                        offset: const Offset(2, 2),
                                      ),
                                    ]
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: height * 0.2,
                                        width: width * 1,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.1),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular((width/Screen.designWidth) * 20),
                                            topRight: Radius.circular((width/Screen.designWidth) * 20),
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage(productsController.productInfoCatgory[index].primaryImageUrl),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: height * 0.06,
                                        width: width * 1,
                                        color: Colors.transparent,
                                        margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                                        child: Text(
                                          productsController.productInfoCatgory[index].productName,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.aBeeZee(
                                            fontSize: (height / Screen.designHeight) * 8,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: height * 0.035,
                                        width: width * 1,
                                        //margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                                        color: Colors.transparent,
                                        child: Row(
                                          children: [
                                            Container(
                                              height: height * 0.035,
                                              width: width * 0.08,
                                              color: Colors.transparent,
                                              child: const Center(
                                                child: FittedBox(
                                                  child: Icon(Icons.star,color: Colors.yellow),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: width * 0.01),
                                            Expanded(
                                              child: CustomText(text: '${productsController.productInfoCatgory[index].ratings.toString()} / 5', height: 0.035, width: 1, color: Colors.black, bold: false, size: 0.04)
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: height * 0.025,
                                        width: width * 1,
                                        color: Colors.transparent,
                                        margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: height * 0.025,
                                                alignment: Alignment.centerLeft,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: AppColor.primaryColor,
                                                    width: width * 0.005,
                                                  )
                                                ),
                                                child: FittedBox(
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                                                    child: Text(
                                                      (productsController.productInfoCatgory[index].deliveryCharge!=0) ? '৳ ${productsController.productsData[index].deliveryCharge.toString()}' : "Free Delivery",
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ),
                                            SizedBox(width: width * 0.01,),
                                            Expanded(
                                              child: Container(
                                                height: height * 0.025,
                                                margin: EdgeInsets.only(right: width * 0.06),
                                                alignment: Alignment.centerLeft,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.deepOrange,
                                                    width: width * 0.005,
                                                  )
                                                ),
                                                child: FittedBox(
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                                                    child: const Text(
                                                      "Get Coins",
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: height * 0.035,
                                        width: width * 1,
                                        color: Colors.transparent,
                                        margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: height * 0.3,
                                                margin: EdgeInsets.only(right: width * 0.06),
                                                alignment: Alignment.centerLeft,  
                                                child: FittedBox(
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                                                    child: Text(
                                                      '৳ ${productsController.productInfoCatgory[index].price.toString()}',
                                                      maxLines: 1,
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: height * 0.3,
                                                margin: EdgeInsets.only(right: width * 0.06),
                                                alignment: Alignment.centerLeft,  
                                                child: FittedBox(
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                                                    child: Text(
                                                      (productsController.productInfoCatgory[index].oldPrice !=0) ? '৳ ${productsController.productsData[index].oldPrice.toString()}' : "",
                                                      maxLines: 1,
                                                      style: const TextStyle(
                                                        color: Colors.red,
                                                        decoration: TextDecoration.lineThrough,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(height: height * 0.02),
                        Center(
                          child: Text("You've reached at the end.",
                          textAlign: TextAlign.center,
                            style: GoogleFonts.aBeeZee(
                              fontSize: (width/Screen.designWidth) * 25,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Center(
                          child: Text("Do a search for keep exploring!",
                            style: GoogleFonts.aBeeZee(
                              fontSize: (width/Screen.designWidth) * 25,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}