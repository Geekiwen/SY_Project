import axios, { AxiosError, AxiosResponse } from "@ohos/axios"

interface swiperItem{
  image:string
  url:string
  title:string
}

interface banner{
  status:number
  data:swiperItem[]
}

@Component
export default struct SwiperView{

  @State bannerArr:swiperItem[] = []

  // 生命周期函数：自动执行
  aboutToAppear(): void {
    // localhost和127.0.0.1 目前鸿蒙无法识别，需要修改为本机ip地址
    axios.get<banner, AxiosResponse<banner>, null>("http://iwenwiki.com:3006/api/banner")
      .then((res:AxiosResponse<banner>) =>{
        if(res.data.status == 200){
          this.bannerArr = res.data.data
        }
      })
      .catch((error:AxiosError)=>{
        // 错误信息处理
        console.info("axios-data",JSON.stringify(error));
      })
  }

  build() {
    Column(){
      Swiper(){
        ForEach(this.bannerArr,(item:swiperItem,index:number)=>{
          Image(item.image).width("100%")
        })
      }
      .loop(true)
      .autoPlay(true)
      .interval(5000)
      .indicator(Indicator.dot())
      .vertical(false)
    }
  }
}