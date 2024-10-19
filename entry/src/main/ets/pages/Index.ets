import TabsView from "../components/TabsView"

@Entry
@Component
struct Index {

  build() {
    Column(){
      TabsView()
    }
    .width("100%")
    .height("100%")
    .backgroundColor("#f3f4f5")
  }
}