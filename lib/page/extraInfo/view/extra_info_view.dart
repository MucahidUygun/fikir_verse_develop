import 'package:accordion/accordion.dart';
import 'package:fikir_verse/core/extension/context_extension.dart';
import 'package:fikir_verse/core/extension/radiobutton_enum.dart';
import 'package:fikir_verse/core/init/session_control.dart';
import 'package:fikir_verse/core/widget/app_bar_widget.dart';
import 'package:fikir_verse/core/widget/button_widget.dart';
import 'package:fikir_verse/core/widget/side_menu.dart';
import 'package:fikir_verse/core/widget/toast_message.dart';
import 'package:fikir_verse/page/extraInfo/viewModel/extra_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_view_indicators/page_view_indicators.dart';

class ExtraInfoView extends StatefulWidget {
  final int point;
  const ExtraInfoView({Key? key, required this.point}) : super(key: key);

  @override
  State<ExtraInfoView> createState() => _ExtraInfoViewState();
}

class _ExtraInfoViewState extends State<ExtraInfoView> {
  final ExtraInfoViewModel _infoViewModel = ExtraInfoViewModel();
  ScrollController scrollController1 = ScrollController();

  ScrollController scrollController2 = ScrollController();

  ScrollController scrollController3 = ScrollController();

  ScrollController scrollController4 = ScrollController();

  ScrollController scrollController5 = ScrollController();

  ScrollController scrollController6 = ScrollController();

  ScrollController scrollController7 = ScrollController();

  ScrollController scrollController8 = ScrollController();

  ScrollController scrollController9 = ScrollController();

  ScrollController scrollController10 = ScrollController();

  ScrollController scrollController11 = ScrollController();

  ScrollController scrollController12 = ScrollController();

  ScrollController scrollController13 = ScrollController();

  ScrollController scrollController14 = ScrollController();

  ScrollController scrollController15 = ScrollController();

  bool isClick = true;

