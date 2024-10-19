import { router } from '@kit.ArkUI';
import axios, { AxiosError, AxiosResponse } from "@ohos/axios"

interface details{
  id:number
  image:string
  title:string;
  price:string
}

interface goodsDetails{
  status:number
  data:details
}

interface paramsObj{
  id:number
}

@Entry
@Component
struct HomeGoodsDetailsPage{

  @State goodsDetailsData:details = {
    id:0,
    image:"",
    title:"",
    price:""
  }

  aboutToAppear(): void {
    const params:paramsObj = router.getParams() as paramsObj
    axios.get<goodsDetails, AxiosResponse<goodsDetails>, null>(`http://iwenwiki.com:3006/api/goods/details?id=${ params.id }`)
      .then((res:AxiosResponse<goodsDetails>) =>{
        if(res.data.status == 200){
          this.goodsDetailsData = res.data.data
        }
      })
      .catch((error:AxiosError)=>{
        // 错误信息处理
        console.info("axios-data",JSON.stringify(error));
      })
  }
  build() {
    Column(){
      Text("商品详情页")
      Image(this.goodsDetailsData.image).width("100%")
    }
  }
}