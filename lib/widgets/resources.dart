import 'package:flutter/material.dart';

class Resources extends StatefulWidget {
  const Resources({super.key});

  @override
  _ResourcesState createState() => _ResourcesState();
}

class _ResourcesState extends State<Resources> {
  final PageController _pageController = PageController();

  static const Map<String, dynamic> tutorialData = {
    "Land Preparation": {
      "crop": "Cauliflower",
      "steps": [
        {
          "title": "बेर्ना सार्नको लागि जग्गाको तयारी",
          "picture": "https://soil.narc.gov.np/media/media/crop/l1_yqTrpby.png",
          "description":
              "बेर्ना सार्नुभन्दा कम्तीमा १५ दिन अघि राम्ररी कुहेको प्राङ्गारिक मल १५०० किलो प्रति रोपनीका दरले माटोमा हाल्नु पर्छ |",
        },
        {
          "title": "बेर्ना सार्नको लागि जग्गाको तयारी",
          "picture": "https://soil.narc.gov.np/media/media/crop/l2_GqsQipB.png",
          "description":
              "माटोको बनोट र चिस्यान कायम राख्ने क्षमता सुधार्न बलौटे माटोमा थप प्राङ्गारिक मल हाल्नु पर्छ ।",
        },
      ],
    },
    "Nursery": {
      "crop": "Cauliflower",
      "steps": [
        {
          "title": "नर्सरी ठाउँको छनोट",
          "picture":
              "https://soil.narc.gov.np/media/media/crop/n1_1_13r5cRo.png",
          "description": "नर्सरीको लागि पारिलो, अग्लो र नजिकको ठाउँ हुनुपर्छ ।",
        },
        {
          "title": "माटो",
          "picture": "https://soil.narc.gov.np/media/media/crop/n2_78Jnx2b.png",
          "description":
              "यदि माटो चिम्टाइलो छ भने उचित निकास र हावा प्रवाहको लागि माटोलाई खुकुलो पार्न पर्याप्त मात्रामा कम्पोष्ट मल हाल्नुपर्छ ।",
        },
        {
          "title": "आकार",
          "picture":
              "https://soil.narc.gov.np/media/media/crop/n3_82ISlKI_5nDhDxB.png",
          "description":
              "नर्सरी ब्याडको माटो मसिनो नभएसम्म खनजोत गर्नुपर्छ । १ मिटर चौडाइ, १०—१५ सेन्टिमिटर उठेको र आवश्यकता अनुसार लम्बाई भएको नर्सरी बेड तयार गर्नु पर्छ ।",
        },
        {
          "title": "प्राङ्गारिक तथा रासायनिक मल",
          "picture":
              "https://soil.narc.gov.np/media/media/crop/n4_Mq7R8kb_dg3tYXb.png",
          "description":
              "प्राङ्गारिक तथा रासायनिक मलले स्वस्थ बेर्ना उत्पादन गर्न मद्दत गर्छ । प्राङ्गारिक मलले बेर्नालाई खाद्यतत्वहरू दिन्छ र बेर्नाको वृद्धि तथा तन्दुरुस्ती पनि बढाउँछ ।",
        },
        {
          "title": "नर्सरीमा बीउ रोप्ने",
          "picture": "https://soil.narc.gov.np/media/media/crop/n5_xwjxGrx.png",
          "description":
              "क रोपनी जग्गाका लागि १०(१५ ग्राम बीउ चाहिन्छ । पाँच—पाँच सेन्टिमिटरको फरकमा बनाइएका लाइनमा १—१ सेन्टिमिरको फरकमा १ सेन्टिमिटर गहिरो हुने गरी बीउ रोप्नु पर्छ ।",
        },
        {
          "title": "नर्सरी हेरचाह",
          "picture": "https://soil.narc.gov.np/media/media/crop/n6_gX4UEZJ.png",
          "description":
              "उच्च तापक्रम र वर्षाबाट नर्सरीलाई जोगाउन भुइँबाट करिब ९०-१२० सेन्टिमिटर माथिबाट सेडिब जाल (कजभममष्लन लभत) वा कालो पोलिथिनल वा खरको छाप्रो दिनुपर्छ ।",
        },
        {
          "title": "NURSERY TUNNEL TO PROTECT FROM COLD",
          "picture": "https://soil.narc.gov.np/media/media/crop/n7_Jnclptc.png",
          "description":
              "आवश्यकता अनुसार झारपात उखेल्नुपर्छ । रोग वा कीराको समस्या देखिएमा नजिकको एग्रो—भेट, जेटी/जेटीए अथवा कृषिसंग सम्बन्धित अन्य संघ संस्थामा सम्पर्क गर्नुपर्छ ।",
        },
      ],
    },
    "Transplanting": {
      "crop": "Cauliflower",
      "steps": [
        {
          "title": "बेर्ना जरखर्याउने",
          "picture": "https://soil.narc.gov.np/media/media/crop/t1_BOqo3o9.png",
          "description":
              "सावधानीपूर्वक बेर्ना नउखेल्दा बेर्नाका जरा क्षतिग्रस्त हुन सक्छन्।",
        },
        {
          "title": "मल व्यवस्थापन",
          "picture": "https://soil.narc.gov.np/media/media/crop/t2_cQbxbZQ.png",
          "description":
              "बेर्ना सार्ने बेलामा १ रोपनी जग्गामा १३ किलो डी.ए.पी. र ८.३ किलो पोटास मल हाल्नु पर्छ ।",
        },
      ],
    },
    "Top Dressing": {
      "crop": "Cauliflower",
      "steps": [
        {
          "title": "युरिया टपड्रेसिङ",
          "picture":
              "https://soil.narc.gov.np/media/media/crop/td1_56nHZPh.png",
          "description":
              "टपड्रेस गर्नु अघि झारपात उखेल्नु पर्छ र सिंचाई गरेको एक दुई दिनमा टपड्रेस गर्नुपर्छ । युरिया टपड्रेसिबले अन्य खाद्यतत्वको राम्रो उपयोगलाई सहयोग गर्छ र बालीको समग्र वृद्धि तथा उत्पादनमा मद्दत पुरयाउँछ ।",
        },
        {
          "title": "युरिया टपड्रेसिङ",
          "picture":
              "https://soil.narc.gov.np/media/media/crop/td2_GNra2xI.png",
          "description":
              "पहिलो र दोस्रो टप ड्रेसिबमा क्रमशः ८.३ किलो र ८.३ किलो युरिया प्रतिरोपनी हाल्नुपर्छ ।",
        },
      ],
    },
    "Harvesting": {
      "crop": "Cauliflower",
      "steps": [
        {
          "title": "काउली टिप्ने",
          "picture":
              "https://soil.narc.gov.np/media/media/crop/h1_y1dV3c3_2z9jeM4.png",
          "description":
              "फूलकोपीमा परिपक्वता आउनासाथ काउली टिप्नुपर्छ । जात अनुसार बेर्ना सारेको ६५—७५ दिनपछि अगौटे जातका काउली, ९०—१०० दिनपछि मध्यम जातका काउली र ११०—१३० दिनपछि पछौटे जातका काउली टिप्नु पर्छ ।",
        },
        {
          "title": "काउली टिप्ने",
          "picture":
              "https://soil.narc.gov.np/media/media/crop/h2_aW8PWnU_QzFaGn1.png",
          "description":
              "काउली विहानको पछिल्लो समयमा वा बेलुकाको शुरुको समयमा टिप्नु उपयुक्त हुन्छ",
        },
      ],
    },
    "Post Harvest": {
      "crop": "Cauliflower",
      "steps": [
        {
          "title": "गुणस्तर छुट्याउने र ग्रेडिब गर्ने",
          "picture":
              "https://soil.narc.gov.np/media/media/crop/ph1_eNoJrCr.png",
          "description":
              "रोगी, कीरा लागेका, क्षति भएका र अन्य कारणबाट बेच्न अयोग्य काउलीलाई खेतबारीमै हटाउनुपर्छ । प्याक गृह वा सङ्कलन केन्द्रमा पठाउनु अघि अनावश्यक पात तथा डाँठको काँटछाँट गर्नुपर्छ ।",
        },
        {
          "title": "प्याकेजिब र भण्डारण",
          "picture":
              "https://soil.narc.gov.np/media/media/crop/ph4_nWoTkst.png",
          "description":
              "काउलीलाई ढुवानी गर्न प्लास्टिक क्रेट राम्रोप्याकेजिब सामग्री हो, किनभने यसको भित्री भाग चिल्लोहुनुका साथै यसलाई सफा गर्न सजिलो हुन्छ र धेरै पटक प्रयोग गर्न सकिन्छ ।",
        },
      ],
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('काउली खेती - ट्युटोरियल'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: tutorialData.length,
              itemBuilder: (context, index) {
                final title = tutorialData.keys.elementAt(index);
                final steps = tutorialData[title]['steps'] as List;

                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...List.generate(steps.length, (stepIndex) {
                      final step = steps[stepIndex];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white, // Change to blue
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${stepIndex + 1}. ${step['title']}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(step['description']),
                                const SizedBox(height: 12),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    step['picture'],
                                    height: 80,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_pageController.page! > 0) {
                                _pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  8,
                                ), // Decreased radius
                              ),
                            ),
                            child: const Text('Previous'),
                          ),
                          const SizedBox(width: 100),
                          ElevatedButton(
                            onPressed: () {
                              if (_pageController.page! <
                                  tutorialData.length - 1) {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },

                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  8,
                                ), // Decreased radius
                              ),
                            ),
                            child: const Text('Next'),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
