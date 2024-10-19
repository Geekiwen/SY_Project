import { router } from "@kit.ArkUI"
import axios,{ AxiosError, AxiosResponse } from '@ohos/axios'

interface personID{
  id:number
}

interface PersonObj{
  id:number
  image:string
  name:string
  age:string
  price:string
  descs:string
  sex:string
  birthday:string
  education:string
}

interface PersonDetails{
  status:number
  data:PersonObj
}

@Entry
@Component
struct PersonDetailsPage {

  @State visible:Visibility = Visibility.None
  @State scaleValue:number = 1
  @State pinchValue:number = 1

  @State personDetailsData:PersonObj = {
    id:0,
    image:"",
    name:"",
    age:"",
    price:"",
    descs:"",
    sex:"",
    birthday:"",
    education:""
  }

  aboutToAppear(): void {
    const params:personID = router.getParams() as personID
    axios.get<PersonDetails, AxiosResponse<PersonDetails>, null>(`http://iwenwiki.com:3006/api/person/details?id=${ params.id }`)
      .then((res:AxiosResponse<PersonDetails>) =>{
        if(res.data.status == 200) {
          this.personDetailsData = res.data.data
        }
      })
      .catch((error:AxiosError)=>{
        // 错误信息处理
        console.info("axios-data",JSON.stringify(error));
      })
  }

  build() {
    Stack(){
      Column(){
        Stack({ alignContent:Alignment.Start }){
          Row(){
            Image($r("app.media.back")).width(20)
            Text("返回")
          }
          .padding({ left:10 })
          .width(80)
          .justifyContent(FlexAlign.Start)
          .zIndex(2)
          .onClick(() =>{
            router.back()
          })
          Text("人才详情")
            .textAlign(TextAlign.Center)
            .fontSize(16)
            .fontWeight(500)
            .width("100%")
            .zIndex(1)
        }
        .width("100%")
        .height(50)
        .backgroundColor(Color.White)
        .border({ width:{ bottom:1 },color:"#f3f4f5" })

        Row(){
          Image(this.personDetailsData.image)
            .width(100)
            .height(160)
            .borderRadius(5)
            .onClick(() =>{
              if(this.visible == Visibility.Visible){
                this.visible = Visibility.None
              }else{
                this.visible = Visibility.Visible
              }
            })
          Column(){
            Text(this.personDetailsData.name).fontSize(18).fontWeight(500)
            Row(){
              Text(this.personDetailsData.sex + " | ").fontColor("#999")
              Text(this.personDetailsData.age + " | ").fontColor("#999")
              Text(this.personDetailsData.birthday + " | ").fontColor("#999")
              Text(this.personDetailsData.education).fontColor("#999")
            }
            Text("工作经验：" + this.personDetailsData.age+"年")
            Text("薪资待遇："+this.personDetailsData.price+"元/月").fontColor("#f44")
          }
          .width("100%")
          .height(160)
          .alignItems(HorizontalAlign.Start)
          .justifyContent(FlexAlign.SpaceAround)
          .padding(10)
        }
        .width("100%")
        .padding(10)
        .backgroundColor(Color.White)

        Column(){
          Text("个人简介").fontSize(16).fontWeight(500)
          Text(this.personDetailsData.descs).fontColor("#999").margin({ top:5 })
        }
        .margin({ top:10,bottom:10 })
        .padding(10)
        .backgroundColor(Color.White)
        .alignItems(HorizontalAlign.Start)

        Column(){
          Button("立即联系").width("80%")
        }
      }
      .width("100%").height("100%").backgroundColor("#f3f4f5")

      // 蒙版
      Text("")
        .width("100%")
        .height("100%")
        .opacity(0.8)
        .backgroundColor(0x000000)
        // 是否显示
        .visibility(this.visible)
        .onClick(() =>{
          if(this.visible == Visibility.Visible){
            this.visible = Visibility.None
          }else{
            this.visible = Visibility.Visible
          }
        })

      Column(){
        Image(this.personDetailsData.image)
          .width(200)
          .height(320)
          .visibility(this.visible)
          .scale({ x:this.scaleValue,y:this.scaleValue,z:1 })
          // 添加双指手势
          .gesture(
            PinchGesture({ fingers:2 })
              .onActionStart((event:GestureEvent)=>{
                console.log("fingers-num","手势开始")
              })
              .onActionUpdate((event:GestureEvent) =>{
                if(event){
                  this.scaleValue = this.pinchValue * event.scale
                }
              })
              .onActionEnd(() =>{
                this.pinchValue = this.scaleValue
              })
          )
      }
    }
  }
}