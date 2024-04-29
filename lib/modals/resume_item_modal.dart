class ResumeItemModal {
  String name;
  List item;

  ResumeItemModal(this.name, this.item);

  factory ResumeItemModal.fromMap({required Map data}) {
    return ResumeItemModal(data['name'], data['item']);
  }
}
