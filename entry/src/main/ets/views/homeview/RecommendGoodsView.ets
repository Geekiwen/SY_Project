import axios, { AxiosError, AxiosResponse } from "@ohos/axios"
import { router } from "@kit.ArkUI"

interface recommendGoods{
  id:number
  image:string
  title:string
  price:string
}

interface recommend{
  status:number
  data:recommendGoods[]
}

@Component
export default struct RecommendGoodsView{

    @State recommendGoodsData:recommendGoods[] = []

    aboutToAppear(): void {
      axios.get<recommend, AxiosResponse<recommend>, null>("http://iwenwiki.com:3006/api/recommendgoods")
        .then((res:AxiosResponse<recommend>) =>{
          if(res.data.status == 200){
            this.recommendGoodsData = res.data.data
          }
        })
        .catch((error:AxiosError)=>{
          // 错误信息处理
          console.info("axios-data",JSON.stringify(error));
        })
    }

    build() {
      List(){
        ForEach(this.recommendGoodsData,(item:recommendGoods,index:number) =>{
          ListItem(){
            Column(){
              Row(){
                Image(item.image).width(120).height(120).borderRadius(10)
                Column(){
                  Text(item.title).margin({ bottom:20 }).fontSize(14)
                  Text("￥"+item.price).fontSize(20).fontColor(Color.Red)
                }
                .alignItems(HorizontalAlign.Start)
                .justifyContent(FlexAlign.SpaceAround)
                .padding({ left:5 })
              }
              .onClick(() =>{
                router.pushUrl({
                  url:"pages/HomeGoodsDetailsPage",
                  params:{
                    id:item.id
                  }
                })
              })
            }
          }
          .margin({ bottom:10 })
        })
      }
      .padding({ left:10,top:10,right:0,bottom:50 })
      .margin({ top:10,bottom:10 })
      .backgroundColor(Color.White)
    }
}