@Component
export default struct NavsView{

  @Builder gridItemView(text:string,icon:Resource){
    GridItem(){
      Column(){
        Image(icon).width(45)
        Text(text).padding({ top:10 })
      }
    }
  }

  build() {
    Column(){
      // 网格
      Grid(){
        this.gridItemView("出租转让",$r("app.media.nav1"))
        this.gridItemView("求职招聘",$r("app.media.nav2"))
        this.gridItemView("流行产品",$r("app.media.nav3"))
        this.gridItemView("培训课程",$r("app.media.nav4"))
        this.gridItemView("批发进货",$r("app.media.nav5"))
      }
      .columnsTemplate("1fr 1fr 1fr 1fr 1fr")
      .rowsGap(15)
    }
    .width("100%")
    .height(100)
    .padding({ top:10,bottom:5,left:5,right:5 })
    .backgroundColor(Color.White)
  }
}