import 'package:almajidoud/Base/Shimmer/list_shimmer.dart';
import 'package:almajidoud/Base/Shimmer/shimmer_notification.dart';
import 'package:almajidoud/Bloc/Order_Bloc/order_bloc.dart';
import 'package:almajidoud/Model/OrderModel/order_model.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/orders/widgets/no_orders_widget.dart';
import 'package:almajidoud/screens/orders/widgets/orders_header.dart';
import 'package:almajidoud/screens/orders/widgets/single_order_item.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class OrdersScreen extends StatefulWidget {
  var increment_id;
  OrdersScreen({this.increment_id});
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
            onWillPop: ()async{
              customAnimatedPushNavigation(context, CustomCircleNavigationBar(page_index: 3,));
              return null!;
            },
            child: Directionality(
              textDirection: translator.activeLanguageCode =='ar'? TextDirection.rtl : TextDirection.ltr,
              child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ScreenAppBar(
                        right_icon: 'cart',
                        category_name: translator.translate("My Orders" ),
                        screen: CustomCircleNavigationBar(page_index: 4,),

                      ),

                      Container(
                          height: height(context)*.85,
                          child: BlocBuilder(
                            bloc: orderBloc,
                            builder: (context,state){
                              if(state is Loading){
                                return Padding(
                                  padding: EdgeInsets.only(top: width(context) * 0.4, ),
                                  child: Center(
                                    child: SpinKitFadingCube(
                                      color: Theme.of(context).primaryColor,
                                      size: width(context) * 0.1,
                                    ),
                                  ),
                                );
                              }else if(state is Done){
                                return StreamBuilder<AllOrdersModel>(
                                    stream: orderBloc.all_orders_subject,
                                    builder: (context,snapshot){
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.none:
                                          return Padding(
                                            padding: EdgeInsets.only(top: width(context) * 0.4, ),
                                            child: Center(
                                              child: SpinKitFadingCube(
                                                color: Theme.of(context).primaryColor,
                                                size: width(context) * 0.1,
                                              ),
                                            ),
                                          );
                                        case ConnectionState.done:
                                          return Text('');
                                        case ConnectionState.waiting:
                                          return Padding(
                                            padding: EdgeInsets.only(top: width(context) * 0.4, ),
                                            child: Center(
                                              child: SpinKitFadingCube(
                                                color: Theme.of(context).primaryColor,
                                                size: width(context) * 0.1,
                                              ),
                                            ),
                                          );
                                        case ConnectionState.active:
                                          if (snapshot.hasError) {
                                            return Center(
                                              child: Text(snapshot.error.toString()),
                                            );
                                          }
                                          else if (snapshot.data!.items!.length > 0) {
                                            return  ListView.builder(
                                              padding: EdgeInsets.zero,
                                              itemCount: snapshot.data!.items!.length ,
                                              shrinkWrap: true,
                                              //     physics: NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return singleOrderItem(
                                                    context: context,
                                                    order: snapshot.data!.items![index],
                                                order_increment_id: widget.increment_id);
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
                              return Container();
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