  bool isClickUsageHabits = true;

  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    _infoViewModel.updateGetModel();
    sessionControl(true, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      appBar: PreferredSize(
        preferredSize: Size(context.width, context.heightNormalAppBar),
        child: BuildAppBar(
          isShowPoint: true,
          title: 'Genel Bilgileriniz',
          userPoint: _infoViewModel.checkUserPoint(widget.point),
        ),
      ),
      body: Accordion(
        openAndCloseAnimation: false,
        maxOpenSections: 1,
        headerBackgroundColorOpened: const Color(0xff47b2e4),
        headerBackgroundColor: const Color(0xff37517e),
        children: [
          // Hane Profili Bilgileri
          AccordionSection(
              isOpen: true,
              header: const Text(
                'Hane Profili Bilgileri',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              content: Column(
                children: [
                  //Hane Profili belirleme
                  buildHouseProfile(),
                  //Hane Profili kaydet
                  ButtonWigdet(
                      icons: Icons.save,
                      color: isClick ? const Color(0xff47b2e4) : Colors.red,
                      onPressed: () async {
                        setState(() {
                          isClick = !isClick;
                        });
                        await checkNetworkControl(context);
                        await _infoViewModel.updateHouseholdProfile();
                        if (_infoViewModel.modelHouse!.status) {
                          _infoViewModel.getUserModel();
                          showToast(
                              _infoViewModel.modelHouse!.message.message,
                              const Color.fromARGB(255, 43, 167, 48),
                              6,
                              Icons.check,
                              context);
                        } else {
                          showToast(_infoViewModel.modelHouse!.message.message,
                              const Color(0xfff1556c), 3, Icons.close, context);
                        }
                        Future.delayed(const Duration(seconds: 3))
                            .whenComplete(() => setState(() {
                                  isClick = !isClick;
                                }));
                      },
                      title: 'Kaydet'),
                ],
              )),
          //Kullanım Alışkanlıkları
          AccordionSection(
              isOpen: false,
              header: const Text(
                'Kullanım Alışkanlıkları',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              content: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: buildPageView(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CirclePageIndicator(
                      itemCount: 15,
                      currentPageNotifier: _currentPageNotifier,
                      selectedSize: 15,
                      dotSpacing: 10,
                    ),
                  ),
                  //Kullanım Alışkanlıkları
                  ButtonWigdet(
                      icons: Icons.save,
                      color: isClickUsageHabits
                          ? const Color(0xff47b2e4)
                          : Colors.red,
                      onPressed: () async {
                        setState(() {
                          isClickUsageHabits = !isClickUsageHabits;
                        });
                        await checkNetworkControl(context);
                        if (!_infoViewModel.isHave()) {
                          showToast('Lütfen tüm soruları işaretleyiniz!',
                              const Color(0xfff1556c), 3, Icons.close, context);
                        } else {
                          await _infoViewModel.postUsageHabits();
                          if (_infoViewModel.usageHabitsRequestsModel!.status) {
                            _infoViewModel.getUserModel();
                            showToast(
                                _infoViewModel
                                    .usageHabitsRequestsModel!.message.message,
                                const Color.fromARGB(255, 43, 167, 48),
                                3,
                                Icons.check,
                                context);
                          } else {
                            showToast(
                                _infoViewModel
                                    .usageHabitsRequestsModel!.message.message,
                                const Color(0xfff1556c),
                                3,
                                Icons.close,
                                context);
                          }
                        }
                        Future.delayed(const Duration(seconds: 3))
                            .whenComplete(() => setState(() {
                                  isClickUsageHabits = !isClickUsageHabits;
                                }));
                      },
                      title: 'Kaydet')
                ],
              ))
        ],
      ),
    );
  }

  Widget buildHouseProfile() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(4.0),
                child: Text('Eğitim Durumunuz'),
              ),
              const SizedBox(),
              Container(
                decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color.fromARGB(85, 24, 23, 23)),
                    borderRadius: BorderRadius.circular(15)),
                width: MediaQuery.of(context).size.width,
                child: DropdownButtonHideUnderline(
                  child: Observer(builder: (_) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: DropdownButton<String>(
                        value: _infoViewModel.educationStatus,
                        icon: const Icon(Icons.arrow_drop_down),
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? newValue) {
                          _infoViewModel.updateEducation(newValue);
                        },
                        items: _infoViewModel.educationList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(4.0),
                child: Text('Çalışma Durumunuz'),
              ),
              const SizedBox(),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(85, 24, 23, 23)),
                      borderRadius: BorderRadius.circular(15)),
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButtonHideUnderline(
                    child: Observer(builder: (_) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: DropdownButton<String>(
                          value: _infoViewModel.workingStatus,
                          icon: const Icon(Icons.arrow_drop_down),
                          elevation: 16,
                          style: const TextStyle(color: Colors.black),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? newValue) {
                            _infoViewModel.updateWorking(newValue);
                          },
                          items: _infoViewModel.workingList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Center(child: Text(value)),
                            );
                          }).toList(),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(4.0),
                child: Text(
                    'Mesleği öğrenebilir miyim? ( Ev Hanımı ve ya Öğrenci iseniz , evin geçiminden sorumlu kişi için cevap veriniz. Emekli iseniz , emekli olmadan önce yaptığınız mesleği düşünerek cevap veriniz !)'),
              ),
              Container(
                decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color.fromARGB(85, 24, 23, 23)),
                    borderRadius: BorderRadius.circular(15)),
                width: MediaQuery.of(context).size.width,
                child: DropdownButtonHideUnderline(
                  child: Observer(builder: (_) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: DropdownButton<String>(
                        value: _infoViewModel.jobStatus,
                        icon: const Icon(Icons.arrow_drop_down),
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? newValue) {
                          _infoViewModel.updateJob(newValue);
                        },
                        items: _infoViewModel.jobList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  PageView buildPageView() {
    return PageView(
      onPageChanged: (value) {
        _currentPageNotifier.value = value;
      },
      scrollDirection: Axis.horizontal,
      controller: _infoViewModel.pageController,
      children: [
        //Yaşadığınız ev kendinize mi ait?
        Scrollbar(
          controller: scrollController1,
          thickness: 10,
          radius: const Radius.circular(5),
          child: Observer(builder: (_) {
            return SingleChildScrollView(
              controller: scrollController1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '1-) Yaşadığınız ev kendinize mi ait?',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const Divider(thickness: 3),
                  ListTile(
                    title: const Text('Evet, kendime ait'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option0,
                      groupValue: _infoViewModel.livingStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateLiving(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Evet, aileme ait'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option1,
                      groupValue: _infoViewModel.livingStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateLiving(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Kira'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option2,
                      groupValue: _infoViewModel.livingStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateLiving(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Lojman'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option3,
                      groupValue: _infoViewModel.livingStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateLiving(value);
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
        //Sigara kullanıyor musunuz?
        Scrollbar(
          controller: scrollController2,
          isAlwaysShown: true,
          thickness: 10,
          radius: const Radius.circular(5),
          child: Observer(builder: (_) {
            return SingleChildScrollView(
              controller: scrollController2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '2-) Sigara kullanıyor musunuz?',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const Divider(thickness: 3),
                  ListTile(
                    title: const Text('Evet'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option0,
                      groupValue: _infoViewModel.smokeStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateSmoke(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Hayır'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option1,
                      groupValue: _infoViewModel.smokeStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateSmoke(value);
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
        //Alkol kullanıyor musunuz?
        Scrollbar(
          child: Observer(builder: (_) {
            return SingleChildScrollView(
              controller: scrollController3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '3-) Alkol kullanıyor musunuz?',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const Divider(thickness: 3),
                  ListTile(
                    title: const Text('Evet'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option0,
                      groupValue: _infoViewModel.drinkStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateDrink(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Hayır'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option1,
                      groupValue: _infoViewModel.drinkStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateDrink(value);
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
        // Ortalama ne sıklıkla internet üzerinden alışveriş yapıyorsunuz ?
        Scrollbar(
          controller: scrollController4,
          isAlwaysShown: true,
          thickness: 10,
          radius: const Radius.circular(5),
          child: Observer(builder: (_) {
            return SingleChildScrollView(
              controller: scrollController4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '4-) Ortalama ne sıklıkla internet üzerinden alışveriş yapıyorsunuz?',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const Divider(thickness: 3),
                  ListTile(
                    title: const Text('Haftada birden daha sık'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option0,
                      groupValue: _infoViewModel.howToChangeInternetStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updatehowToChangeInternetStatus(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Haftada bir'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option1,
                      groupValue: _infoViewModel.howToChangeInternetStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updatehowToChangeInternetStatus(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('2-3 haftada bir'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option2,
                      groupValue: _infoViewModel.howToChangeInternetStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updatehowToChangeInternetStatus(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Ayda bir'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option3,
                      groupValue: _infoViewModel.howToChangeInternetStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updatehowToChangeInternetStatus(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Ayda birden seyrek'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option4,
                      groupValue: _infoViewModel.howToChangeInternetStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updatehowToChangeInternetStatus(value);
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
        // Aracnınız var mı?
        Scrollbar(
          controller: scrollController5,
          isAlwaysShown: true,
          thickness: 10,
          radius: const Radius.circular(5),
          child: Observer(builder: (_) {
            return SingleChildScrollView(
              controller: scrollController5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '5-) Şu anda kullanmakta olduğunuz bir aracınız var mı?',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const Divider(thickness: 3),
                  ListTile(
                    title: const Text('Evet, kendime ait bir aracım var'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option0,
                      groupValue: _infoViewModel.haveCarStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateHaveCar(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Evet, haneye ait bir aracım var'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option1,
                      groupValue: _infoViewModel.haveCarStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateHaveCar(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Şirket aracı var'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option2,
                      groupValue: _infoViewModel.haveCarStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateHaveCar(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Yok'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option3,
                      groupValue: _infoViewModel.haveCarStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateHaveCar(value);
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
        // Çocuğunuz var mı?
        Scrollbar(
          controller: scrollController6,
          isAlwaysShown: true,
          thickness: 10,
          radius: const Radius.circular(5),
          child: SingleChildScrollView(
            controller: scrollController6,
            child: Observer(builder: (_) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '6-) Çocuğunuz var mı?',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const Divider(thickness: 3),
                  ListTile(
                    title: const Text('Hayır, yok'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option0,
                      groupValue: _infoViewModel.haveChildStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateHaveChild(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('1 çocuk'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option1,
                      groupValue: _infoViewModel.haveChildStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateHaveChild(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('2 çocuk'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option2,
                      groupValue: _infoViewModel.haveChildStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateHaveChild(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('3 çocuk'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option3,
                      groupValue: _infoViewModel.haveChildStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateHaveChild(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('4 çocuk'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option4,
                      groupValue: _infoViewModel.haveChildStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateHaveChild(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('5+ çocuk'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option5,
                      groupValue: _infoViewModel.haveChildStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateHaveChild(value);
                      },
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
        //Evcil hayvanınız var mı?
        Scrollbar(
          controller: scrollController7,
          isAlwaysShown: true,
          thickness: 10,
          radius: const Radius.circular(5),
          child: Observer(builder: (_) {
            return SingleChildScrollView(
              controller: scrollController7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '7-) Evcil hayvanınız var mı?',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const Divider(thickness: 3),
                  ListTile(
                    title: const Text('Evet'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option0,
                      groupValue: _infoViewModel.havePet,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updatePet(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Hayır'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option1,
                      groupValue: _infoViewModel.havePet,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updatePet(value);
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
        // En sık kullandığınız banka hangisidir?
        Observer(builder: (_) {
          return Scrollbar(
            controller: scrollController8,
            isAlwaysShown: true,
            thickness: 10,
            radius: const Radius.circular(5),
            child: SingleChildScrollView(
              controller: scrollController8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '8-) En sık kullandığınız banka hangisidir?',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const Divider(thickness: 3),
                  ListTile(
                    title: const Text('İşbankası'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option0,
                      groupValue: _infoViewModel.bankStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateBankStatus(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Akbank'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option1,
                      groupValue: _infoViewModel.bankStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateBankStatus(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Garanti'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option2,
                      groupValue: _infoViewModel.bankStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateBankStatus(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Yapı Kredi'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option3,
                      groupValue: _infoViewModel.bankStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateBankStatus(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('QNB Finansbank'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option4,
                      groupValue: _infoViewModel.bankStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateBankStatus(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Ziraat'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option5,
                      groupValue: _infoViewModel.bankStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateBankStatus(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('ING'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option6,
                      groupValue: _infoViewModel.bankStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateBankStatus(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('TEB'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option7,
                      groupValue: _infoViewModel.bankStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateBankStatus(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Denizbank'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option8,
                      groupValue: _infoViewModel.bankStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateBankStatus(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Vakıfbank'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option9,
                      groupValue: _infoViewModel.bankStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateBankStatus(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Halkbank'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option10,
                      groupValue: _infoViewModel.bankStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateBankStatus(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Albaraka'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option11,
                      groupValue: _infoViewModel.bankStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateBankStatus(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('KuveytTürk'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option12,
                      groupValue: _infoViewModel.bankStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateBankStatus(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Diğer'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option13,
                      groupValue: _infoViewModel.bankStatus,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateBankStatus(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        // Evinizdeki internet bağlantınızın türü aşağıdaki seçeneklerden hangisidir?
        Scrollbar(
          controller: scrollController9,
          isAlwaysShown: true,
          thickness: 10,
          radius: const Radius.circular(5),
          child: SingleChildScrollView(
            controller: scrollController9,
            child: Observer(builder: (_) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '9-) Evinizdeki internet bağlantınızın türü aşağıdaki seçeneklerden hangisidir?',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const Divider(thickness: 3),
                  ListTile(
                    title: const Text('ADSL/VDSL'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option0,
                      groupValue: _infoViewModel.howInternet,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateHowInternet(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('FIBER'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option1,
                      groupValue: _infoViewModel.howInternet,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateHowInternet(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text(
                        'FIBER YALIN (telefon hattına ihtiyaç duyulmayan)'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option2,
                      groupValue: _infoViewModel.howInternet,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateHowInternet(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text(
                        'ADSL YALIN (telefon hattına ihtiyaç duyulmayan)'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option3,
                      groupValue: _infoViewModel.howInternet,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateHowInternet(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('EVİMİZDE SABİT İNTERNET HATTI YOK'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option4,
                      groupValue: _infoViewModel.howInternet,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateHowInternet(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('BİLMİYORUM'),
                    leading: Radio<RadioButtonEnum>(
                      value: RadioButtonEnum.option5,
                      groupValue: _infoViewModel.howInternet,
                      onChanged: (RadioButtonEnum? value) {
                        _infoViewModel.updateHowInternet(value);
                      },
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
        // Çoklu seçme ilk soru
        Scrollbar(
          controller: scrollController10,
          isAlwaysShown: true,
          thickness: 10,
          radius: const Radius.circular(5),
          child: Observer(builder: (_) {
            return SingleChildScrollView(
              controller: scrollController10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '10-) Yiyecek / İçecek gibi temel gıda alışverişleriniz için aşağıdaki kanallardan hangilerini kullanıyorsunuz?',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const Divider(thickness: 3),
                  CheckboxListTile(
                    title: const Text('Bakkal / Market / Yerel marketler'),
                    value: _infoViewModel.isSelect1[0],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect1(value!, 0);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text(
                        'Zincir Hipermarket / Zincir Süpermarket (CarrefourSA, Migros… vb)'),
                    value: _infoViewModel.isSelect1[1],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect1(value!, 1);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('İndirim marketleri (BİM, A101… vb)'),
                    value: _infoViewModel.isSelect1[2],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect1(value!, 2);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Semt pazarları'),
                    value: _infoViewModel.isSelect1[3],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect1(value!, 3);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text(
                        'İnternet üzerinden online alışveriş (Migros Online, Trendyol Market, Getir, Banabi vb…)'),
                    value: _infoViewModel.isSelect1[4],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect1(value!, 4);
                      });
                    },
                  ),
                ],
              ),
            );
          }),
        ),
        //Aşağıdaki sigorta ürünlerinden hangilerine sahipsiniz?
        Observer(builder: (_) {
          return Scrollbar(
            thickness: 10,
            controller: scrollController11,
            radius: const Radius.circular(5),
            child: SingleChildScrollView(
              controller: scrollController11,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '11-) Aşağıdaki sigorta ürünlerinden hangilerine sahipsiniz?',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const Divider(thickness: 3),
                  CheckboxListTile(
                    title: const Text('Bireysel Emeklilik'),
                    value: _infoViewModel.isSelect2[0],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect2(value!, 0);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Hayat Sigortası'),
                    value: _infoViewModel.isSelect2[1],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect2(value!, 1);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Ferdi Kaza Sigortası'),
                    value: _infoViewModel.isSelect2[2],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect2(value!, 2);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Özel Sağlık Sigortası'),
                    value: _infoViewModel.isSelect2[3],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect2(value!, 3);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Ev / Dask'),
                    value: _infoViewModel.isSelect2[4],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect2(value!, 4);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Kasko Sigortası'),
                    value: _infoViewModel.isSelect2[5],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect2(value!, 5);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Trafik Sigortası'),
                    value: _infoViewModel.isSelect2[6],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect2(value!, 6);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Tamamlayıcı Sağlık Sigortası'),
                    value: _infoViewModel.isSelect2[7],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect2(value!, 7);
                      });
                    },
                  )
                ],
              ),
            ),
          );
        }),
        // Bireysel olarak kullandığınız cep telefonu operatörünü aşağıdaki ifadelerden işaretleyiniz.
        Scrollbar(
          controller: scrollController12,
          isAlwaysShown: true,
          thickness: 10,
          radius: const Radius.circular(5),
          child: SingleChildScrollView(
            controller: scrollController12,
            child: Observer(builder: (_) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '12-) Bireysel olarak kullandığınız cep telefonu operatörünü aşağıdaki ifadelerden işaretleyiniz.',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const Divider(thickness: 3),
                  CheckboxListTile(
                    title: const Text('Türk Telekom Faturalı'),
                    value: _infoViewModel.isSelect3[0],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect3(value!, 0);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Türk Telekom Faturasız'),
                    value: _infoViewModel.isSelect3[1],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect3(value!, 1);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Turkcell Faturalı'),
                    value: _infoViewModel.isSelect3[2],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect3(value!, 2);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Turkcell Faturasız'),
                    value: _infoViewModel.isSelect3[3],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect3(value!, 3);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Lifecell Faturalı'),
                    value: _infoViewModel.isSelect3[4],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect3(value!, 4);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Lifecell Faturasız'),
                    value: _infoViewModel.isSelect3[5],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect3(value!, 5);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Vodafone Faturalı'),
                    value: _infoViewModel.isSelect3[6],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect3(value!, 6);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Vodafone Faturasız'),
                    value: _infoViewModel.isSelect3[7],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect3(value!, 7);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Diğer'),
                    value: _infoViewModel.isSelect3[8],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect3(value!, 8);
                      });
                    },
                  ),
                ],
              );
            }),
          ),
        ),
        // Hangi ekipman ve tesisat evinizde mevcut?
        Scrollbar(
          controller: scrollController13,
          isAlwaysShown: true,
          thickness: 10,
          radius: const Radius.circular(5),
          child: SingleChildScrollView(
            controller: scrollController13,
            child: Observer(builder: (_) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '13-) Hangi ekipman ve tesisat evinizde mevcut?',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const Divider(thickness: 3),
                  CheckboxListTile(
                    title: const Text('Elektrik'),
                    value: _infoViewModel.isSelect4[0],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect4(value!, 0);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title:
                        const Text('Doğalgaz (doğrudan evinize pompalanıyor)'),
                    value: _infoViewModel.isSelect4[1],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect4(value!, 1);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Merkezi ısıtma '),
                    value: _infoViewModel.isSelect4[2],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect4(value!, 2);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text(
                        'Havalandırma (monte edilmiş, portatif DEĞİL)'),
                    value: _infoViewModel.isSelect4[3],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect4(value!, 3);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text(
                        'Elektronik güvenlik sistemi (ör. hırsız alarmı)'),
                    value: _infoViewModel.isSelect4[4],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect4(value!, 4);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text(
                        'Alafranga/alaturka sifonlu tuvalet(kovayla su dökülen değil)'),
                    value: _infoViewModel.isSelect4[5],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect4(value!, 5);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text(
                        'Alaturka tuvalet (Sadece kova ile su dokulen)'),
                    value: _infoViewModel.isSelect4[6],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect4(value!, 6);
                      });
                    },
                  ),
                ],
              );
            }),
          ),
        ),
        //Evinizde çalışır durumda okuyacağım eşyalardan hangileri mevcut?
        Scrollbar(
          controller: scrollController14,
          isAlwaysShown: true,
          thickness: 10,
          radius: const Radius.circular(5),
          child: SingleChildScrollView(
            controller: scrollController14,
            child: Observer(builder: (_) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '14-) Evinizde çalışır durumda okuyacağım eşyalardan hangileri mevcut?',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const Divider(thickness: 3),
                  CheckboxListTile(
                    title: const Text('Mutfak lavabosu'),
                    value: _infoViewModel.isSelect5[0],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 0);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Yemek masası'),
                    value: _infoViewModel.isSelect5[1],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 1);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text(
                        'Primus (gaz sobası) / silindir bazlı gaz sobası'),
                    value: _infoViewModel.isSelect5[2],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 2);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text(
                        'Buzdolabı (bağımsız - buzluğu olabilir ama ayrı bir kapağı olan derin dondurucusu YOK)'),
                    value: _infoViewModel.isSelect5[3],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 3);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text(
                        'Derin donduruculu buzdolabı (başka bir deyişle derin dondurucu için budolabı kapağından ayrı bir kapağı var)'),
                    value: _infoViewModel.isSelect5[4],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 4);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Ayrı derin dondurucu'),
                    value: _infoViewModel.isSelect5[5],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 5);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Fırın'),
                    value: _infoViewModel.isSelect5[6],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 6);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Elektrik süpürgesi'),
                    value: _infoViewModel.isSelect5[7],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 7);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Elektrikli su ısıtıcı'),
                    value: _infoViewModel.isSelect5[8],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 8);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Mikrodalga fırın'),
                    value: _infoViewModel.isSelect5[9],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 9);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Çamaşır makinesi'),
                    value: _infoViewModel.isSelect5[10],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 10);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Çamaşır kurutma makinesi'),
                    value: _infoViewModel.isSelect5[11],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 11);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Bulaşık makinesi'),
                    value: _infoViewModel.isSelect5[12],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 12);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Elektrikli fritöz'),
                    value: _infoViewModel.isSelect5[13],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 13);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Elektrikli mikser'),
                    value: _infoViewModel.isSelect5[14],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 14);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Elektrikli ütü'),
                    value: _infoViewModel.isSelect5[15],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 15);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Su arıtma cihaz'),
                    value: _infoViewModel.isSelect5[16],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 16);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Ev telefonu'),
                    value: _infoViewModel.isSelect5[17],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 17);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Faks makinesi'),
                    value: _infoViewModel.isSelect5[18],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 18);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text(
                        'Hi-Fi / stereo müzik seti (kaset,CD veya plak)'),
                    value: _infoViewModel.isSelect5[19],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 19);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text(
                        'Video oynatıcısı/ video kayıt cihazı (VCR)'),
                    value: _infoViewModel.isSelect5[20],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 20);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text(
                        'DVD kayıt cihazı (sadece DVD oynatıcısı değil) '),
                    value: _infoViewModel.isSelect5[21],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 21);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title:
                        const Text('Elektronik araç navigasyon sistemi / GPS '),
                    value: _infoViewModel.isSelect5[22],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 22);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text(
                        'Taşınabilir hoparlör  sistemi (iPOD ve MP3 çalar için)'),
                    value: _infoViewModel.isSelect5[23],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 23);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text(
                        'Ev sinema sistemi/ HDD multimedya oynatıcı (Cine 5, digiturk dışında)'),
                    value: _infoViewModel.isSelect5[24],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 24);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Bisiklet'),
                    value: _infoViewModel.isSelect5[25],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 25);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text(
                        'Radyo (müzik setinin  yada alarm saatin bir parçası olmayan)'),
                    value: _infoViewModel.isSelect5[26],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 26);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Radyolu alarm saati'),
                    value: _infoViewModel.isSelect5[27],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 27);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Masaüstü bilgisayar'),
                    value: _infoViewModel.isSelect5[28],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 28);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Dizüstü bilgisayar'),
                    value: _infoViewModel.isSelect5[29],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 29);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Fotoğraf makinesi (dijital olmayan)'),
                    value: _infoViewModel.isSelect5[30],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 30);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Fotoğraf makinesi (dijital)'),
                    value: _infoViewModel.isSelect5[31],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 31);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Video kamera (dijital olmayan)'),
                    value: _infoViewModel.isSelect5[32],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 32);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Video kamera (dijital)'),
                    value: _infoViewModel.isSelect5[33],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 33);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('CD / kaset çalar '),
                    value: _infoViewModel.isSelect5[34],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 34);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('MP3 çala r/ iPod'),
                    value: _infoViewModel.isSelect5[35],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 35);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Cep/araç telefonu'),
                    value: _infoViewModel.isSelect5[36],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 36);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('E-posta fonksiyonlu cep telefonu'),
                    value: _infoViewModel.isSelect5[37],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 37);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text(
                        'Oyun konsolu (ev tipi veya taşınabilir/ avuçiçi)'),
                    value: _infoViewModel.isSelect5[38],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 38);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Siyah-beyaz Televizyon'),
                    value: _infoViewModel.isSelect5[39],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 39);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Renkli TV, tüplü (katod ışın tüpü)'),
                    value: _infoViewModel.isSelect5[40],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 40);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Renkli TV, LCD/ Plazma '),
                    value: _infoViewModel.isSelect5[41],
                    onChanged: (value) {
                      setState(() {
                        _infoViewModel.changeIsSelect5(value!, 41);
                      });
                    },
                  ),
                ],
              );
            }),
          ),
        ),
        //Evinizde okuyacağım spor ve hobi malzemelerinden herhangi biri var mı, siz bunlardan herhangi birine sahip misiniz?
        Observer(builder: (_) {
          return Scrollbar(
            controller: scrollController15,
            isAlwaysShown: true,
            thickness: 10,
            radius: const Radius.circular(5),
            child: SingleChildScrollView(
              controller: scrollController15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '15-) Evinizde okuyacağım spor ve hobi malzemelerinden herhangi biri var mı, siz bunlardan herhangi birine sahip misiniz?',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const Divider(thickness: 3),
                  Column(
                    children: [
                      CheckboxListTile(
                        title: const Text('Golf ekipmanı'),
                        value: _infoViewModel.isSelect6[0],
                        onChanged: (value) {
                          setState(() {
                            _infoViewModel.changeIsSelect6(value!, 0);
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('Scuba dalış/ sörf ekipmanı'),
                        value: _infoViewModel.isSelect6[1],
                        onChanged: (value) {
                          setState(() {
                            _infoViewModel.changeIsSelect6(value!, 1);
                          });
                        },
                      ),
                      CheckboxListTile(
                        title:
                            const Text('Kayak/kar sörfü/buz pateni ekipmanı'),
                        value: _infoViewModel.isSelect6[2],
                        onChanged: (value) {
                          setState(() {
                            _infoViewModel.changeIsSelect6(value!, 2);
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text(
                            'Planör / delta-kanat / yamaç paraşütü (motorsuz)'),
                        value: _infoViewModel.isSelect6[3],
                        onChanged: (value) {
                          setState(() {
                            _infoViewModel.changeIsSelect6(value!, 3);
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('Koşu bandı ve diğer spor aletleri '),
                        value: _infoViewModel.isSelect6[4],
                        onChanged: (value) {
                          setState(() {
                            _infoViewModel.changeIsSelect6(value!, 4);
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('Deniz motoru / yelkenli '),
                        value: _infoViewModel.isSelect6[5],
                        onChanged: (value) {
                          setState(() {
                            _infoViewModel.changeIsSelect6(value!, 5);
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('Yüzme havuzu'),
                        value: _infoViewModel.isSelect6[6],
                        onChanged: (value) {
                          setState(() {
                            _infoViewModel.changeIsSelect6(value!, 6);
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text(
                            'Profesyonel müzik aleti (ör. piyano, keman vb)'),
                        value: _infoViewModel.isSelect6[7],
                        onChanged: (value) {
                          setState(() {
                            _infoViewModel.changeIsSelect6(value!, 7);
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('Sıcak su havuzu / Jakuzi/Sauna'),
                        value: _infoViewModel.isSelect6[8],
                        onChanged: (value) {
                          setState(() {
                            _infoViewModel.changeIsSelect6(value!, 8);
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
