///    This program is free software: you can redistribute it and/or modify
///    it under the terms of the GNU General Public License as published by
///    the Free Software Foundation, either version 3 of the License, or
///    (at your option) any later version.
///
///    This program is distributed in the hope that it will be useful,
///    but WITHOUT ANY WARRANTY; without even the implied warranty of
///    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
///    GNU General Public License for more details.
///
///    You should have received a copy of the GNU General Public License
///    along with this program.  If not, see <https://www.gnu.org/licenses/>.
import 'package:json_annotation/json_annotation.dart';

import 'base_post_model.dart';

part 'faq_category_model.g.dart';

@JsonSerializable(includeIfNull: false)
class FaqCategoryModel extends BasePostModel {
  /// FAQ Title
  @JsonKey(name: 'name')
  final String name;

  /// FAQ Category ID
  @JsonKey(name: 'category_id')
  final int categoryId;

  /// Constructor
  ///
  /// All Fields are mandatory
  ///
  FaqCategoryModel(
    int id,
    this.name,
    this.categoryId,
  ) : super(
          id: id,
        );

  /// Mapper from Json to Model
  factory FaqCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$FaqCategoryModelFromJson(json);

  /// Maps Model to Json
  Map<String, dynamic> toJson() => _$FaqCategoryModelToJson(this);
}
