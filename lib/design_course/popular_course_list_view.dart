import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vnr_connect/design_course/category_list_view.dart';
import 'package:vnr_connect/design_course/design_course_app_theme.dart';
import 'package:vnr_connect/design_course/models/category.dart';
import 'package:flutter/material.dart';

class PopularCourseListView extends StatefulWidget {
  const PopularCourseListView({Key? key, this.callBack}) : super(key: key);

  final Function()? callBack;
  @override
  State<PopularCourseListView> createState() => _PopularCourseListViewState();
}

class _PopularCourseListViewState extends State<PopularCourseListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("Events").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return GridView(
              padding: const EdgeInsets.all(8),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 32.0,
                crossAxisSpacing: 32.0,
                childAspectRatio: 0.8,
              ),
              children: List<Widget>.generate(
                //snapshot.data!.docs.length,
                4,
                (int index) {
                  final int count = snapshot.data!.docs.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController!,
                      curve: Interval((1 / count) * index, 1.0,
                          curve: Curves.fastOutSlowIn),
                    ),
                  );
                  animationController?.forward();
                  DocumentSnapshot document = snapshot.data!.docs[index];
                  return CategoryView(
                    document: document,
                    callback: widget.callBack,
                    category: Category.popularCourseList[index],
                    animation: animation,
                    animationController: animationController,
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView(
      {Key? key,
      this.category,
      this.animationController,
      this.animation,
      this.callback,required this.document})
      : super(key: key);

  final VoidCallback? callback;
  final Category? category;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final DocumentSnapshot document;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("Events").snapshots(),
      builder: (context, snapshot) {
        return AnimatedBuilder(
          animation: animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: animation!,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 50 * (1.0 - animation!.value), 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  onTap: callback,
                  child: SizedBox(
                    height: 280,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: HexColor('#F8FAFB'),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16.0)),
                                  // border: new Border.all(
                                  //     color: DesignCourseAppTheme.notWhite),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 16, left: 16, right: 16),
                                            child: Text(
                                              (document.data() as Map<String , dynamic>)['eventName'],
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                letterSpacing: 0.27,
                                                color: DesignCourseAppTheme
                                                    .darkerText,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8,
                                                left: 16,
                                                right: 16,
                                                bottom: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  '${category!.lessonCount} lesson',
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 12,
                                                    letterSpacing: 0.27,
                                                    color: DesignCourseAppTheme
                                                        .grey,
                                                  ),
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                      '${category!.rating}',
                                                      textAlign:
                                                          TextAlign.left,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w200,
                                                        fontSize: 18,
                                                        letterSpacing: 0.27,
                                                        color:
                                                            DesignCourseAppTheme
                                                                .grey,
                                                      ),
                                                    ),
                                                    const Icon(
                                                      Icons.star,
                                                      color:
                                                          DesignCourseAppTheme
                                                              .nearlyBlue,
                                                      size: 20,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 48,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 48,
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 24, right: 16, left: 16),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16.0)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: DesignCourseAppTheme.grey
                                        .withOpacity(0.2),
                                    offset: const Offset(0.0, 0.0),
                                    blurRadius: 6.0),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16.0)),
                              child: AspectRatio(
                                  aspectRatio: 1.28,
                                  child: Image.asset(category!.imagePath)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }
    );
  }
}