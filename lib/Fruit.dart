class Fruit {
  String fruitName = "";
  String fruitColor = "";

  //{} for named parameter So, If we alternate the param position then also it will reflect correctly
  Fruit({required this.fruitName, required this.fruitColor}){
    this.fruitName = fruitName;
    this.fruitColor = fruitColor;
  }

}