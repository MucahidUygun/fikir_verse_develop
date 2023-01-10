import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/extension/context_extension.dart';
import '../../../core/init/config.dart';
import '../../../core/widget/app_bar_widget.dart';
import '../../../core/widget/side_menu.dart';

class AboutUsView extends StatefulWidget {
  const AboutUsView({Key? key}) : super(key: key);

  @override
  State<AboutUsView> createState() => _AboutUsViewState();
}

class _AboutUsViewState extends State<AboutUsView> {
  ScrollController aboutUs = ScrollController();

  double offset = 0.0;

  ScrollController howItWork = ScrollController();

  ScrollController faq = ScrollController();

  @override
  void initState() {
    aboutUs = ScrollController() //keepScrollOffset: false removed
      ..addListener(() {
        setState(() {
          //<-----------------------------
          offset = aboutUs.offset;
          // force a refresh so the app bar can be updated
        });
      });
    howItWork = ScrollController() //keepScrollOffset: false removed
      ..addListener(() {
        setState(() {
          //<-----------------------------
          offset = howItWork.offset;
          // force a refresh so the app bar can be updated
        });
      });
    faq = ScrollController() //keepScrollOffset: false removed
      ..addListener(() {
        setState(() {
          //<-----------------------------
          offset = faq.offset;
          // force a refresh so the app bar can be updated
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    aboutUs.dispose();
    faq.dispose();
    howItWork.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const SideMenu(),
        appBar: PreferredSize(
          preferredSize: Size(context.width, context.heightNormalAppBar),
          child: const BuildAppBar(
            title: 'Fikirverse Nedir?',
            isShowPoint: true,
          ),
        ),
        body: buildAccordion());
  }

  Accordion buildAccordion() {
    return Accordion(
      openAndCloseAnimation: true,
      maxOpenSections: 1,
      headerBackgroundColorOpened: const Color(0xff47b2e4),
      headerBackgroundColor: const Color(0xff37517e),
      disableScrolling: true,
      children: [
        AccordionSection(
          isOpen: true,
          header: const Text(
            'Hakkımızda',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          content: Scrollbar(
            controller: aboutUs,
            child: SingleChildScrollView(
              controller: aboutUs,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: const WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: "${siteBaseUrl}mobile-about-us?token=$token",
                ),
              ),
            ),
          ),
        ),
        AccordionSection(
          isOpen: false,
          header: const Text(
            'Nasıl Çalışır?',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          content: Scrollbar(
            controller: howItWork,
            child: SingleChildScrollView(
              controller: howItWork,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: const WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl:
                      '${siteBaseUrl}mobile-how-does-it-work?token=$token',
                ),
              ),
            ),
          ),
        ),
        AccordionSection(
          isOpen: false,
          header: const Text(
            'Sıkça Sorulan Sorular',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          content: Scrollbar(
            controller: faq,
            child: SingleChildScrollView(
              controller: faq,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: const WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: '${siteBaseUrl}mobile-faq?token=$token',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
