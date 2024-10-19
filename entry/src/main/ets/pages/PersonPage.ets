import SearchView from "../views/personview/SearchView"
import PersonListView from "../views/personview/PersonListView"

@Entry
@Component
export default struct PersonPage {

  build() {
   Column(){
     SearchView()
     PersonListView()
   }
  }
}