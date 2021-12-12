import 'package:almajidoud/Base/Shimmer/list_shimmer.dart';
import 'package:almajidoud/Bloc/Order_Bloc/order_bloc.dart';
import 'package:almajidoud/Model/OrderMode/order_model.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/orders/widgets/no_orders_widget.dart';
import 'package:almajidoud/screens/orders/widgets/orders_header.dart';
import 'package:almajidoud/screens/orders/widgets/single_order_item.dart';
import 'package:almajidoud/utils/file_export.dart';
class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}
class _OrdersScreenState extends State<OrdersScreen> {

  @override
  void initState() {
    orderBloc.add(GetAllOrderEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: PageContainer(
        child: Scaffold(

          body: WillPopScope(
            onWillPop: (){
              customAnimatedPushNavigation(context, CustomCircleNavigationBar(page_index: 4,));
            },
            child: Directionality(
              textDirection: translator.activeLanguageCode =='ar'? TextDirection.rtl : TextDirection.ltr,
              child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ScreenAppBar(
                        right_icon: 'cart',
                        category_name: translator.translate("My Orders" ),
                        screen: CustomCircleNavigationBar(page_index: 2,),

                      ),
//              noOrdersWidget(context: context)

                      Container(
                          height: height(context)*.85,
                          child: BlocBuilder(
                            bloc: orderBloc,
                            builder: (context,state){
                              if(state is Loading){
                                return ListShimmer(
                                  type: 'horizontal',
                                );
                              }else if(state is Done){
                                return StreamBuilder<AllOrdersModel>(
                                    stream: orderBloc.all_orders_subject,
                                    builder: (context,snapshot){
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.none:
                                          print("1");
                                          return ListShimmer(
                                            type: 'horizontal',
                                          );
                                        case ConnectionState.done:
                                          print("1");
                                          return Text('');
                                        case ConnectionState.waiting:
                                          print("2");
                                          return ListShimmer(
                                            type: 'horizontal',
                                          );
                                        case ConnectionState.active:
                                          print("3");
                                          if (snapshot.hasError) {
                                            print("4");
                                            print(snapshot.error.toString());
                                            return Center(
                                              child: Text(snapshot.error.toString()),
                                            );
                                          }
                                          else if (snapshot.data.items.length > 0) {
                                            print("5");
                                            return  ListView.builder(
                                              padding: EdgeInsets.zero,
                                              itemCount: snapshot.data.items.length ,
                                              shrinkWrap: true,
                                              //     physics: NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return singleOrderItem(
                                                    context: context,
                                                    order: snapshot.data.items[index]);
                                              },
                                            );
                                          }
                                          else
                                            return  noOrdersWidget(
                                                context: context
                                            );
                                      }
                                    });
                              }else if(state is ErrorLoading){
                                return no_data_widget(context: context);
                              }
                            },
                          )
                      ),

                    ],
                  )
              ),
            ),
          )
        ),
      ),
    );
  }
}
