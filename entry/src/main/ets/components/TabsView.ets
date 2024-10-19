import HomePage from "../pages/HomePage"
import PersonPage from "../pages/PersonPage"

@Component
export default  struct TabsView{

  @State currentIndex:number = 0

  @Builder tabBuilder(title:string,targetIndex:number,selectedImg:Resource,normalImg:Resource){
      Column(){
        Image(this.currentIndex === targetIndex ? selectedImg : normalImg).size({ width:28,height:28 })
        Text(title).fontSize(14).fontColor(this.currentIndex === targetIndex ? "#ff4444" : "#DFDFDF")
      }
      .width("100%")
      .height(60)
      .justifyContent(FlexAlign.Center)
  }


  build() {
    Column(){
      Tabs({ barPosition:BarPosition.End }){
        TabContent(){
          Column(){
            HomePage()
          }.width("100%").height("100%").backgroundColor("#f3f4f5")
        }.tabBar(this.tabBuilder("首页",0,$r("app.media.home_selected"),$r("app.media.home_default")))
        TabContent(){
          Column(){
            Text("视频内容")
          }.width("100%").height("100%").backgroundColor("#f3f4f5")
        }.tabBar(this.tabBuilder("视频",1,$r("app.media.address_selected"),$r("app.media.address_default")))
        TabContent(){
          Column(){
            Text("商城内容")
          }.width("100%").height("100%").backgroundColor("#f3f4f5")
        }.tabBar(this.tabBuilder("商城",2,$r("app.media.shop_selected"),$r("app.media.shop_default")))
        TabContent(){
          Column(){
            PersonPage()
          }.width("100%").height("100%").backgroundColor("#f3f4f5")
        }.tabBar(this.tabBuilder("人才",3,$r("app.media.person_selected"),$r("app.media.person_default")))
        TabContent(){
          Column(){
            Text("我的内容")
          }.width("100%").height("100%").backgroundColor("#f3f4f5")
        }.tabBar(this.tabBuilder("我的",4,$r("app.media.mine_selected"),$r("app.media.mine_default")))
      }
      .vertical(false)
      .layoutWeight(1)
      .backgroundColor("#fff")
      .onChange((index:number) =>{
        this.currentIndex = index
      })
    }
    .width("100%")
    .height("100%")
    .backgroundColor("#f3f4f5")
    .alignItems(HorizontalAlign.Center)
  }
}