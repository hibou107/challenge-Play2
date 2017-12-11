package controllers

import play.api.libs.json.{JsString, JsValue, _}
import play.api.mvc._
import services.DataSource
import services.JsonSerializers._


class HomeController extends Controller {

  def index: Action[AnyContent] = Action {
    Ok("Hello")
  }

  def search(): Action[JsValue] = Action(parse.json) { request: Request[JsValue] =>
    request.body match {
      case JsString(searchText) => Ok(Json.toJson(DataSource.dataSource.searchCountry(searchText)))
      case x => BadRequest(s"Request $x is invalid")
    }
  }

  def report() = Action {
    val result = DataSource.dataSource.reports(10)
    val json = Json.toJson(result)
    Ok(json)
  }


}
