import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:oikosmobile/core/Utils/colorsConstant.dart';
import 'package:oikosmobile/core/Utils/customText.dart';
import 'package:oikosmobile/features/Properties/presentation/widgets/filtred_image_widget.dart';
import 'package:photofilters/filters/filters.dart';

class FilteredImageListWidget extends StatefulWidget {
  final List<Filter> filters;
  final img.Image image;
  final ValueChanged<Filter> onChangedFilter;
   FilteredImageListWidget({
    Key key,
    @required this.filters,
    @required this.image,
    @required this.onChangedFilter,
  }) : super(key: key);

  @override
  _FilteredImageListWidgetState createState() => _FilteredImageListWidgetState();
}

class _FilteredImageListWidgetState extends State<FilteredImageListWidget> {
  int selectedPic;
  @override
  void initState() {
    imageCache.clear();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    const double height = 150;

    return Container(
      height: height,
      color: Color(0xFF0060A2).withOpacity(0.93),
      child: Padding(
        padding:  EdgeInsets.only(left: 20),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.filters.length,
          itemBuilder: (context, index) {
            final filter = widget.filters[index];

            return InkWell(
              onTap: () {
                widget.onChangedFilter(filter);
                setState(() {
                  selectedPic =index;
                  print(selectedPic);
                });

              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Center(
                  child: Stack(
                    children: [
                      FilteredImageWidget(
                        filter: filter,
                        image: widget.image,
                        successBuilder: (imageBytes) => /*CircleAvatar(
                            radius: 50,
                            backgroundImage: MemoryImage(imageBytes),
                            backgroundColor: Colors.white,
                          )*/Container(
                          height: 130,
                          width: 70,
                          color: Colors.white,
                          child: Image(
                            image: MemoryImage(imageBytes),
                            fit: BoxFit.cover,
                          ),
                        ),
                        errorBuilder: () => Container(
                          height: 130,
                          width: 70,
                          child: Center(child: Icon(Icons.report, size: 32)),
                          color: Colors.white,
                        ),
                        loadingBuilder: () => Container(
                          height: 130,
                          width: 70,
                          child: Center(child: CircularProgressIndicator()),
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 30,
                          width: 70,
                          color: Color(0xFF303030).withOpacity(0.73),
                          child: Center(
                            child: CustomText(
                              value: filter.name,
                              color: ColorConstant.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      if (index == selectedPic)
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Icon(
                            Icons.check_circle,
                            color: Color(0xff1EC501),
                          ),
                        )

                    ],
                  ),
                ),
              )
            );
          },
        ),
      ),
    );
  }
}