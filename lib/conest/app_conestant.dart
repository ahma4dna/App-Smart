import 'package:shoapsmart_useers_laerm/moeals/catogeris_modeals.dart';
import 'package:shoapsmart_useers_laerm/services/image_manger.dart';

class AppConestant {
  static const String imageConst =
      'https://i.ibb.co/8r1Ny2n/20-Nike-Air-Force-1-07.png'; 
        static const String test ='https://storage.store.arriadagroup.com/images/products/2913/variants/5060/934153457650eb24d5cebe5.48022790___b77591109449ef901a2e0e93d2b2f1e2.webp';
  static List<String> imageBaners = [
    AssetsManager.banner1,
    AssetsManager.banner2,

  ];
  static List<CatogerisModeals> catogriesModels = [
    CatogerisModeals(name:'Phones' , image: AssetsManager.mobiles, id: AssetsManager.mobiles),
    CatogerisModeals(name:'Electronics' , image: AssetsManager.electronics, id: AssetsManager.electronics),
    CatogerisModeals(name:'Accessories' , image: AssetsManager.cosmetics, id: AssetsManager.cosmetics),
    CatogerisModeals(name:'Shoes' , image: AssetsManager.shoes, id: AssetsManager.shoes),
    CatogerisModeals(name:'Book' , image: AssetsManager.book, id: AssetsManager.shoes),
    CatogerisModeals(name:'Laptops' , image: AssetsManager.pc, id: AssetsManager.shoes),
    CatogerisModeals(name:'Watch' , image: AssetsManager.watch, id: AssetsManager.shoes),
    CatogerisModeals(name:'Shop' , image: AssetsManager.fashion, id: AssetsManager.shoes),

  ];
}
