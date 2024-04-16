'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "d4076930ab6dc9658c912300eab37671",
"assets/AssetManifest.bin.json": "4032651261da16d7885f300ca6b9be73",
"assets/AssetManifest.json": "60f7d3051054b5dfc6b83dfaab86f0f4",
"assets/assets/image/account_management.png": "d9853ab2f60ceb74787ff918bd788aab",
"assets/assets/image/add_category_icon.png": "7cee9fdd6f96df573ceedfa9c2dd6fb2",
"assets/assets/image/add_icon.png": "f61693d6e2e2953399fb258ffa859ad6",
"assets/assets/image/add_new_category.png": "01f35932fc049cde23f2eff86746ca88",
"assets/assets/image/att.png": "575c313d76581e9225442f808006ec3f",
"assets/assets/image/bar_code.png": "64d565a8d2a7ff22a3e867ad05ac9634",
"assets/assets/image/bar_code_generate.png": "91d56374d3f490e2109f4cd8aaa3a1c3",
"assets/assets/image/billing_section.png": "0d567dd6ffbe0742b890a76205acf045",
"assets/assets/image/brand.png": "100b97584131a10a2608becfbe336ae4",
"assets/assets/image/calender.png": "e57c98a6b2a8dcd8925210fca1cd624a",
"assets/assets/image/camera_thumbnail.png": "4eb6d8139dd49ed4e2e4ed22313e5fb8",
"assets/assets/image/cart.png": "c2957ef6f62ccde1c9676e4eb5f94e90",
"assets/assets/image/cart_icon.png": "e1e55a5675e507ff2470b8cd94312504",
"assets/assets/image/categories.png": "2685749bfbd3144e3ee31de0625f40d4",
"assets/assets/image/confirm_purchase.png": "b7b5dd94329cb3106da75cf01bc4fc55",
"assets/assets/image/coupon.png": "8e080da15f56c458965645144f9a211a",
"assets/assets/image/coupon_list_background.png": "6c4c613a33d67ffd293cd369bcb8eed8",
"assets/assets/image/coupon_list_icon.png": "4fdc8e54be7e0f7e8707aaa482fa8108",
"assets/assets/image/dashboard.png": "55dce9966dcb0e2e2f5a831e78c9bbc0",
"assets/assets/image/delete_icon.png": "a3eb4af0de35155fd50703d38db59779",
"assets/assets/image/dollar.png": "7d4bc24379e4a1d552de69351af56609",
"assets/assets/image/download.png": "0500cf33ed0d5eddb754fa59efef6f5e",
"assets/assets/image/download_format.png": "020bad45079fb7fbe562375501e33bad",
"assets/assets/image/drawer.png": "13f899d55d2840a56e78975c9ff192dd",
"assets/assets/image/edit_icon.png": "7e9acfda2c4e624d7e236ee76b96a552",
"assets/assets/image/empty_box.png": "8a8a81d5d53c0e66da254034f672f3ff",
"assets/assets/image/empty_cart.png": "ced282db6ad362c0187e1973ff84597e",
"assets/assets/image/english.png": "e667999048e9c8c5c5610d1d33908e52",
"assets/assets/image/filter_icon.png": "27d04cfa17deff340ba79679622986ba",
"assets/assets/image/guest.png": "15b61a6abf52c4050dab93df36752904",
"assets/assets/image/image_upload_logo.png": "00a3dcca019e6665bfdc728aa75d8221",
"assets/assets/image/import.png": "7fe684fda42c36ed64c2334b7e479378",
"assets/assets/image/import_export.png": "debed903463a96553a25eb6f39106ddb",
"assets/assets/image/instructor1.png": "eb1d3291e33b256f079589c1bede3d4c",
"assets/assets/image/instructor2.png": "a6a48e95fa3ae56572e8e808f93ba801",
"assets/assets/image/instructor3.png": "90d2926343ccb662ef28784302653918",
"assets/assets/image/instructor4.png": "9507b7c82f8e9bff487aa880cabc138f",
"assets/assets/image/instructor5.png": "4af32b25612e3dec9d873a692ff524c4",
"assets/assets/image/instructor6.png": "f64da3f4dc5f6b45e447de787f20e1e7",
"assets/assets/image/instructor7.png": "4ca5bed3d5e85991f3595d30a6536c88",
"assets/assets/image/instructor8.png": "153e33082bbaa151a2f298eff06e55bf",
"assets/assets/image/item.png": "022b00b84b5ec9742a60998d6e22c344",
"assets/assets/image/Language.png": "92d9289c7d0ebf44269fccee696cddb6",
"assets/assets/image/limited_stock.png": "a23a7aee8a8a10ea592b6f70d3b829bc",
"assets/assets/image/lock.png": "1dc98b7e6cc1dc406dc8b19b94cedc49",
"assets/assets/image/logo.png": "4f51d02acadd9507bac31ec3453f960d",
"assets/assets/image/logout.png": "69651d667a9441ee1d8e0da4b20e8c39",
"assets/assets/image/logo_marsa_with_name.png": "021702b2c41cbd0b8ef5117ecc2c2af4",
"assets/assets/image/logo_with_name.png": "021702b2c41cbd0b8ef5117ecc2c2af4",
"assets/assets/image/logo_with_name2222.png": "6be725ec1e03affe3606a4ca77df8b45",
"assets/assets/image/maintenance.png": "3cf6759b308c7c9731d5294f400038e1",
"assets/assets/image/my_account.png": "25d259dd03d7907e626dfb023f36aa2f",
"assets/assets/image/nav2.png": "eedc133a50ecb0f15a5a8cf493a5a13b",
"assets/assets/image/no_data_found.png": "3f54fcc4d56570b39bae22e8ab6eeb5f",
"assets/assets/image/no_internet.png": "bb8d725c9d0b01de82027c053d341204",
"assets/assets/image/people_icon.png": "c7fb22925bed73a4e12392f7d44da760",
"assets/assets/image/pie_chart.png": "38521199f186fc31bce462b37ed83cf0",
"assets/assets/image/placeholder.jpg": "81abc0d9b59a9aba9191102834f2d978",
"assets/assets/image/png_logo_with_name.png": "7259bb95658129e89132bfdf2c84cacd",
"assets/assets/image/pos.png": "de1dca29206dd4259e1c955142430b98",
"assets/assets/image/product.png": "67815ad4efa9e9f5ce85fe7de104d1bf",
"assets/assets/image/product_setup.png": "4910d5e81f8dfd4d7b1f9fd138975104",
"assets/assets/image/product_unit.png": "d43e1c006d43f85e7af5dee915eb749a",
"assets/assets/image/profile_place_holder.png": "95c544fee126e4166c6592c3a99612eb",
"assets/assets/image/request.png": "e2fb4878af93ca4d901fae794a10d700",
"assets/assets/image/revenue.png": "7cf6d5afceb07118c23e166f94e04f19",
"assets/assets/image/salary.png": "d342f34b64a6570cae179cdd1125c2b6",
"assets/assets/image/saudi.png": "a8615ee57d7ae4d13669a333001b6111",
"assets/assets/image/scanner.png": "118ff4bb270d313db2df7c07e99a7f09",
"assets/assets/image/scan_add_item.png": "82da029d6db601f5911b6e7c84877eb5",
"assets/assets/image/search_icon.png": "b73093b2e67190f5b002186c46b4e3c0",
"assets/assets/image/shop_icon.png": "39f0afaf3211e1e3c1e26dafce5c28e3",
"assets/assets/image/shop_setting_image.png": "98169ee8060785879937b69c08ab1371",
"assets/assets/image/stock.png": "f9d99c7530161ca75f13f154fe68f700",
"assets/assets/image/success.gif": "60720df441b1538b0ca1231120677fcb",
"assets/assets/image/upload.png": "0ac0793e994f170560b02467bfe9a958",
"assets/assets/language/ar.json": "20423739017406d26f01ac8f4d75d267",
"assets/assets/language/en.json": "93f83e945525bc3a117e75f6b1bb3d45",
"assets/FontManifest.json": "99aaff4ae746b0d49495e582fc8e3ce9",
"assets/fonts/Cairo-Regular.ttf": "5ccd08939f634db387c40d6b4b0979c3",
"assets/fonts/MaterialIcons-Regular.otf": "eda3d46c3b21443770cc36e9542fb3cc",
"assets/images/animation.png": "5df34045f057cf09a593c877e5972a68",
"assets/images/apptopbar.png": "951d6b7333ba15df581e8136bc023972",
"assets/images/banner1.png": "b8433f7f76bb89997c026c6ca4dcfd0c",
"assets/images/banner2.png": "a382e68544826dc8b5bee63507c25d61",
"assets/images/bannerui.png": "21e715589f7dd935db91089a26b9e226",
"assets/images/bazar/addpayment.png": "975007a2e38ae4fc0338523be7564a1e",
"assets/images/bazar/badge.png": "70757a26f7323b3276547b2f9496db2a",
"assets/images/bazar/banner1.png": "286b028675e8d4d3eaa0843533132412",
"assets/images/bazar/bkash.png": "a378942295e170748c2da221b7d389c3",
"assets/images/bazar/cat1.png": "495b25352a7d9936cda3ee2d00cf5acd",
"assets/images/bazar/cat10.png": "8bf988ba9fb9406e5114f36af38974b8",
"assets/images/bazar/cat11.png": "5a92c2b75bb78dbb67e9b4fe3697749a",
"assets/images/bazar/cat12.png": "d60068aa31d27c651fdaf6eb5b008906",
"assets/images/bazar/cat13.png": "e8e336d702554bbf71df27f73849dc96",
"assets/images/bazar/cat14.png": "752303a0a8c1ac4333cfae0628fccf50",
"assets/images/bazar/cat15.png": "2cf2638237b860a7752634335107dc6f",
"assets/images/bazar/cat16.png": "7bc8b94502addc4e4e4aed4a2cca00d8",
"assets/images/bazar/cat17.png": "dd6de13737d34fb13b033c8616d3031e",
"assets/images/bazar/cat18.png": "e73144befd40e23f984041b604d3a672",
"assets/images/bazar/cat19.png": "8b93717cb7d95d1a73a565e692e4946a",
"assets/images/bazar/cat2.png": "0ff77f081f94f1e95c6790424dff77bf",
"assets/images/bazar/cat20.png": "12bbc2f4e6fd5be6762800b9be0466cb",
"assets/images/bazar/cat3.png": "5e0b044117012687d6c2ae67c5959e81",
"assets/images/bazar/cat4.png": "972b20e6a37afd31a7395f76440ea2b2",
"assets/images/bazar/cat5.png": "c9ba9d2856275cbd3d4e7b03d35177d4",
"assets/images/bazar/cat6.png": "e6449dcda52d7a9cfeec7b3b1b9beb4a",
"assets/images/bazar/cat7.png": "34015cb02813e18f5585434ac8ab36d3",
"assets/images/bazar/cat8.png": "6b6e5360b25aec7ff9a1609f1ac8b24b",
"assets/images/bazar/cat9.png": "7bc8b94502addc4e4e4aed4a2cca00d8",
"assets/images/bazar/check.png": "092bcc3d04138d18f0e00b98424f66a0",
"assets/images/bazar/drawer.png": "308765e91dab7ba1bd83e9c1c7984b34",
"assets/images/bazar/fb.png": "52e7ae0d97169264e4f6a3d75e96dbbf",
"assets/images/bazar/filter.png": "9f9d4925fe0299ec88107edac36054cd",
"assets/images/bazar/google.png": "b709e1f924460ace5cce127c289b22e7",
"assets/images/bazar/location.png": "8dd47d21f371b4baf2186da1c88accdf",
"assets/images/bazar/logo.png": "a90473b98a44122a39df4ff306d4544b",
"assets/images/bazar/method.png": "14854d046954533145a6eeb49d9f2cd4",
"assets/images/bazar/new1.png": "45d8e910d3e29a452de62f9c43b976ae",
"assets/images/bazar/new2.png": "96b4129ecf60cfc293a0bf2fca962d62",
"assets/images/bazar/new3.png": "0f1ebdd3fcb19e39d79a05631a1b6ada",
"assets/images/bazar/new4.png": "20e7aa311f4c2631863b013757e3e05d",
"assets/images/bazar/notification.png": "6113c26e2f515c56f1f30f9768220792",
"assets/images/bazar/onboard1.png": "e99e6cdb31f33e9a783b86723a696b60",
"assets/images/bazar/onboard2.png": "0885b31ca6a44844d5bc178907eb8954",
"assets/images/bazar/onboard3.png": "a2e06d149d7e2152156e9a610aa38f01",
"assets/images/bazar/p1.png": "418488c6850561e520e6c8e64c274f9e",
"assets/images/bazar/p2.png": "31f0795e97d4eab790fc80a23fd74eb0",
"assets/images/bazar/p3.png": "3f7c08d1927b8f64a70fb79b95c37771",
"assets/images/bazar/p4.png": "0f065729daf0c69183d19ced849b982e",
"assets/images/bazar/p5.png": "51e64213d7420580c8324df79fc0e03a",
"assets/images/bazar/p6.png": "8f0e91b6adcaeed4aef7f5c10364bc79",
"assets/images/bazar/paypal.png": "33d4fa089ddfb578bd54200fa09c49e5",
"assets/images/bazar/paytm.png": "77f9d5fba2a1b5dca842c5884b4ff36a",
"assets/images/bazar/pd1.png": "2d325aedd55903089e875771a5bb5715",
"assets/images/bazar/round_logo.png": "8ef2b0156076410729d28de9ef8858f2",
"assets/images/bazar/ssl.png": "82e99ad8d2416551c8905b7b0bee8713",
"assets/images/bazar/stripe.png": "2da62d9d9475764ea4da49735db90ac6",
"assets/images/button.png": "0a79b8321fdd00217bd2f18c1e189a03",
"assets/images/datatable.png": "5350511b555fe4c7daeed04e430bd87c",
"assets/images/delivery/active.png": "bc6c4ed72ca24c20788a32634fd06ff3",
"assets/images/delivery/bg.png": "3b278c1ae661c74652f662cbcbd823dd",
"assets/images/delivery/callprofile.png": "001f649eb808b30a941230eac8f7932b",
"assets/images/delivery/complete.png": "cd0ebce2c659072dda4bfdf64c9a115d",
"assets/images/delivery/done.png": "40ad60d6f5fbe67dac9dcdfdc61e735e",
"assets/images/delivery/editpicicon.png": "1aa70327c0093b85d4cfb1860acccb0f",
"assets/images/delivery/location.png": "94ee80d04b3a7abcd7a7330818fcf1ad",
"assets/images/delivery/logo.png": "67a909a7f262cfa913da3ce766a758d1",
"assets/images/delivery/logo_main.png": "535512aca6783fd5cb7e939cd860638e",
"assets/images/delivery/map.png": "233c94a5e62aaef517a562827f914aa1",
"assets/images/delivery/notification.png": "8cd76d97405ece3684f47ddd3dc67bfc",
"assets/images/delivery/onboard1.png": "7c68179501cc3887b1bb2eb3b113fda8",
"assets/images/delivery/onboard2.png": "58de6508617304874ff1907e6aa25614",
"assets/images/delivery/onboard3.png": "5623a1fa3394325adee8a4f20f0d395a",
"assets/images/delivery/pending.png": "f825131bb9740d012fcd1b34dab73fb6",
"assets/images/delivery/person.jpg": "a557b51c9e58fdf44b0f094307473c67",
"assets/images/delivery/profile.png": "2e485d4a155ba5f8d0016a5b9992979a",
"assets/images/delivery/profile2.png": "b5675e52d3dd2644be65dbe53a5bb7af",
"assets/images/delivery/reject.png": "38e0ae370c368ab9cfe877a0a5c8578e",
"assets/images/delivery/return.png": "b9a719368381b21c8f7bf71db456759b",
"assets/images/delivery/shoes.png": "8e943cd81f30c76723f9ffe08e7884d1",
"assets/images/delivery.jpg": "66d167f9f5c2163d46a8e557d332d4c3",
"assets/images/emp1.png": "a704cd68ae93355b1ad9583a5131d32e",
"assets/images/emp2.png": "f450444df399187755ef8d98519748cf",
"assets/images/emp3.png": "143d5299a3c0977cea59c2dd33e03bc1",
"assets/images/emp4.png": "8afd8ab6f2d995a7b18a3e0031445cb3",
"assets/images/excellentfeatures.png": "779ccf8dab46d121cd6596b6c716e22f",
"assets/images/filter.png": "42f3b703b6b729e56c451c4737fcda0e",
"assets/images/filterround.png": "44878cab7f9c8b3ac74b70b0f2a2e997",
"assets/images/food/authbg.png": "ff63e38e95726d1e512160da2d12453d",
"assets/images/food/banner1.png": "5f46c530f99dc68f5ab0c8626d37d902",
"assets/images/food/banner2.png": "87d78b906657ce5e1dbf3f592d89e598",
"assets/images/food/bkash.png": "94d57d3465dd3fec8e0939d3febfecb3",
"assets/images/food/call.png": "6dbf03e391e4868e55c8ff694afee1ae",
"assets/images/food/card.png": "1886dad8b588d0c1c1d8316f31809afc",
"assets/images/food/cat1.png": "fb4c3867a76fae535ce752573a160485",
"assets/images/food/cat10.png": "27438065ffbbbd22179c29d29913e968",
"assets/images/food/cat11.png": "7cbe0e0de58df55033328f8ccfe6c921",
"assets/images/food/cat12.png": "f029376b0db4175bea48dd2b874e917f",
"assets/images/food/cat13.png": "ed3115b13efa7f52c3b4378c8c3d143d",
"assets/images/food/cat14.png": "f02287ea7cdc5e30541de438cd07812c",
"assets/images/food/cat15.png": "b5dc03d2598bcdf9159c7f3e20978913",
"assets/images/food/cat16.png": "8b11d4e5e444f5f2053a79c3fde52b2d",
"assets/images/food/cat2.png": "cc68c7bcc2fe10ea628b9a49442a86c2",
"assets/images/food/cat3.png": "2f8f3b24deb3f01063b21f19736800f8",
"assets/images/food/cat4.png": "30fe5d410329bfa95de66231823551db",
"assets/images/food/cat5.png": "68259877a67509aa0480f98939362b35",
"assets/images/food/cat6.png": "b55c1f1f9178b839fa7981dcc2a14801",
"assets/images/food/cat7.png": "4519af5219c7f5afaea41d371837dfd2",
"assets/images/food/cat8.png": "5a310379e4763d5a21dd9fcf366ab785",
"assets/images/food/cat9.png": "80b921f9671d13a630702066ddcea16b",
"assets/images/food/chevrons-right.png": "ea2e2fad366d8a080110c11ef24f56e1",
"assets/images/food/cod.png": "c8b726c6efa26ad1a38ec6728751eaca",
"assets/images/food/editpicicon.png": "644557e7906ca8a1ddf916aaf8579ac4",
"assets/images/food/filter.png": "295ca12b6165cea4e13af92f53e9b7ed",
"assets/images/food/google.png": "7e19a6abfd1e0a2b998bcfd1877d4468",
"assets/images/food/homeheader.png": "92b900fe887c48d4a33e72fdfdd3fe4a",
"assets/images/food/mapbig.png": "208997aa52760a960d05bf82b7f5b496",
"assets/images/food/mapsmall.png": "6fa805bd57b53b9cc7f8c40e04f2951d",
"assets/images/food/messageicon.png": "894bdc898dedb90cdf7dc8747c0af7ae",
"assets/images/food/onboard1.png": "27dac53353906d28c197b933dd2cc37e",
"assets/images/food/onboard2.png": "7ce45f722a91b3fd85359bfdc9d14aff",
"assets/images/food/onboard3.png": "22e9633045aac5f2915174fc7f01eeca",
"assets/images/food/paypal.png": "f4191a538108b23dbcee124a441efb78",
"assets/images/food/person.png": "9feadbcf1b4fc8d66edd809a5a3043b9",
"assets/images/food/phoneicon.png": "f225307d4d10588240713a3b5b2c0682",
"assets/images/food/product1.png": "56dac847247ca0642d70c798f8b1944f",
"assets/images/food/product2.png": "255d45e05de0f1f3dec204acec3a496c",
"assets/images/food/product3.png": "c84de196a3a6b348c058f13cd87b2d51",
"assets/images/food/product4.png": "0711db2c3f19154c91f33f29137d8d1b",
"assets/images/food/product5.png": "4f59149b954b466eda33fa68d315e4cb",
"assets/images/food/product6.png": "e9429d9fb048855bd182e5040997b38e",
"assets/images/food/restaurant.png": "77a829704b9013182985e57d8e310f8d",
"assets/images/food/round_logo.png": "542ce70baf124b027c78cd237618859f",
"assets/images/food/send.png": "ba596586d04e0c424dc005e68aaf7df2",
"assets/images/food/splashbg.png": "21cd67cf40649b0cca952cc7aae49e3d",
"assets/images/food/table.png": "55f8c65b099b9b4a589d246a0a877323",
"assets/images/food.png": "bd84743fc1702de2a48368c00bf275bf",
"assets/images/formcomponent.png": "65a95c8f098abb368a02bac58afc7be8",
"assets/images/fulltemplate.png": "3d0f37c2b2e0efeb86b0c6690747d5c4",
"assets/images/hrm/addcard.png": "c9a22e33684806bc7a8c5c622a54b840",
"assets/images/hrm/addnewcard.png": "aa52fcc436f8a2ae9391d0c0ee45f590",
"assets/images/hrm/awards.png": "3252a01b7cd21872f5f229c7c01fcb6b",
"assets/images/hrm/bank.png": "2220296a40424b45a83b483ac0224242",
"assets/images/hrm/bg.png": "95f241f529b7f079d55861708598c9e2",
"assets/images/hrm/bonus.png": "e1a96265c216809ecde2c1a300907355",
"assets/images/hrm/choosefile.png": "565dabeb9f83e8b817ac590523a310d0",
"assets/images/hrm/citybank.png": "8b54ed5f3fce8057a51bbf4051e58d97",
"assets/images/hrm/clientmanagement.png": "8013406a10d38dffa9bd426bcf3a098d",
"assets/images/hrm/creditcard.png": "304ec13962a171c7d5dd25d2d7381141",
"assets/images/hrm/debitcard.png": "908017c1921debd0ecf18b500cbc5d23",
"assets/images/hrm/editprofile.png": "1e40f562ab11487f776f0a0b620b4c13",
"assets/images/hrm/emp1.png": "a704cd68ae93355b1ad9583a5131d32e",
"assets/images/hrm/emp2.png": "f450444df399187755ef8d98519748cf",
"assets/images/hrm/emp3.png": "143d5299a3c0977cea59c2dd33e03bc1",
"assets/images/hrm/emp4.png": "8afd8ab6f2d995a7b18a3e0031445cb3",
"assets/images/hrm/employee.png": "004f66e5588d976b1fa25338d20af978",
"assets/images/hrm/employeeaddimage.png": "affa8f188055774706631c0c19454548",
"assets/images/hrm/employeelist.png": "ead54c78a4f2b8574319171738d894ae",
"assets/images/hrm/employeemanagement.png": "df8ae85bb4368fb04ebbf747bfdcfeaa",
"assets/images/hrm/employeeovertime.png": "69c7006f0691a86734557089c21ecd5c",
"assets/images/hrm/employeesearch.png": "29a239223ecf238fba42450846b83a02",
"assets/images/hrm/empty.png": "9695fcd89d5e5c3d5aab78480da6b254",
"assets/images/hrm/expensemanagement.png": "44549415dde8331a7a03699aa66ae48a",
"assets/images/hrm/expenses.png": "1403cbd4b2ccbaa919ec33f0530d156c",
"assets/images/hrm/filemanagement.png": "b99bc718fc0be5f682bc9b6bbff55d42",
"assets/images/hrm/google.png": "7e19a6abfd1e0a2b998bcfd1877d4468",
"assets/images/hrm/increment.png": "9071a50e8605f13f77d9c6cff2b1fd20",
"assets/images/hrm/leavemanagement.png": "cdf2c8ccadfc676a5ab4d785c2fe0be1",
"assets/images/hrm/loan.png": "37307ff299f8167bb41913bcd005fd5d",
"assets/images/hrm/logo.png": "d4e4b2db3d0410b3090ae884bceb437a",
"assets/images/hrm/noccertificate.png": "addf3de480b7ea281661eecf710d3614",
"assets/images/hrm/noticeboard.png": "c7c09139e0c8b2e685fd161e72e1e7bc",
"assets/images/hrm/notificationicon.png": "721fab42d2d7326c966fa2190fad55b1",
"assets/images/hrm/onboard1.png": "ecca6868c1f0f6f772dc3f9b91cfe9cb",
"assets/images/hrm/onboard2.png": "9abf3537abcbf0bf0b6ca957cc818a1e",
"assets/images/hrm/onboard3.png": "297a7aef6e196bb575f7d2ee8c6e999d",
"assets/images/hrm/owner.png": "2645a986253f98f94d10f479a54ab850",
"assets/images/hrm/payment.png": "6a472a8a4793813bc3da36634fb30142",
"assets/images/hrm/paymentsuccess.png": "86443f28d93f70c8393c07ef4ced9399",
"assets/images/hrm/paypal.png": "6a126a5ace02b7a5d341fcd856be5548",
"assets/images/hrm/payrollmanagement.png": "0d02efa163d8180f8fc8cffa5941724a",
"assets/images/hrm/people.png": "4ae6ede49187e92119a97285c59409cb",
"assets/images/hrm/providentfund.png": "5500a87a73bbfb0c11c2ed51a688ce55",
"assets/images/hrm/reference.png": "b186c84c3511049174bdd338a7476f60",
"assets/images/hrm/round_logo.png": "0fde5b9c7e30f54402fc993d8b829527",
"assets/images/hrm/salarymanagement.png": "7cdd98724e73efb2d6d0e5216479b864",
"assets/images/hrm/salarysheet.png": "106cb3b4cb185e691c86d27c40ee485d",
"assets/images/hrm/timeattendance.png": "7f03eaddbe4d337913f1b978fada70d3",
"assets/images/hrm/workinghour.png": "9266ece46da68853b2c2b5a736c400de",
"assets/images/hrm.png": "bd2b8f1fcb2169e5d82f6a42c56f78c3",
"assets/images/iconandlabel.png": "6ae734b7fc0eb1735765a2dc1bc3ab3a",
"assets/images/input.png": "ad2d84074cec09c607b992d2abf8d8d2",
"assets/images/integration.png": "b94e0550c644c6cd74a22c804d5b419a",
"assets/images/layout.png": "1ce3abb9a5c34162e3ba133e9e46cb39",
"assets/images/lms/bkash.png": "2e8a63890264006b52d95044c5711627",
"assets/images/lms/business.png": "d1c4013491189c24696b64b3240b0c6c",
"assets/images/lms/cancel.png": "8ec505da351d087f29346481f766c06f",
"assets/images/lms/cardbg1.png": "307e0366c83a4e0e72dae0c07bbe2c25",
"assets/images/lms/carticon.png": "5f181ad3238f1e5d6286fc64437d5a6c",
"assets/images/lms/comp44_icon.png": "441bb226d975829d46f0e44ee9e26c22",
"assets/images/lms/coursethumbnail1.png": "390c34e9740843e3266837d77998eca9",
"assets/images/lms/debitcardicon.png": "eb35775ada69836bdc8b8bb9f9e6b889",
"assets/images/lms/dept_gz_icon1.png": "5ac7cd8e068ac4e8b916f37dbb2e8236",
"assets/images/lms/design.png": "4269d5a2f1b3ed28a7fbf55f0048f2c9",
"assets/images/lms/development.png": "7b2a1fc77d4632479928b2a05635e2c0",
"assets/images/lms/editpicicon.png": "5247e7269d51bff78fff25c709560726",
"assets/images/lms/editprofileicon.png": "6f15eae634a4167c47a967cfe050aaf9",
"assets/images/lms/email-icon1.png": "7a77351656616692f8efa2ea35b035b3",
"assets/images/lms/filter.png": "950e7bf5cdd2a342dd1ec0a596a7a379",
"assets/images/lms/google.png": "7e19a6abfd1e0a2b998bcfd1877d4468",
"assets/images/lms/healthy.png": "454135cabe0c6375039c19e793ce2cec",
"assets/images/lms/instructor1.png": "eb1d3291e33b256f079589c1bede3d4c",
"assets/images/lms/instructor2.png": "a6a48e95fa3ae56572e8e808f93ba801",
"assets/images/lms/instructor3.png": "90d2926343ccb662ef28784302653918",
"assets/images/lms/instructor4.png": "9507b7c82f8e9bff487aa880cabc138f",
"assets/images/lms/instructor5.png": "4af32b25612e3dec9d873a692ff524c4",
"assets/images/lms/instructor6.png": "f64da3f4dc5f6b45e447de787f20e1e7",
"assets/images/lms/instructor7.png": "4ca5bed3d5e85991f3595d30a6536c88",
"assets/images/lms/instructor8.png": "153e33082bbaa151a2f298eff06e55bf",
"assets/images/lms/job_gz_icon1.png": "32118a10583f1882d116dee89041c8de",
"assets/images/lms/languageicon.png": "1228d239b3503628bf75c6368bd9acfa",
"assets/images/lms/lifestyle.png": "6eff3199e42ff8d955f46ee751e5274c",
"assets/images/lms/logo.png": "874e49838299c9db7e6645162118bc16",
"assets/images/lms/logouticon.png": "c9658fd254e121f539ae8cb0f0e3872b",
"assets/images/lms/marketing.png": "9ae1489a58c00ed30a7150f586b9bf42",
"assets/images/lms/mobie_num_icon.png": "d0d40085d6bd1333c9c507cfcd0fdc4e",
"assets/images/lms/music.png": "d7a999eddfe3515ead0fd296dfe9f6c5",
"assets/images/lms/notific.png": "18cce838c63d2d5d2c6f06548148286b",
"assets/images/lms/notification.png": "eba728c45b0a106147cae32ccf95dbe0",
"assets/images/lms/notificationicon.png": "82e45fd471e812a79ed1930c67a14327",
"assets/images/lms/onboard.png": "d2204f0c3f1d41ead6a8390bbc794c83",
"assets/images/lms/onboard1.png": "2780df3071aabf004871bde40eda1722",
"assets/images/lms/onboard2.png": "886ea75d26722002a79e128d36aae7d2",
"assets/images/lms/onboard3.png": "00c632547f5118e1659ea0fa19cbe9cf",
"assets/images/lms/paymentdetailsicon.png": "7f096b127d48938ca0a889818f3caddd",
"assets/images/lms/paymentsuccess.png": "62e118fac426dea82843592c9dcb5600",
"assets/images/lms/paypal.png": "4c1a2566b5c3c6555c416ffe764d940c",
"assets/images/lms/paytm.png": "bdb28b063bde743b061870d06d0fc90b",
"assets/images/lms/photography.png": "6207066427989fb450d4740d75dcc44a",
"assets/images/lms/playlist.png": "88f489c7b5671c59d99c3667953b7572",
"assets/images/lms/profile.png": "75a84575259f3af07f1563c235c466fc",
"assets/images/lms/round_logo.png": "ba854ad00e73cee09279978fa96f8238",
"assets/images/lms/splashbg.png": "e5cb08f8ec1a096ac0e686d6de743c6a",
"assets/images/lms/ssl.png": "36c7bf0f78706d4d8de5ec5aff45d300",
"assets/images/lms/stripe.png": "b33598229a2ba31b8dc5c81f0a202536",
"assets/images/lms/wishlisticon.png": "7f1350024d823287592e94e6d40b9332",
"assets/images/lms.png": "e11283247468ca3a5fd3b0492a474f17",
"assets/images/lms123.png": "007fea3302b1c078d04742ea047c7073",
"assets/images/lms22.png": "6dc5672c06e7b54c9a675e77869ba12c",
"assets/images/logo2_marsa.png": "007fea3302b1c078d04742ea047c7073",
"assets/images/maanfood.png": "bd84743fc1702de2a48368c00bf275bf",
"assets/images/maanlogo.png": "bc76106c28fa133e726e0453bffe885e",
"assets/images/maanstore/ad1.png": "01a98cf2e9e5f01e8243637edd3b3978",
"assets/images/maanstore/ad2.png": "d0d664e4f1623b8035dfb6199bfc4348",
"assets/images/maanstore/ad3.png": "d4635b4ec159104c1b9412082ea75f29",
"assets/images/maanstore/apple.png": "dfa593c91fd785151bf72bc49cd805d8",
"assets/images/maanstore/best_selling.png": "41bc8a646eb885cbdc0282336e71dbcb",
"assets/images/maanstore/bkash.png": "e5f16ea4909b0445cb3a1597221d860d",
"assets/images/maanstore/c1.png": "8b7ef735a8579c8021b39fd8a939ff95",
"assets/images/maanstore/category_image1.png": "d83be448aba5914a15784831ba691651",
"assets/images/maanstore/confirm_order_pupup.png": "538376f2059c730a22cddabed3c24b7d",
"assets/images/maanstore/cupon_code_image.png": "39ae4542c0bd6db7b82468f524928fab",
"assets/images/maanstore/electronics.png": "3e04457561ddc3f50e22447dadbbe2ee",
"assets/images/maanstore/facebook.png": "169560e408bff882faf33460801dfa79",
"assets/images/maanstore/fashion.png": "a85555b371ead00ca10447253a6a4b97",
"assets/images/maanstore/flash_sale.png": "c2907ec46c5437da422a7510726abb01",
"assets/images/maanstore/furniture.png": "ff13e9b66a14830aeff5f2c8501371c5",
"assets/images/maanstore/google.png": "4aa71741c5ce4b3934dad5ef3c80b48f",
"assets/images/maanstore/grocery.png": "7179e677177ea539367095c42605541c",
"assets/images/maanstore/Group%252033923.png": "ee780b259aabd1528b437a5fc7d0d91d",
"assets/images/maanstore/Group%252033927.png": "53e2d4249651efec15accb1f5354c89f",
"assets/images/maanstore/Group%252033928.png": "d70a3f79754325f12a1cb1e116abdd0c",
"assets/images/maanstore/images.jpg": "813757cf08c654e4399396b094925b8d",
"assets/images/maanstore/kids.png": "3f7023ad4c1008ec2058c2a04fd5ad31",
"assets/images/maanstore/maanlogo.png": "bc76106c28fa133e726e0453bffe885e",
"assets/images/maanstore/maanstorelogo.png": "bc76106c28fa133e726e0453bffe885e",
"assets/images/maanstore/maanstore_logo_1.png": "0cefa3ec890285184f93b352128a7b5d",
"assets/images/maanstore/men.png": "40a803c178b0a58d4f74581bb4fecf47",
"assets/images/maanstore/offer_image.png": "2528e667cce0663f9f6f72dea6b8c22f",
"assets/images/maanstore/password_change_image.png": "e3532c2731880be760c60131e328d788",
"assets/images/maanstore/paypal.png": "9c64a1cd7fae8271ecd3093a9ea513e5",
"assets/images/maanstore/paypal2.png": "82a3ff5fc174346ec710a22b644798a7",
"assets/images/maanstore/profilePic.jpg": "a557b51c9e58fdf44b0f094307473c67",
"assets/images/maanstore/profile_image.png": "b243ad0cf91bbc998dfaa1cbd665bbb7",
"assets/images/maanstore/profile_pic.jpg": "d80dba67c8eea777b6064004ffe42861",
"assets/images/maanstore/rectangle_1.png": "690eb433c609969865a5d56f25109a78",
"assets/images/maanstore/review_pic.png": "87eb65e1e29a07f12bb7d95497255a2c",
"assets/images/maanstore/shoes.png": "21a3a73f83b1b2f6d5cec0c5506cf5da",
"assets/images/maanstore/shoess.png": "96f89d5f236f6441d4d7be8637e047b2",
"assets/images/maanstore/sports.png": "18371e4e532bc55f27aecaedc20a3dd0",
"assets/images/maanstore/visa.png": "e771f1f397bdcba006aea8ff95b08b47",
"assets/images/maanstore/watchh.png": "cc13076a8b3e711d18e1e092d235d194",
"assets/images/maanstore/woman.png": "08bdc538eded317d100fa2ce88b55efa",
"assets/images/maanstore/woman2.png": "5302064602cec358492f110397690797",
"assets/images/maanstore/woman3.png": "65bd7275f22849b590cd76f6494abc39",
"assets/images/marsa_logo.png": "e11283247468ca3a5fd3b0492a474f17",
"assets/images/music/90.png": "b9e211fbfac9f2a6b3cc42b6a426e942",
"assets/images/music/album1.png": "7ab47904d5b991e242d4259909df7c99",
"assets/images/music/album2.png": "ca71a85dc447f1819551abb72b5906f6",
"assets/images/music/albumbg.png": "2907bc12f6962cf969dbd2aa096cfc8d",
"assets/images/music/albumbg2.png": "f3aa7f6f80c7b569bffa1a553ddddc8a",
"assets/images/music/audio1.mp3": "fbc6c64c0a4a945d0caa648478f60eb4",
"assets/images/music/bass.png": "49242111dacd4a0190f1897aab832bf7",
"assets/images/music/believer.png": "51c5ed55232108e4328d22710744128f",
"assets/images/music/care.png": "e5ea0ee975cffd4cdd5ebcb94cdaa7c3",
"assets/images/music/divine.png": "53b91ca86ccc96be0c520fd85f5ff4ee",
"assets/images/music/dj.png": "c0d2414e8edd990e1508f80ef1ecde37",
"assets/images/music/evolve.png": "f1e68f5c538d2f71182e8027605808f5",
"assets/images/music/garyvee.png": "ca71a85dc447f1819551abb72b5906f6",
"assets/images/music/gully.png": "cca886d94c909e5aff00fe97ab6b853d",
"assets/images/music/hiphop.png": "b9b0747b403cafc49cd80e5dced2eb27",
"assets/images/music/im.png": "680782ecc08d6264170e6bcdded3e5fb",
"assets/images/music/kohinoor.png": "98a40dd2c14ba2abc77ae13829296667",
"assets/images/music/lights.png": "0095a7963b398ebd37ac541d1ffb625d",
"assets/images/music/liked.png": "49f88a595a5d3ec60f6be2c9b8d6a353",
"assets/images/music/loco.png": "cf48c632384de5b72120139f6bc91163",
"assets/images/music/logo.png": "5833f3b032353d0664215074cb128c5f",
"assets/images/music/logo2.png": "d215395642231871fe283e7f3cf0683b",
"assets/images/music/mark.png": "0133087f95ae6a818f55ee90db662c8b",
"assets/images/music/more.png": "47dd11ebb52d89b1c67b4aef8076ce57",
"assets/images/music/no.png": "f1787741cdc34519c9132574216e20e2",
"assets/images/music/nuc.png": "715602d55165c8cdef1676f92fc11ebf",
"assets/images/music/party.png": "4b7a7064981d36dc854cb401ba7ab466",
"assets/images/music/podcast.png": "28d4b8bc73e3ba98ad747f6cca60cae6",
"assets/images/music/rid.png": "3fde60b616e457a0f7efd95a26adfb55",
"assets/images/music/rit.png": "9972115628fa8d17c1eb3c33bb4139d2",
"assets/images/music/song.png": "9939b12de160a8cc3907534811a5f792",
"assets/images/music/songbg.png": "ccf55692321db6fa85e55db6068fe31d",
"assets/images/music/sounds.png": "736bdcd7643f68d537c793605cc56bc9",
"assets/images/music/splash_bg.png": "e35fedebea3f80c61435697dc58ce6f4",
"assets/images/music/talk.png": "736bdcd7643f68d537c793605cc56bc9",
"assets/images/music/the_art.png": "ab7e7eb339ee4e43ecbac63519a576bf",
"assets/images/music/titan.png": "0133087f95ae6a818f55ee90db662c8b",
"assets/images/music/true.png": "4496f783b0e79b8d48b8ba65668571fe",
"assets/images/music/wireframe.png": "b040918dce923a100a8cb45bba352c46",
"assets/images/music/workout.png": "60685e3aaf89d9d869565f345acfe7b3",
"assets/images/music_logo.jpg": "a78ea7bd65448dca0e6855c9ab5cba74",
"assets/images/mybazar.png": "a55bfe8f7b06c65bb90b813f6b399dbb",
"assets/images/nav1.png": "c131a6f17533ca0d2bef3e6da1a19a33",
"assets/images/nav2.png": "eedc133a50ecb0f15a5a8cf493a5a13b",
"assets/images/navigationbar.png": "c2bf073ed17c933840853c6d9dbd0aa0",
"assets/images/news/banner.png": "e8112cecc430812a0ed3b06428a9e8c0",
"assets/images/news/drawer.png": "7eb2acd7763ebb7a80c4757526e192cf",
"assets/images/news/logo.png": "a40483c0c266683e778d2352d6a50c50",
"assets/images/news/logo_new.png": "9c09a465ac84fc2175c58144df74a84d",
"assets/images/news/notification.png": "f297d7ac5e74fa9163434cec27c8a8e4",
"assets/images/news/onboard1.png": "42894d3e8e2bc2d2451e0fecd0fdcd9f",
"assets/images/news/onboard2.png": "8fac0c3054b06c910e77a1aa8f407fcc",
"assets/images/news/onboard3.png": "f3a271e487f75563d5de37c8826b00a8",
"assets/images/news/person.png": "a20671fa60be52b2e9534993fc640f64",
"assets/images/news/post.png": "5f30be7768bb72d3b682a980c035a5d9",
"assets/images/news/video.png": "11402140c81af751e29e2bb2827a2ceb",
"assets/images/newsicon.png": "d3d82a7356fd01ebae6c41d769c40c5d",
"assets/images/person.jpg": "9feadbcf1b4fc8d66edd809a5a3043b9",
"assets/images/person.png": "feae95c9af3dc80a338984e1741a57f9",
"assets/images/pos/adjustment.png": "af1fe2f104b90d0756f5289cd81c593f",
"assets/images/pos/ba.png": "187104db568f20dc4a713d466cfdc2f5",
"assets/images/pos/backup.png": "0d619037bd4212ac12a71f855445ac0c",
"assets/images/pos/backupimage.png": "4513b1d7e1961e594a2ac536fb9efba1",
"assets/images/pos/bank.png": "51feb2c13bb6592182b13793a0e957bf",
"assets/images/pos/banner1.png": "b8433f7f76bb89997c026c6ca4dcfd0c",
"assets/images/pos/banner2.png": "a382e68544826dc8b5bee63507c25d61",
"assets/images/pos/banner_store.png": "c47af4f725223fc97b26055d91ae128f",
"assets/images/pos/barcode.png": "c907a206837d1ac5952dfd86531ae413",
"assets/images/pos/barcodescan.png": "b946bdfaca6813eab47e7a68132ef065",
"assets/images/pos/boa.png": "3b52631f576f00545b151d7a50afca2b",
"assets/images/pos/branch.png": "c6cf5fc73fb012a4562efcc0a2c174ac",
"assets/images/pos/calculator.png": "0b6fe102612e9834231e8f06b6230b56",
"assets/images/pos/cash.png": "c8b726c6efa26ad1a38ec6728751eaca",
"assets/images/pos/city.png": "f81ea5007b5b0283b800e5fd72ef2a1c",
"assets/images/pos/cod.png": "d3b6f30130abc60d40fbba6b99d43920",
"assets/images/pos/complete.png": "3362327cb924db34cb78fe32bc3bda69",
"assets/images/pos/customer.png": "44f0bdad4b33be5b8ae275cbfb348cd8",
"assets/images/pos/damage.png": "34b0a329f1b71a2d50f306c3d2c2f7ec",
"assets/images/pos/dashboard.png": "0b27f589c22ff309a6671d04a4e6943b",
"assets/images/pos/delivery.png": "5b6772ddc5968b89582012fd255f85e1",
"assets/images/pos/demand.png": "ce19b0cd0a682e8d59b612c2aed55c25",
"assets/images/pos/duelist.png": "c4f99b9b0aec62841c6530aef4ee615e",
"assets/images/pos/emailsent.png": "ac00e0e7cd16c7b3439c04c09d092394",
"assets/images/pos/expenses.png": "d22e9bb0187906bf5b9326fccbfb750e",
"assets/images/pos/fb.png": "ba0d8ce0a89b602dfff899a220f38e98",
"assets/images/pos/gift.png": "fbed49b47c75875a84c03938aef424d7",
"assets/images/pos/income.png": "14bab0ea48b74f192504e78c128fe5f3",
"assets/images/pos/insta.png": "cffd70f5f266c4d52475bbe882c28fbe",
"assets/images/pos/instrument.png": "cfd3f206aa0be2caac04c5a0b9b518a6",
"assets/images/pos/invoice.png": "fd04ab1e724ad46f2fc07358e483308a",
"assets/images/pos/ledger.png": "46f380be76ab9e58af0d1c0da4889ea7",
"assets/images/pos/linkedin.png": "b4674ee6cc9a59f2c9b7b4f235495429",
"assets/images/pos/logoandname.png": "c43c85bacaf1d08a9a035ceb3d35ffda",
"assets/images/pos/logoblack.png": "a88fbe68b0fd98f1cd1ac0346cfb70df",
"assets/images/pos/logoPos.png": "8a6bf5436171d6e2e3fb3449dc4a126e",
"assets/images/pos/lossProfit.png": "1eaaf24dd42aae81f14ca8a4b8340d4c",
"assets/images/pos/mailbox.png": "5e4a8b2fdf04cb814252705ac5127364",
"assets/images/pos/map.png": "b2772f640a6bfe096d643f2e68f38ca8",
"assets/images/pos/marketing.png": "f7da451c193df470df8a90b57844c955",
"assets/images/pos/mastercard.png": "0771fb1c1f6e47c08fce64ed8ed4b143",
"assets/images/pos/officedeliver.png": "6bcf7c30e9c492b77f4b30989f0a2dd7",
"assets/images/pos/onboard1.png": "e688ebf0729411ff9b5dcfc8e3b7d59c",
"assets/images/pos/onboard2.png": "01aa6f1c8e17d2b5272061974cbfc3c8",
"assets/images/pos/onboard3.png": "ffe39af707a86f07db93b29faa561aa9",
"assets/images/pos/oneb.png": "2939e5304f2f8e5518a1916402507825",
"assets/images/pos/onlineorder.png": "28c3021d5060b164ca09b031d2626022",
"assets/images/pos/onlinestore.png": "7cefffa43a14c2c33160a30eb6cafa22",
"assets/images/pos/op.png": "3e61a7f9ba5cd287616bc52b26dfac0a",
"assets/images/pos/product.png": "e348f7925106b809dc16b2c42826da39",
"assets/images/pos/profile.png": "5cd517abd4ac9d00a610009c60c0a4b7",
"assets/images/pos/profileimage.png": "5f2ceea548e2eedff94d42413bc5ef39",
"assets/images/pos/propic.png": "bdbc88cc3005d58c72ebbe4718f1f42b",
"assets/images/pos/purchase.png": "f84a298d9cd67dde3b4c512612b82a3c",
"assets/images/pos/quotation.png": "752d6cb1de7bc3736e06c03430ab626f",
"assets/images/pos/reports.png": "ec128b0a9394021904dfbf5d3204ee34",
"assets/images/pos/return.png": "0378487abe9da96d05580078039b990e",
"assets/images/pos/salelist.png": "24fe71cbfe9f5ec95473d3b61848d477",
"assets/images/pos/sales.png": "a4fc703b64f89cd07ca6d95d28e0d2c6",
"assets/images/pos/salesreturn.png": "fc0e408824cd2b2dfff5ca710ec23af8",
"assets/images/pos/selected.png": "2aed7855ac2c7bfcde815b4bf92054e2",
"assets/images/pos/stock.png": "c9433d3b4e27332555c3f6885286a4e8",
"assets/images/pos/storeicon.png": "41c5987ffba038b074d1145cb15b58c0",
"assets/images/pos/success.png": "54329fc1b16f80b4b0a4b9f7b508f25d",
"assets/images/pos/supplier.png": "8348518d8233db00a8a01a059c903795",
"assets/images/pos/transaction.png": "384fff98fcbd79b01a9c651bd3b69dab",
"assets/images/pos/twitter.png": "657ce4c7a2a14f22b7bb4beab6fcb4c3",
"assets/images/pos/usaa.png": "766e3fed184a6150741f449a51f277c1",
"assets/images/pos/usb.png": "aad2e3f081268c56ba115450966c10f0",
"assets/images/pos/userrole.png": "688225df79cec620524baab63a7f63ac",
"assets/images/pos/warehouse.png": "c80dd935c1598c0abc82cb88193e05f0",
"assets/images/pos/x.png": "c144121919f76410c6c59d89fc1a375b",
"assets/images/restaurant/banner1.png": "8b9a9c01118ba0f0df0cbf67c11f6d77",
"assets/images/restaurant/banner2.png": "1f3e94d8c0cbb720266d51a491f000b7",
"assets/images/restaurant/banneredit.png": "037128b416e4cb2ee9663a3a83bbadde",
"assets/images/restaurant/bg.png": "9d2e75b4f54ea3f8eb522323d295ba72",
"assets/images/restaurant/camera.png": "037128b416e4cb2ee9663a3a83bbadde",
"assets/images/restaurant/edit.png": "69a83104d4791de6aaeecdadd5c1dec0",
"assets/images/restaurant/editimage.png": "f97b270cba7d535db09bab992a8ad5b4",
"assets/images/restaurant/editlogo.png": "a7e50526e36c68bb223f7fd697cc30b8",
"assets/images/restaurant/editpicicon.png": "1aa70327c0093b85d4cfb1860acccb0f",
"assets/images/restaurant/food.png": "06b3a39eaf4a0f4764c8738c4247aa9f",
"assets/images/restaurant/imageedit.png": "94473632159a0bd9009e83bbc34959f8",
"assets/images/restaurant/kabab.png": "c4bd83c66b7c3fe3d9c3558dedf6b1c6",
"assets/images/restaurant/logo.png": "d92f54dce4e2e72fbae539b31b29c452",
"assets/images/restaurant/logo2.png": "7a0c12fb7d277f5458391390459bb4d2",
"assets/images/restaurant/notification.png": "8123f17c35bb5c78b80d4364ef53d115",
"assets/images/restaurant/picedit.png": "8be6c5c0fe06a4e9eb0a5abf985b6a97",
"assets/images/restaurant/profile.png": "6e2ec06aba262cc6195384aaf04b6179",
"assets/images/restaurant/screenbg.png": "0f8b959b2c50ec4184750f34f2069ac2",
"assets/images/restaurant/splashbg.png": "c071236e362ba2d5c936895bc8703f88",
"assets/images/restaurant/star.png": "49e60a0f396e8359a1ed93636637f85f",
"assets/images/restaurant_logo.jpg": "69ec0d9aa2a101831549659a4f3e71aa",
"assets/images/salespro.png": "ea86674a9447fd0b27f6d85da674c1ae",
"assets/images/sample.pdf": "c1bda6d4249306eeb6b30da641eb2ad8",
"assets/images/screenlist.png": "b0fae71cf61f8e1691a36244bcec617f",
"assets/images/shiftinglabel.png": "c628c7249fa0e0e6fed14abf94f91f7c",
"assets/images/sports/all.png": "510dad66819210d2f7b70c4e4ad8a623",
"assets/images/sports/banner4.png": "c2f0dcdbe5c98c4ae2e68c70b05bac3d",
"assets/images/sports/bkash.png": "5a8b19427af766b772b07ac018e102cf",
"assets/images/sports/bpl.png": "7c9d163f6826f23a46807c67f705119a",
"assets/images/sports/bpl2.png": "b79304cd009eddec0656ad75607b5369",
"assets/images/sports/bpl3.png": "b79304cd009eddec0656ad75607b5369",
"assets/images/sports/cc.png": "ff29fd6eddafad1bf5afc96a53146b25",
"assets/images/sports/cpl.png": "96c9782aad46ebb5306d2f5286364c20",
"assets/images/sports/cpl2.png": "5922db791a79549228067e612220cfa4",
"assets/images/sports/cpl3.png": "5922db791a79549228067e612220cfa4",
"assets/images/sports/cricket.png": "b52cfc5201942d138515a65b85933763",
"assets/images/sports/csk.png": "1d084418a79727b2ecd410e55d6ede28",
"assets/images/sports/cv.png": "cd144401a57f2c62312dc06b3004273d",
"assets/images/sports/dc.png": "a8b4f0421198bd78247f47cd7046a13b",
"assets/images/sports/fb.png": "0f01abcd83483eaba1d0adb2101ede51",
"assets/images/sports/Frame%252018694.png": "0f01abcd83483eaba1d0adb2101ede51",
"assets/images/sports/ipl.png": "d80301b269125773f26f9a668afff89a",
"assets/images/sports/ipl2.png": "0cdf728927a011374d99f0382ea91710",
"assets/images/sports/ipl3.png": "62688409620b42358ddb493da6289f20",
"assets/images/sports/ipllogo.png": "0cdf728927a011374d99f0382ea91710",
"assets/images/sports/ipllogo2.png": "91bd35ac13c1ec2278657da10aa364cd",
"assets/images/sports/kkr.png": "c5848e8717e4a6cb97e209352bb84e8a",
"assets/images/sports/kt.png": "9f74a8c49209fdf11432bd58f7637ec7",
"assets/images/sports/logo.png": "0972e994814b1b5d3b49668c819b0cbb",
"assets/images/sports/logo3.png": "cf8ba62de2b0b7f701b07eea3b5cd250",
"assets/images/sports/mi.png": "d12f6956721f89588aa0b5b0306fb85d",
"assets/images/sports/nagd.png": "b4a6820256059c23a63201305412167b",
"assets/images/sports/odi.png": "46e628515aa73bea6848fae823d889db",
"assets/images/sports/onboard1.png": "31130b4a14b843401bed2fbf2bb887a7",
"assets/images/sports/onboard2.png": "70340e77f573eb7e110b8e4fc741a30a",
"assets/images/sports/onboard3.png": "187191268c1b0bbe7248e3d45c6339c5",
"assets/images/sports/paypal.png": "8d377aafae83fbeb48029e24b6815ed8",
"assets/images/sports/pk.png": "27287d62e340f72ab2b29e1b7660f980",
"assets/images/sports/profile.png": "f0c2c93de1b65a098b3870a5a1193926",
"assets/images/sports/rc.png": "97023ebb8c949e273b38ffdb332dfcec",
"assets/images/sports/rcb.png": "8cb87fcac6ed556fe67fd810e82c7150",
"assets/images/sports/rr.png": "57acde40ab55f75ffa6b37f62e1cf466",
"assets/images/sports/sh.png": "240c13a17906466363bf24da95290764",
"assets/images/sports/splashbg.png": "658c3778b7b52c940574f815652b3bbf",
"assets/images/sports/st.png": "03ac79ba0d33647cacfedb03b9c8929d",
"assets/images/sports/t20.png": "38fe0951e2f4014a5eb0fa44de777419",
"assets/images/sports/t202.png": "96068b82fb33b0827cd23d782a656c93",
"assets/images/sports/t203.png": "96068b82fb33b0827cd23d782a656c93",
"assets/images/sports/test.png": "e07973fdc3e9db13c5aaeae5aa8ebc43",
"assets/images/sports/x.png": "20d03026aad3302a9aa931ad33710674",
"assets/images/tabbar.png": "142f17e5906647f595dec8c45ba74c0e",
"assets/images/text.png": "a2d4fea1bef943a2d2a0223cdaf6cc9c",
"assets/images/themelist.png": "f246b65ca270777c819abbc39f815d4f",
"assets/images/widget.png": "53b1940147edb880bd11137e5b733eaa",
"assets/NOTICES": "fc094ac2fefb41a61b738a6fb713aa4e",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/packages/feather_icons/fonts/feather.ttf": "ad5435302c3c2d1f23f275d0f22d36c6",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "f25e8e701660fb45e2a81ff3f43c6d5c",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "a5d7457fda15b7622c14f432ba63039a",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "c21ada0509560335a84151332be5488d",
"assets/packages/nb_utils/fonts/LineAwesome.ttf": "4fe1928e582fd2e3316275954fc92e86",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/canvaskit.wasm": "73584c1a3367e3eaf757647a8f5c5989",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "143af6ff368f9cd21c863bfa4274c406",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "2fc47c0a0c3c7af8542b601634fe9674",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "59a12ab9d00ae8f8096fffc417b6e84f",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "b0abf548625a4ce60a5410e2ee596452",
"/": "b0abf548625a4ce60a5410e2ee596452",
"main.dart.js": "df3cec7d515e2ccff9a9c1d616284df2",
"manifest.json": "0440df8fad77006bdf3e674fb1cddf51",
"version.json": "16b11eab11946d1e7a8884e9ba833673"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
