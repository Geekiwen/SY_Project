import axios, { AxiosError, AxiosResponse } from "@ohos/axios"
import { PersonListEntity } from "../../entity/PersonListEntity"
import { PersonListDataSource } from "../../model/PersonListDataSource"
import { PullToRefresh } from '@ohos/pulltorefresh'
import { router } from "@kit.ArkUI"


interface personList{
  status:number
  data:PersonListEntity[]
}

@Component
export default struct PersonListView{

  @State personListArr:PersonListDataSource = new PersonListDataSource()
  // 需绑定列表或宫格组件
  private scroller: Scroller = new Scroller();
  @State page:number = 1
  @State moreData:boolean = false

  http(page:number){
    // 增加网络请求获取数据
    axios.get<personList, AxiosResponse<personList>, null>(`http://iwenwiki.com:3006/api/person/list?page=${ page }`)
      .then((res:AxiosResponse<personList>) =>{
        if(res.data.status == 200){
          console.info("axios-data",JSON.stringify(res.data));
          this.personListArr.pushData(res.data.data)
        }else{
          this.moreData = true
        }
      })
      .catch((error:AxiosError)=>{
        // 错误信息处理
        console.info("axios-data",JSON.stringify(error));
      })
  }

  aboutToAppear(): void {
    this.http(1)
  }

  build() {
    Column(){
      PullToRefresh({
        // 必传项，列表组件所绑定的数据
        data:$personListArr,
        // 必传项，需绑定传入主体布局内的列表或宫格组件
        scroller:this.scroller,
        // 必传项，自定义主体布局，内部有列表或宫格组件
        customList: () => {
          // 一个用@Builder修饰过的UI方法
          this.getListView();
        },
        // 可选项，下拉刷新回调
        onRefresh: () => {
          return new Promise<string>((resolve, reject) => {
            // 模拟网络请求操作，请求网络2秒后得到数据，通知组件，变更列表数据
            setTimeout(() => {
              // 重新获取最新的数据  page = 1
              resolve('刷新成功');
            }, 2000);
          });
        },
        // 可选项，上拉加载更多回调
        onLoadMore: () => {
          return new Promise<string>((resolve, reject) => {
            this.page +=1
            this.http(this.page)
            resolve("加载成功")
          });
        },
        customLoad: null,
        customRefresh: null,
      })
    }.margin({ bottom:50 }).backgroundColor("#fff")
  }

  @Builder private getListView(){
    List({ scroller:this.scroller }){
      LazyForEach(this.personListArr,(item:PersonListEntity)=>{
        ListItem(){
          Row(){
            Image(item.image).width(100).borderRadius(5)
            Column(){
              Text(item.name).fontWeight(500).fontSize(18)
              Text("工作经验：" + item.age).fontSize(14).fontColor("#999").margin({ bottom:15 })
              Text(item.price +"元/月").fontSize(14).fontColor("#f44").margin({ bottom:10 })
              Text(item.descs).fontSize(14).fontColor("#999")
            }
            .padding({ left:10,right:10 })
            .alignItems(HorizontalAlign.Start)
          }
        }.padding(10).onClick(()=>{
          router.pushUrl({
            url:"pages/PersonDetailsPage",
            params:{
              id:item.id
            }
          })
        })
      })
      if(this.moreData){
        ListItem(){
          Text("被你看光了~")
            .fontSize(20)
            .fontColor("#999")
            .textAlign(TextAlign.Center)
            .margin({ top:10,bottom:10 })
        }.width("100%")
      }
    }
    .edgeEffect(EdgeEffect.None)
  }
}