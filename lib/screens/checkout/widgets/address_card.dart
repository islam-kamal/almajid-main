import 'package:almajidoud/utils/file_export.dart';

addressCard({BuildContext context}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Neumorphic(
        child: Container(
          decoration: BoxDecoration(
              color: whiteColor, borderRadius: BorderRadius.circular(8)),
          width: width(context) * .9,
          child: Column(
            children: [
              responsiveSizedBox(context: context, percentageOfHeight: .05),
              Row(
                children: [
                  Icon(Icons.location_on),
                  customDescriptionText(
                      context: context,
                      text: "Select Address",
                      fontWeight: FontWeight.bold,
                      percentageOfHeight: .024)
                ],
              ),
              Container(
                  width: width(context) * .85,
                  child: Divider(color: greyColor)),
              Container(
                width: width(context) * .85,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customDescriptionText(
                        context: context,
                        text: "City",
                        fontWeight: FontWeight.bold,
                        percentageOfHeight: .024),
                    Container(
                      width: width(context) * .4,
                      child: customDescriptionText(
                          context: context,
                          text: "London",
                          maxLines: 3,
                          textAlign: TextAlign.start,
                          textColor: greyColor),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: greyColor,
                    )
                  ],
                ),
              ),
              Container(
                  width: width(context) * .85,
                  child: Divider(color: greyColor)),
              Container(
                width: width(context) * .85,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customDescriptionText(
                        context: context,
                        text: "Neighbourhood",
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.start,
                        percentageOfHeight: .024),
                    Container(
                      width: width(context) * .4,
                      child: customDescriptionText(
                          context: context,
                          text: "99 George street",
                          maxLines: 3,
                          textColor: greyColor),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: greyColor,
                    )
                  ],
                ),
              ),
              Container(
                  width: width(context) * .85,
                  child: Divider(color: greyColor)),              Container(
                width: width(context) * .85,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customDescriptionText(
                        context: context,
                        text: "Phone Number",
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.start,
                        percentageOfHeight: .024),
                    Container(
                      width: width(context) * .4,
                      child: customDescriptionText(
                          context: context,
                          text: "99 George street",
                          maxLines: 3,
                          textColor: greyColor),
                    ),
                    Icon(
                      Icons.check_circle,
                      color: Colors.blue,
                    )
                  ],
                ),
              ),
              responsiveSizedBox(context: context, percentageOfHeight: .05),

            ],
          ),
        ),
      ),
    ],
  );
}
