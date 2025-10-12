String checkerPriority(int valueSlider) {
  String text = "";
  if (valueSlider == 0) {
    text = "Низкий";
  } else if (valueSlider == 1) {
    text = "Средний";
  } else if (valueSlider == 2) {
    text = "Высокий";
  }
  return text;
}
