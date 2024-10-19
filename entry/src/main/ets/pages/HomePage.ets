import SearchView from "../views/homeview/SearchView"
import SwiperView from "../views/homeview/SwiperView"
import NavsView from "../views/homeview/NavsView"
import RecommendGoodsView from "../views/homeview/RecommendGoodsView"
import MarqueeView from "../views/homeview/MarqueeView"

@Entry
@Component
export default struct HomePage{
  build() {
    Column(){
      SearchView()
      List(){
        ListItem(){
         Column(){
           SwiperView()
           MarqueeView()
           NavsView()
           RecommendGoodsView()
         }
        }
      }
    }
  }
}