@Component
export default struct  SearchView{
  build() {
    Column(){
      Row(){
        Flex({ direction:FlexDirection.Row,alignItems:ItemAlign.Center }){
          Text("沈阳").width(40)
          TextInput({ placeholder:"请输入要搜索的内容" }).margin({ left:5,right:5 }).padding({ left:10 })
          Image($r("app.media.cart")).width(30).height(30)
        }
      }
    }
    .width("100%")
    .padding(5)
  }
}