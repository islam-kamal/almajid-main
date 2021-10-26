class HomeScreenModel {
  List<HorizonLayout> horizonLayout;
  Setting setting;
  List<TabBar> tabBar;
  List<String> searchSuggestion;
  OnBoarding onBoarding;

  HomeScreenModel(
      {this.horizonLayout,
        this.setting,
        this.tabBar,
        this.searchSuggestion,
        this.onBoarding});

  HomeScreenModel.fromJson(Map<String, dynamic> json) {
    if (json['HorizonLayout'] != null) {
      horizonLayout = new List<HorizonLayout>();
      json['HorizonLayout'].forEach((v) {
        horizonLayout.add(new HorizonLayout.fromJson(v));
      });
    }
    setting =
    json['Setting'] != null ? new Setting.fromJson(json['Setting']) : null;
    if (json['TabBar'] != null) {
      tabBar = new List<TabBar>();
      json['TabBar'].forEach((v) {
        tabBar.add(new TabBar.fromJson(v));
      });
    }
    searchSuggestion = json['searchSuggestion'].cast<String>();
    onBoarding = json['OnBoarding'] != null
        ? new OnBoarding.fromJson(json['OnBoarding'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.horizonLayout != null) {
      data['HorizonLayout'] =
          this.horizonLayout.map((v) => v.toJson()).toList();
    }
    if (this.setting != null) {
      data['Setting'] = this.setting.toJson();
    }
    if (this.tabBar != null) {
      data['TabBar'] = this.tabBar.map((v) => v.toJson()).toList();
    }
    data['searchSuggestion'] = this.searchSuggestion;
    if (this.onBoarding != null) {
      data['OnBoarding'] = this.onBoarding.toJson();
    }
    return data;
  }
}

class HorizonLayout {
  String layout;
  bool showMenu;
  bool showSearch;
  bool showLogo;
  String type;
  bool wrap;
  int size;
  int radius;
  List<Items> items;
  bool isSlider;
  bool autoPlay;
  bool showNumber;
  String design;
  bool showBackGround;
  String name;
  String image;
  int category;
  bool isSnapping;
  int limit;

  HorizonLayout(
      {this.layout,
        this.showMenu,
        this.showSearch,
        this.showLogo,
        this.type,
        this.wrap,
        this.size,
        this.radius,
        this.items,
        this.isSlider,
        this.autoPlay,
        this.showNumber,
        this.design,
        this.showBackGround,
        this.name,
        this.image,
        this.category,
        this.isSnapping,
        this.limit});

  HorizonLayout.fromJson(Map<String, dynamic> json) {
    layout = json['layout'];
    showMenu = json['showMenu'];
    showSearch = json['showSearch'];
    showLogo = json['showLogo'];
    type = json['type'];
    wrap = json['wrap'];
    size = json['size'];
    radius = json['radius'];
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    isSlider = json['isSlider'];
    autoPlay = json['autoPlay'];
    showNumber = json['showNumber'];
    design = json['design'];
    showBackGround = json['showBackGround'];
    name = json['name'];
    image = json['image'];
    category = json['category'];
    isSnapping = json['isSnapping'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['layout'] = this.layout;
    data['showMenu'] = this.showMenu;
    data['showSearch'] = this.showSearch;
    data['showLogo'] = this.showLogo;
    data['type'] = this.type;
    data['wrap'] = this.wrap;
    data['size'] = this.size;
    data['radius'] = this.radius;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    data['isSlider'] = this.isSlider;
    data['autoPlay'] = this.autoPlay;
    data['showNumber'] = this.showNumber;
    data['design'] = this.design;
    data['showBackGround'] = this.showBackGround;
    data['name'] = this.name;
    data['image'] = this.image;
    data['category'] = this.category;
    data['isSnapping'] = this.isSnapping;
    data['limit'] = this.limit;
    return data;
  }
}

class Items {
  int category;
  String image;
  List<String> colors;
  bool originalColor;
  String label;
  int padding;
  int product;
  String coupon;
  int radius;

  Items(
      {this.category,
        this.image,
        this.colors,
        this.originalColor,
        this.label,
        this.padding,
        this.product,
        this.coupon,
        this.radius});

  Items.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    image = json['image'];
    colors = json['colors'].cast<String>();
    originalColor = json['originalColor'];
    label = json['label'];
    padding = json['padding'];
    product = json['product'];
    coupon = json['coupon'];
    radius = json['radius'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['image'] = this.image;
    data['colors'] = this.colors;
    data['originalColor'] = this.originalColor;
    data['label'] = this.label;
    data['padding'] = this.padding;
    data['product'] = this.product;
    data['coupon'] = this.coupon;
    data['radius'] = this.radius;
    return data;
  }
}

class Setting {
  String mainColor;
  String fontFamily;
  String productListLayout;
  bool stickyHeader;
  bool showChat;

  Setting(
      {this.mainColor,
        this.fontFamily,
        this.productListLayout,
        this.stickyHeader,
        this.showChat});

  Setting.fromJson(Map<String, dynamic> json) {
    mainColor = json['MainColor'];
    fontFamily = json['FontFamily'];
    productListLayout = json['ProductListLayout'];
    stickyHeader = json['StickyHeader'];
    showChat = json['ShowChat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MainColor'] = this.mainColor;
    data['FontFamily'] = this.fontFamily;
    data['ProductListLayout'] = this.productListLayout;
    data['StickyHeader'] = this.stickyHeader;
    data['ShowChat'] = this.showChat;
    return data;
  }
}

class TabBar {
  String layout;
  String icon;
  int pos;
  String fontFamily;
  String key;
  String categoryLayout;
  int size;

  TabBar(
      {this.layout,
        this.icon,
        this.pos,
        this.fontFamily,
        this.key,
        this.categoryLayout,
        this.size});

  TabBar.fromJson(Map<String, dynamic> json) {
    layout = json['layout'];
    icon = json['icon'];
    pos = json['pos'];
    fontFamily = json['fontFamily'];
    key = json['key'];
    categoryLayout = json['categoryLayout'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['layout'] = this.layout;
    data['icon'] = this.icon;
    data['pos'] = this.pos;
    data['fontFamily'] = this.fontFamily;
    data['key'] = this.key;
    data['categoryLayout'] = this.categoryLayout;
    data['size'] = this.size;
    return data;
  }
}

class OnBoarding {
  List<Data> data;

  OnBoarding({this.data});

  OnBoarding.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String title;
  String image;
  String desc;
  String background;

  Data({this.title, this.image, this.desc, this.background});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
    desc = json['desc'];
    background = json['background'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['image'] = this.image;
    data['desc'] = this.desc;
    data['background'] = this.background;
    return data;
  }
}