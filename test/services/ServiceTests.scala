package services
import org.scalatest.{FlatSpec, Matchers}


class ServiceTests extends FlatSpec with Matchers {
  "Split function" should "works correctly" in {
    DataService.split(Nil) shouldBe ((Nil, Nil))
    DataService.split(1 :: Nil) shouldBe ((Nil, 1 :: Nil))
    DataService.split(1 :: 2 :: 3 :: Nil) shouldBe ((1 :: Nil, 2 :: 3 :: Nil))

  }

  val fixture: DataService = {
    val fr = (Country("FR", "France"),
      List(
        (Airport(0, "Charle de Gaulle", "FR"), List(Runway(0, 0, "x"), Runway(1, 0, "y")))
      ))

    val vn = (Country("VN", "Vietnam"),
      List(
        (Airport(2, "NoiBai", "VN"), List(Runway(4, 2, "y"), Runway(5, 2, "y"))),
        (Airport(3, "Tan Son Nhat", "VN"), List(Runway(6, 3, "x"), Runway(7, 3, "x")))
      ))

    val us = (Country("US", "United State"),
      List(
        (Airport(4, "Texas", "US"), List(Runway(8, 4, "y"), Runway(9, 4, "y"))),
        (Airport(5, "NewYork", "US"), List(Runway(10, 5, "x"))),
        (Airport(6, "Washington", "US"), List(Runway(10, 5, "y")))
      ))


    val uk = (Country("UK", "United Kingdom"),
      List(
        (Airport(7, "Manchester", "UK"), List(Runway(11, 7, "y"), Runway(12, 7, "y"))),
        (Airport(8, "London", "UK"), List(Runway(13, 8, "x"), Runway(14, 8, "x")))
      ))


    val all = List(fr, vn, us, uk)
    val countries = all.map(_._1)
    val airports = all.flatMap(_._2.map(_._1))
    val runways = all.flatMap(_._2.flatMap(_._2))
    DataService(airports, runways, countries)
  }


  "Search" should "works correctly" in {
    val frSearch = fixture.searchCountry("FR")
    frSearch.size shouldBe 1
    frSearch.head._2.size shouldBe 1

    val vnSearch = fixture.searchCountry("  VietNam   ")
    vnSearch.size shouldBe 1
    vnSearch.head._1.code shouldBe "VN"
    vnSearch.head._2.size shouldBe 2

    val usSearch = fixture.searchCountry("United St")
    usSearch.size shouldBe 1
    usSearch.head._1.code shouldBe "US"

    val notFoundSearch = fixture.searchCountry("Not Exist")
    notFoundSearch.size shouldBe 0

    val multipleFoundSearch = fixture.searchCountry("United")
    multipleFoundSearch.size shouldBe 2

  }

  "report" should "work correctly" in {
    val report = fixture.reports(1)
    report.lowest.size shouldBe 1
    report.highest.size shouldBe 1
    report.highest.head.country.code shouldBe "US"
    report.highest.head.airportCount shouldBe 3
    report.highest.head.runWayTypes shouldBe Set("x", "y")
  }


}
