import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


void main() {
  runApp(MyApp());
}
Color kPrimaryColor = Color(0xFFEC407A);
Color kStarsColor = Color(0xFFFFA726);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.catamaranTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: Flowershop(),
    );
  }
}

class FlowerDetail extends StatelessWidget {

  final Flower flower;

  FlowerDetail({@required this.flower});

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [

          Container(
            child: Hero(
              tag: flower.title,
              child: Image.asset(
                  flower.image,
                  fit: BoxFit.fitWidth
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 48, left: 32,),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * 0.5,
              padding: EdgeInsets.only(top: 64),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(right: 32, left: 32, bottom: 16,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [

                          Text(
                            flower.title,
                            style: GoogleFonts.catamaran(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              height: 1,
                            ),
                          ),

                          Text(
                            flower.country.fullname,
                            style: GoogleFonts.catamaran(
                              fontSize: 18,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [

                                Row(
                                  children: <Widget>[

                                    Icon(Icons.star, size: 20, color: kStarsColor,),
                                    Icon(Icons.star, size: 20, color: kStarsColor,),
                                    Icon(Icons.star, size: 20, color: kStarsColor,),
                                    Icon(Icons.star, size: 20, color: kStarsColor,),
                                    Icon(Icons.star_half, size: 20, color: kStarsColor,),

                                  ],
                                ),

                                SizedBox(
                                  width: 12,
                                ),

                                Text(
                                  flower.score,
                                  style: GoogleFonts.catamaran(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),
                          ),

                          Expanded(
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Text(
                                flower.description,
                                style: GoogleFonts.catamaran(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),

                  Container(
                    height: 100,
                    width: size.width,
                    padding: EdgeInsets.only(top: 16, left: 32, right: 32, bottom: 32,),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [

                        Container(
                          width: size.width / 1 - 80,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: kPrimaryColor.withOpacity(0.4),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Sipariş Ver",
                                  style: GoogleFonts.catamaran(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 32, bottom: (size.height * 0.5) - (75 / 2)),
              child: Card(
                elevation: 4,
                margin: EdgeInsets.all(0),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(flower.country.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Flowershop extends StatefulWidget {
  @override
  _FlowershopState createState() => _FlowershopState();
}

class _FlowershopState extends State<Flowershop> {

  List<Filter> filters = getFilterList();
  Filter selectedFilter;

  List<NavigationItem> navigationItems = getNavigationItemList();
  NavigationItem selectedItem;

  List<Flower> flowers = getFlowerList();
  List<Country> countrys = getCountryList();

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedFilter = filters[0];
      selectedItem = navigationItems[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        brightness: Brightness.light,
        leading: Icon(
          Icons.sort,
          color: kPrimaryColor,
          size: 28,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16,),
            child: Icon(
              Icons.search,
              color: Colors.grey[400],
              size: 28,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Container(
            padding: EdgeInsets.only(top: 16, left: 16, right: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(40),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 8,
                  blurRadius: 12,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  "Çiçekler",
                  style: GoogleFonts.courgette(
                    fontWeight: FontWeight.w900,
                    fontSize: 40,
                    height: 1,
                  ),
                ),

                SizedBox(
                  height: 16,
                ),

                Padding(
                  padding: EdgeInsets.only(right: 75),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: buildFilters(),
                  ),
                ),

              ],
            ),
          ),

          Expanded(
            child: Container(
              child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: buildFlowers(),
              ),
            ),
          ),

          Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [

                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text(
                        "Ülkeler",
                        style: GoogleFonts.courgette(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  height: 100,
                  margin: EdgeInsets.only(bottom: 16),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: buildCountrys(),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.pink.withOpacity(0.2),
              spreadRadius: 8,
              blurRadius: 12,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: buildNavigationItems(),
        ),
      ),
    );
  }

  List<Widget> buildFilters(){
    List<Widget> list = [];
    for (var i = 0; i < filters.length; i++) {
      list.add(buildFilter(filters[i]));
    }
    return list;
  }

  Widget buildFilter(Filter item){
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = item;
        });
      },
      child: Container(
        height: 50,
        child: Stack(
          children: <Widget>[

            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: 30,
                height: 3,
                color: selectedFilter == item ? kPrimaryColor : Colors.transparent,
              ),
            ),

            Center(
              child: Text(
                item.name,
                style: GoogleFonts.catamaran(
                  color: selectedFilter == item ? kPrimaryColor : Colors.indigo[400],
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

  List<Widget> buildFlowers(){
    List<Widget> list = [];
    for (var i = 0; i < flowers.length; i++) {
      list.add(buildFlower(flowers[i], i));
    }
    return list;
  }

  Widget buildFlower(Flower flower, int index){
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FlowerDetail(flower: flower)),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 32, left: index == 0 ? 16 : 0, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.lime.withOpacity(0.5),
                      spreadRadius: 8,
                      blurRadius: 12,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                margin: EdgeInsets.only(bottom: 16, top: 24,),
                child: Hero(
                  tag: flower.title,
                  child: Image.asset(
                    flower.image,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),

            Text(
              flower.title,
              style: GoogleFonts.catamaran(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              flower.country.fullname,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),

          ],
        ),
      ),
    );
  }

  List<Widget> buildCountrys(){
    List<Widget> list = [];
    for (var i = 0; i < countrys.length; i++) {
      list.add(buildCountry(countrys[i], i));
    }
    return list;
  }

  Widget buildCountry(Country country, int index){
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(right: 16, left: index == 0 ? 16 : 0),
      width: 255,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          Card(
            elevation: 4,
            margin: EdgeInsets.all(0),
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(country.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          SizedBox(
            width: 12,
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                country.fullname,
                style: GoogleFonts.catamaran(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Row(
                children: [

                  Icon(
                    Icons.library_books,
                    color: Colors.grey,
                    size: 14,
                  ),

                  SizedBox(
                    width: 8,
                  ),

                  Text(
                    country.flowers.toString() + " bitki türü  ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ],
              ),

            ],
          ),

        ],
      ),
    );
  }

  List<Widget> buildNavigationItems(){
    List<Widget> list = [];
    for (var navigationItem in navigationItems) {
      list.add(buildNavigationItem(navigationItem));
    }
    return list;
  }

  Widget buildNavigationItem(NavigationItem item){
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedItem = item;
        });
      },
      child: Container(
        width: 50,
        child: Center(
          child: Icon(
            item.iconData,
            color: selectedItem == item ? kPrimaryColor : Colors.grey[400],
            size: 28,
          ),
        ),
      ),
    );
  }

}
class NavigationItem {

  IconData iconData;

  NavigationItem(this.iconData);

}

List<NavigationItem> getNavigationItemList(){
  return <NavigationItem>[
    NavigationItem(Icons.home),
    NavigationItem(Icons.shopping_bag),
    NavigationItem(Icons.person),
  ];
}

class Flower {

  String title;
  String description;
  Country country;
  String score;
  String image;

  Flower(this.title, this.description, this.country, this.score, this.image);

}

List<Flower> getFlowerList(){
  return <Flower>[
    Flower(
      "Manolya",
      "Manolya çiçeği, çok hoş bir kokuya sahip olan, oval ve yaprakları kaba bir görünümü bulunan bir çiçektir. Manolya çiçeği, çeşit olarak iki türlü olarak ayrılmaktadır. Manolya çiçeği, her mevsim yeşil rengini koruyabilen nadir bitkiler arasında yerini almaktadır.",
      Country(
        "Asya ,Amerika ,Türkiye",
        1,
        "assets/country/world1.jpg",
      ),
      "4.28",
      "assets/flowers/magnolia.jpg",
    ),
    Flower(
      "Orkide",
      "Orkide, yapılan araştırmalara göre dünyada en sevilen çiçekler arasında birinci, en çok satılanlar arasında ise ikinci sırada yer almaktadır. Çok yıllık bitkiler olarak bilinir. Her yıl düzenli olarak çiçek açan bu bitki bazı durumlarda ise yılda iki üç kez çiçek açabilir. Orkideler bu özellikleri nedeniyle ilk keşfedildikleri andan itibaren sürekli ilgi odağıdır. Çiçek olmasının yanı sıra, Maraş dondurması ve salebin de tadının kaynağıdır.",
      Country(
        "Asya ,Avrupa ,Amerika ",
        1,
        "assets/country/world1.jpg",
      ),
      "4.8",
      "assets/flowers/pembe-orkide.jpg",
    ),
    Flower(
      "Lale",
      "Lale renk renk çeşitleri olan bir süs bitkisidir. Anavatanı Asya olmasına rağmen Türkiye’de daha yaygınlaşmış ve geliştirilmiştir. Özellikle Osmanlı zamanında büyük önem kazanmıştır. Lale, soğandan yetişir. Toprağının fazlasıyla gübreli olması gerekir.",
      Country(
        "Türkiye ,Asya ",
        1,
        "assets/country/world1.jpg",
      ),
      "4.14",
      "assets/flowers/lale.jpg",
    ),
    Flower(
      "Begonya",
      "Evde bakılabilecek süs bitkilerinden bahsedilecekse, begonya akıllara ilk gelen çiçeklerden birisidir. Yapısı gereği ılıman iklim koşullarına uygun bir bitki olduğundan evlerde yetiştirilmeye oldukça müsaittir. Çiçeklere karşı ilgisi olan ve evinde süs bitkisi yetiştirmeyi seven kişilerin vazgeçilmezi olan begonya, kış ayları başta olmak üzere her mevsimde çiçek vermektedir.",
      Country(
        "Asya, Güney Amerika ve Brezilya",
        1,
        "assets/country/world1.jpg",
      ),
      "4.14",
      "assets/flowers/begonyalar.jpg",
    ),
    Flower(
      "Colorado columbine",
      "‘Amerika’nda Rocky Mountains (Rocky dağları)’da yetişen bu çiçek, Colorado’nun 4500 metre yüksekliğindeki dağına tırmanan dağcılarını ‘Hoş geldin ödülü’ diye bahsediliyor bu çiçekten. Doğalarından koparılan bu çiçeğin tanesinin fiyatı 50 dolara kadar çıkabiliyormuş.",
      Country(
        "Amerika",
        1,
        "assets/country/world1.jpg",
      ),
      "4.14",
      "assets/flowers/colorado-columbine.jpg",
    ),
    Flower(
      "Gül",
      "Masalla gerçeği birleştiren bir eserdir. Geçmişi temsil eden dede ile geleceği temsil eden çocuk arasında dramatik bir ilişki kurarak insan duygu ve düşüncelerine kendine has yorumlar getirilir. Adı eserde hiç geçmeyen çocuğun saf ve temiz dünyasından, hayatın acı ve çıplak gerçeğine uzanan bir roman kurgusu meydana çıkarılır. Aytmatov’un, edebiyat âleminde geniş akisler uyandıran, uzun yıllar tartışılan, verilmek istenen mesajla yaratılan tiplerin büyük bir uyum sağladığı eserlerinden biridir.",
      Country(
        "Türkiye ,Hollanda ,İran ,Çin ",
        1,
        "assets/country/world1.jpg",
      ),
      "4.20",
      "assets/flowers/gül.jpg",
    ),
    Flower(
      "Lotus çiçeği",
      "Lotus çiçeği bir su bitkisidir. Suyun yüzeyinde, toprak gereksinimi olmadan yaşar. Tertemiz yaprakları ve güzel çiçeği ile bulunduğu kirli sularda hemen belli eder kendini. Hem duygusal hem de madden fayda sağlayan bir bitkidir. Eşi ve benzeri olmayan bir çiçektir anlayacağınız.",
      Country(
        "Hindistan",
        1,
        "assets/country/world1.jpg",
      ),
      "4.14",
      "assets/flowers/lotus_çiçeği.jpg",
    ),
    Flower(
      "İstanbul Kardeleni",
      "Nergisgiller (Amaryllidaceae) familyasından Türkiye'de endemik olan bir kardelen alt türü. Türkiye'de doğal olarak İstanbul'la birlikte Bolu, Bursa ve Kırklareli'de bulunur. Göknar ve kayın ormanları kenarında görülür. Ocak-Nisan ayları çiçeklenme dönemidir. ",
      Country(
        "Türkiye",
        1,
        "assets/country/world1.jpg",
      ),
      "4.52",
      "assets/flowers/istanbul_kardeleni.jpg",
    ),
    Flower(
      "Ortanca çiçeği",
      "Ortanca çiçeği: Anayurdu Japonya olan ortanca, gösterişli çiçekleri nedeniyle Dünyanın birçok yerinde yaygın olarak yetiştirilen, 1-3 metre arası boylanabilen, kışın yapraklarını döken, çalı gövdeli bir süs bitkisidir bilinen 80 kadar doğal türü vardır.",
      Country(
        "Japonya ,Çin",
        1,
        "assets/country/world1.jpg",
      ),
      "4.14",
      "assets/flowers/ortanca_cicegi.jpg",
    ),
    Flower(
      "Müge çiçeği",
      "Müge Bitkisi Avrupa ülkelerinde Lily of the valley Türkiye’de ayrıca İnci Çiçeği olarak bilinir. Kuzey yarım kürenin ılıman iklimli tüm bölgelerinde yaygın olarak yetişebilmektedir. Özellikle yurt dışında yeni evlenen çiftler uğur getirdiği ve güzel kokusundan dolayı gelin çiçeği olarak tercih edilmektedir.Ayrıca parfümeride yaygın olarak kullanılmaktadır.",
      Country(
        "Avrupa ,Türkiye",
        1,
        "assets/country/world1.jpg",
      ),
      "4.24",
      "assets/flowers/muge_cicegi.jpg",
    ),
  ];
}

class Country {

  String fullname;
  int flowers;
  String image;

  Country(this.fullname, this.flowers, this.image);

}

List<Country> getCountryList(){
  return <Country>[
    Country(
      "Türkiye",
      5,
      "assets/country/world1.jpg",
    ),
    Country(
      "Asya",
      4,
      "assets/country/world1.jpg",
    ),
    Country(
      "Güney Amerika",
      1,
      "assets/country/world1.jpg",
    ),
    Country(
      "Brezilya",
      1,
      "assets/country/world1.jpg",
    ),
    Country(
      "Amerika",
      3,
      "assets/country/world1.jpg",
    ),
    Country(
      "Hindistan",
      1,
      "assets/country/world1.jpg",
    ),
    Country(
      "Japonya",
      1,
      "assets/country/world1.jpg",
    ),
    Country(
      "Avrupa",
      2,
      "assets/country/world1.jpg",
    ),
    Country(
      "Çin",
      2,
      "assets/country/world1.jpg",
    ),
    Country(
      "Hollanda",
      1,
      "assets/country/world1.jpg",
    ),
    Country(
      "İran",
      1,
      "assets/country/world1.jpg",
    ),

  ];
}

class Filter {

  String name;

  Filter(this.name);

}

List<Filter> getFilterList() {
  return <Filter>[
    Filter("ÇİÇEK"),
    Filter("HEDİYE"),
    Filter("SEPETİM"),
  ];
}

